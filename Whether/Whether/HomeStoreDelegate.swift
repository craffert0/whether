// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import HomeKit

@MainActor
final class HomeStoreDelegate: NSObject, Sendable {
    private let delegate: HomeUpdateProtocol
    private let mgr = HMHomeManager()
    private var item: Item?

    init(delegate: HomeUpdateProtocol) {
        self.delegate = delegate
        super.init()
    }

    func start() {
        mgr.delegate = self
    }

    struct Item {
        let device: HMAccessory
        private let temperatureC: HMCharacteristic
        private let humidityC: HMCharacteristic
        private let lowBatteryC: HMCharacteristic
        private let weatherTrendC: HMCharacteristic

        init?(from manager: HMHomeManager) {
            guard let device = manager.eve,
                  let temperatureC = device.eveTemperature,
                  let humidityC = device.eveHumidity,
                  let lowBatteryC = device.eveLowBattery,
                  let weatherTrendC = device.eveWeatherTrend
            else { return nil }

            self.device = device

            self.temperatureC = temperatureC
            self.humidityC = humidityC
            self.lowBatteryC = lowBatteryC
            self.weatherTrendC = weatherTrendC
        }

        func readValues() async throws {
            try await temperatureC.readValue()
            try await humidityC.readValue()
            try await lowBatteryC.readValue()
            try await weatherTrendC.readValue()
        }

        func enableNotifications() async throws {
            try await temperatureC.enableNotification(true)
            try await humidityC.enableNotification(true)
            try await lowBatteryC.enableNotification(true)
            try await weatherTrendC.enableNotification(true)
        }

        func nextReading() -> HomeModel? {
            if let temperature = temperatureC.temperature,
               let humidity = humidityC.humidity
            {
                .init(temperature: temperature,
                      humidity: humidity,
                      lowBattery: ((lowBatteryC.value as? NSNumber) ?? 0) != 0,
                      weatherTrend: weatherTrendC.weatherTrend)
            } else {
                nil
            }
        }
    }
}

extension HomeStoreDelegate: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ mgr: HMHomeManager) {
        item = Item(from: mgr)
        guard let item else { return }

        Task {
            do {
                try await item.readValues()
                if let model = item.nextReading() {
                    Task { @MainActor in
                        delegate.didUpdate(home: .loaded(model))
                    }
                }
                item.device.delegate = self
                try await item.enableNotifications()
            } catch {
                Task { @MainActor in
                    delegate.didUpdate(home: .failed(error))
                }
            }
        }
    }
}

extension HomeStoreDelegate: @preconcurrency HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor _: HMCharacteristic)
    {
        if let model = item?.nextReading() {
            Task { @MainActor in
                delegate.didUpdate(home: .loaded(model))
            }
        }
    }
}

//   for s in device.services {
//       print("  \(s.name) \(s.isPrimaryService ? "y" : "n")/\(s.isUserInteractive ? "y" : "n"): \(s.serviceType.serviceTypeReadable ?? s.serviceType)")
//       for c in s.characteristics {
//           print("   \(c.localizedDescription): \(c.characteristicType.characteristicTypeReadable ?? c.characteristicType): \(c.properties.map { $0.dropFirst(24) })")

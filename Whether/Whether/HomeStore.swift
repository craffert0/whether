// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class HomeStore: NSObject {
    private let mgr = HMHomeManager()
    private var eve: HMAccessory?
    private var temperatureC: HMCharacteristic?
    private var humidityC: HMCharacteristic?

    struct Reading {
        let temperature: Measurement<UnitTemperature>
        let humidity: Measurement<UnitPercent>
    }

    var error: HomeError?
    var readings = Series<Reading>()
    var temperature: Measurement<UnitTemperature>?
    var humidity: Measurement<UnitPercent>?

    override init() {
        super.init()
        mgr.delegate = self
    }

    @MainActor
    private func setupEve(_ mgr: HMHomeManager) async throws {
        guard eve == nil else { return }

        guard let eve = mgr.eve,
              let temperatureC = eve.eveTemperature,
              let humidityC = eve.eveHumidity
        else {
            throw HomeError(text: "no eve")
        }

        self.eve = eve
        self.temperatureC = temperatureC
        self.humidityC = humidityC
        try await temperatureC.readValue()
        try await humidityC.readValue()
        nextReading()
        eve.delegate = self
        try await temperatureC.enableNotification(true)
        try await humidityC.enableNotification(true)
    }

    @MainActor
    private func nextReading() {
        guard let temperature = temperatureC?.temperature,
              let humidity = humidityC?.humidity
        else { return }
        self.temperature = temperature
        self.humidity = humidity
        readings.add(item: Reading(temperature: temperature,
                                   humidity: humidity))
    }
}

extension HomeStore: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ mgr: HMHomeManager) {
        Task { @MainActor in
            do {
                try await setupEve(mgr)
            } catch let error as HomeError {
                self.error = error
            } catch {
                self.error = HomeError(text: "\(error)")
            }
        }
    }
}

extension HomeStore: HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor _: HMCharacteristic)
    {
        Task { @MainActor in
            nextReading()
        }
    }
}

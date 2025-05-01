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
        let humidity: Double
    }

    var readings = Series<Reading>()
    var temperature: Measurement<UnitTemperature>?
    var humidity: Double?

    override init() {
        super.init()
        mgr.delegate = self
    }

    @MainActor
    private func nextReading() {
        guard let temperature = temperatureC?.temperature,
              let humidity = (humidityC?.value as? NSNumber)?.doubleValue
        else { return }
        self.temperature = temperature
        self.humidity = humidity
        readings.add(item: Reading(temperature: temperature,
                                   humidity: humidity))
    }
}

extension HomeStore: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ mgr: HMHomeManager) {
        guard let eve = mgr.eve,
              let temperatureC = eve.eveTemperature,
              let humidityC = eve.eveHumidity
        else { return }
        Task { @MainActor in
            self.eve = eve
            self.temperatureC = temperatureC
            self.humidityC = humidityC
            nextReading()
            eve.delegate = self
            try? await temperatureC.enableNotification(true)
            try? await humidityC.enableNotification(true)
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

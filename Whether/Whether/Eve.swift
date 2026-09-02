// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class Eve: NSObject {
    var temperature: Measurement<UnitTemperature>?
    var humidity: Measurement<UnitPercent>?

    private let actual: HMAccessory
    private let temperatureC: HMCharacteristic
    private let humidityC: HMCharacteristic

    @MainActor
    init?(from manager: HMHomeManager) async throws {
        guard let actual = manager.eve,
              let temperatureC = actual.eveTemperature,
              let humidityC = actual.eveHumidity
        else { return nil }

        self.actual = actual
        self.temperatureC = temperatureC
        self.humidityC = humidityC

        super.init()

        try await self.temperatureC.readValue()
        try await self.humidityC.readValue()

        nextReading()

        self.actual.delegate = self

        try await self.temperatureC.enableNotification(true)
        try await self.humidityC.enableNotification(true)
    }

    @MainActor
    private func nextReading() {
        temperature = temperatureC.temperature ?? temperature
        humidity = humidityC.humidity ?? humidity
    }
}

extension Eve: HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor _: HMCharacteristic)
    {
        Task { @MainActor in
            nextReading()
        }
    }
}

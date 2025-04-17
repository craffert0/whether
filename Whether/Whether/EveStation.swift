// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class EveStation: NSObject {
    static let eveId =
        UUID(uuidString: "9DC91FA4-8B93-511F-9D6A-984DC36A8B97")!
    private static let temperatureId =
        UUID(uuidString: "2774E641-3C93-5F97-B7E7-380A05A8FF36")!
    private static let humidityId =
        UUID(uuidString: "F04E9AB3-441B-52D7-86EF-32CA69BB5850")!

    private let accessory: HMAccessory
    private var temperatureC: HMCharacteristic
    private var humidityC: HMCharacteristic

    var temperature: Measurement<UnitTemperature>
    var humidity: Double

    init(accessory: HMAccessory) {
        self.accessory = accessory

        let temperatureC = accessory.services.first {
            $0.uniqueIdentifier == EveStation.temperatureId
        }!.characteristics.first {
            $0.characteristicType == HMCharacteristicTypeCurrentTemperature
        }!

        let humidityC = accessory.services.first {
            $0.uniqueIdentifier == EveStation.humidityId
        }!.characteristics.first {
            $0.characteristicType ==
                HMCharacteristicTypeCurrentRelativeHumidity
        }!

        self.temperatureC = temperatureC
        self.humidityC = humidityC
        temperature = temperatureC.temperature
        humidity = (humidityC.value as? NSNumber)!.doubleValue

        super.init()

        self.accessory.delegate = self
    }
}

extension EveStation: HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor _: HMCharacteristic)
    {
        let temperature = temperatureC.temperature
        let humidity = (humidityC.value as? NSNumber)!.doubleValue
        Task { @MainActor in
            self.temperature = temperature
            self.humidity = humidity
        }
    }
}

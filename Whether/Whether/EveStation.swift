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

    struct Reading {
        let temperature: Measurement<UnitTemperature>
        let humidity: Double
    }

    var readings = Series<Reading>()
    var current: Reading? { readings.latest }
    var temperature: Measurement<UnitTemperature>? { current?.temperature }
    var humidity: Double? { current?.humidity }

    init?(accessory: HMAccessory) {
        self.accessory = accessory

        guard let temperatureC =
            accessory.services.first(
                where: {
                    $0.uniqueIdentifier == EveStation.temperatureId
                }
            )?.characteristics.first(
                where: {
                    $0.characteristicType ==
                        HMCharacteristicTypeCurrentTemperature
                }
            ),
            let humidityC =
            accessory.services.first(
                where: {
                    $0.uniqueIdentifier == EveStation.humidityId
                }
            )?.characteristics.first(
                where: {
                    $0.characteristicType ==
                        HMCharacteristicTypeCurrentRelativeHumidity
                }
            )
        else {
            return nil
        }

        self.temperatureC = temperatureC
        self.humidityC = humidityC

        super.init()

        if let reading = next() {
            readings.add(item: reading)
        }

        self.accessory.delegate = self
    }

    private func next() -> Reading? {
        guard let temperature = temperatureC.temperature,
              let humidity = (humidityC.value as? NSNumber)?.doubleValue
        else {
            return nil
        }
        return Reading(temperature: temperature, humidity: humidity)
    }
}

extension EveStation: HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor _: HMCharacteristic)
    {
        if let reading = next() {
            Task { @MainActor in
                self.readings.add(item: reading)
            }
        }
    }
}

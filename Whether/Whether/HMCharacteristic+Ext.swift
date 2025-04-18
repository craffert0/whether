// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMCharacteristic {
    var temperature: Measurement<UnitTemperature>? {
        guard let number = value as? NSNumber else { return nil }
        let celsius = metadata?.units == HMCharacteristicMetadataUnitsCelsius
        return Measurement(value: number.doubleValue,
                           unit: celsius ? .celsius : .fahrenheit)
    }
}

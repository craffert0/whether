// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMAccessory {
    var eveTemperature: HMCharacteristic? {
        services.first(
            where: {
                $0.uniqueIdentifier ==
                    UUID(uuidString:
                        "2774E641-3C93-5F97-B7E7-380A05A8FF36")!
            }
        )?.characteristics.first(
            where: {
                $0.characteristicType ==
                    HMCharacteristicTypeCurrentTemperature
            }
        )
    }

    var eveHumidity: HMCharacteristic? {
        services.first(
            where: {
                $0.uniqueIdentifier ==
                    UUID(uuidString:
                        "F04E9AB3-441B-52D7-86EF-32CA69BB5850")!
            }
        )?.characteristics.first(
            where: {
                $0.characteristicType ==
                    HMCharacteristicTypeCurrentRelativeHumidity
            }
        )
    }
}

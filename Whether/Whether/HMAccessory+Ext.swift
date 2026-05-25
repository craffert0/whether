// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMAccessory {
    var eveTemperature: HMCharacteristic? {
        services.first(
            where: {
                $0.uniqueIdentifier ==
                    UUID(uuidString:
                        "DBC9B686-F026-59C4-BE37-FF9909F548EA")!
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
                        "062DF9DF-3BDC-5AB5-917E-036BADEE1219")!
            }
        )?.characteristics.first(
            where: {
                $0.characteristicType ==
                    HMCharacteristicTypeCurrentRelativeHumidity
            }
        )
    }
}

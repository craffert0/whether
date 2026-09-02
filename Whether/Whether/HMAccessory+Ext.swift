// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMAccessory {
    var eveTemperature: HMCharacteristic? {
        services.first(
            where: {
                $0.serviceType == HMServiceTypeTemperatureSensor
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
                $0.serviceType == HMServiceTypeHumiditySensor
            }
        )?.characteristics.first(
            where: {
                $0.characteristicType ==
                    HMCharacteristicTypeCurrentRelativeHumidity
            }
        )
    }
}

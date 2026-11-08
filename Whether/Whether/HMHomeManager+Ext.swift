// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMHomeManager {
    var eve: HMAccessory? {
        for h in homes {
            for a in h.accessories {
                if a.uniqueIdentifier ==
                    UUID(uuidString:
                        "87FC6D7A-6FF3-5F4B-BF20-64A60CB11071")!
                {
                    return a
                }
            }
        }
        return nil
    }
}

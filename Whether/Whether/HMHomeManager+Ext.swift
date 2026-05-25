// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMHomeManager {
    var eve: HMAccessory? {
        for h in homes {
            for a in h.accessories {
                if a.uniqueIdentifier ==
                    UUID(uuidString:
                        "C24AEADC-584E-5507-AA1F-80873E2F5044")!
                {
                    return a
                }
            }
        }
        return nil
    }
}

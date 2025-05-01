// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit

extension HMHomeManager {
    var eve: HMAccessory? {
        for h in homes {
            for a in h.accessories {
                if a.uniqueIdentifier ==
                    UUID(uuidString:
                        "9DC91FA4-8B93-511F-9D6A-984DC36A8B97")!
                {
                    return a
                }
            }
        }
        return nil
    }
}

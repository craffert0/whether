// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class HomeStore: NSObject {
    let mgr = HMHomeManager()
    var eve: EveStation?

    override init() {
        super.init()
        mgr.delegate = self
    }
}

extension HomeStore: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_: HMHomeManager) {
        for h in mgr.homes {
            for a in h.accessories {
                if a.uniqueIdentifier == EveStation.eveId {
                    Task { @MainActor in
                        eve = EveStation(accessory: a)
                    }
                }
            }
        }
    }
}

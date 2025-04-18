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
    func homeManagerDidUpdateHomes(_ mgr: HMHomeManager) {
        if let eve = HomeStore.findEve(from: mgr) {
            Task { @MainActor in
                self.eve = eve
            }
        }
    }

    private static func findEve(from mgr: HMHomeManager) -> EveStation? {
        for h in mgr.homes {
            for a in h.accessories {
                if a.uniqueIdentifier == EveStation.eveId {
                    return EveStation(accessory: a)
                }
            }
        }
        return nil
    }
}

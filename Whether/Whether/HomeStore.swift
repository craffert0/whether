// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class HomeStore: NSObject {
    private let mgr = HMHomeManager()

    var eve: Eve?
    var state: HomeStoreState = .begin
    var error: HomeError?

    override init() {
        super.init()
        mgr.delegate = self
    }
}

extension HomeStore: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ mgr: HMHomeManager) {
        Task { @MainActor in
            guard eve == nil else { return }
            do {
                eve = try await Eve(from: mgr)
                state = .active
                await eve?.dump()
            } catch let error as HomeError {
                self.error = error
            } catch {
                self.error = HomeError(error: error, state: state)
            }
        }
    }
}

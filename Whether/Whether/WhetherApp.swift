// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

@main
struct WhetherApp: App {
    private let model = WhetherModel(service: WhetherKitService())
    private let locationManagerDelegate: LocationManagerDelegate
    private let homeStoreDelegate: HomeStoreDelegate

    init() {
        locationManagerDelegate = .init(delegate: model)
        homeStoreDelegate = .init(delegate: model)
        locationManagerDelegate.start()
        homeStoreDelegate.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
        }
    }
}

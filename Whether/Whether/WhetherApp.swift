// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

@main
struct WhetherApp: App {
    private let homeStore = HomeStore()
    private let model = WhetherModel(service: WhetherKitService())
    private let locationManagerDelegate: LocationManagerDelegate

    init() {
        locationManagerDelegate = .init(delegate: model)
        locationManagerDelegate.start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .environment(homeStore)
        }
    }
}

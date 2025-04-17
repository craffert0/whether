// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

@main
struct WhetherApp: App {
    @State private var model = WhetherModel()
    @State private var homeStore = HomeStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
                .environment(homeStore)
        }
    }
}

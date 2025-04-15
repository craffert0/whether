// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct ContentView: View {
    let homeStore: HomeStore

    var body: some View {
        VStack {
            WhetherView(homeStore: homeStore)
        }
        .padding()
    }
}

#Preview {
    ContentView(homeStore: HomeStore())
}

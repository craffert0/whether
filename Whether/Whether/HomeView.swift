// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeView: View {
    @State var store: HomeStore

    var body: some View {
        if let eve = store.eve {
            Text("Home \(eve.temperature.whether) \(Int(eve.humidity))%")
                .font(.subheadline)
        }
    }
}

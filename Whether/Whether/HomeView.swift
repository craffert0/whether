// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeView: View {
    @State var store: HomeStore

    var body: some View {
        if let c = store.eve?.current {
            Text("Home \(c.temperature.whether) \(Int(c.humidity))%")
                .font(.subheadline)
        }
    }
}

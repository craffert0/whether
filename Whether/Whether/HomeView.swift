// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeView: View {
    @State var store: HomeStore

    var body: some View {
        if let eve = store.eve {
            if let temperature = eve.temperature, let humidity = eve.humidity {
                Text("Home \(temperature.whether) \(Int(humidity))%")
                    .font(.subheadline)
            }
        }
    }
}

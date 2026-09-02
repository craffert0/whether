// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeView: View {
    @Environment(HomeStore.self) private var store
    @State private var isErrorPresented: Bool = false

    var body: some View {
        if let error = store.error {
            Button("error") {
                isErrorPresented = true
            }.sheet(isPresented: $isErrorPresented) {
                Text(error.localizedDescription).padding()
            }
        } else if let temperature = store.eve?.temperature,
                  let humidity = store.eve?.humidity
        {
            HStack {
                if store.eve?.lowBattery ?? false {
                    Image(systemName: "battery.25percent")
                        .foregroundStyle(.red)
                }
                if let systemName = store.eve?.weatherTrend?.systemName {
                    Image(systemName: systemName)
                }
                Text("\(temperature.whether) \(humidity.whether)")
                    .font(.subheadline)
            }
        }
    }
}

// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeView: View {
    @Environment(HomeStore.self) private var store
    @State private var isErrorPresented: Bool = false

    var body: some View {
        if let error = store.error {
            Button(error.state.rawValue) {
                isErrorPresented = true
            }.sheet(isPresented: $isErrorPresented) {
                Text(error.error.localizedDescription).padding()
            }
        } else if let temperature = store.temperature,
                  let humidity = store.humidity
        {
            Text("Home \(temperature.whether) \(humidity.whether)")
                .font(.subheadline)
        } else {
            Text(store.state.rawValue)
        }
    }
}

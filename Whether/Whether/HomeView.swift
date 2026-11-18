// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import SwiftUIUtil
import SwiftUtil

struct HomeView: View {
    let home: LoadingState<HomeModel, Error>
    @State private var isErrorPresented: Bool = false

    var body: some View {
        if let model = home.value {
            eveView(model)
        } else if let error = home.error {
            errorView(error)
        }
    }

    private func eveView(_ model: HomeModel) -> some View {
        HStack {
            if let systemName = model.weatherTrend?.systemName {
                Image(systemName: systemName)
            }
            Text("\(model.temperature.whether) \(model.humidity.whether)")
                .font(.subheadline)
            if model.lowBattery ?? false {
                Image(systemName: "battery.25percent")
                    .foregroundStyle(.red)
            }
        }
    }

    private func errorView(_ error: Error) -> some View {
        Button("error") {
            isErrorPresented = true
        }.sheet(isPresented: $isErrorPresented) {
            Text(error.localizedDescription).padding()
        }
    }
}

#Preview("basic") {
    VStack {
        HomeView(home: .loaded(.init(
            temperature: .init(value: 18.5,
                               unit: .celsius),
            humidity: .init(value: 42,
                            unit: .percent)
        )))
    }
}

#Preview("low") {
    VStack {
        HomeView(home: .loaded(.init(
            temperature: .init(value: 18.5,
                               unit: .celsius),
            humidity: .init(value: 42,
                            unit: .percent),
            lowBattery: true
        )))
    }
}

#Preview("rainy") {
    VStack {
        HomeView(home: .loaded(.init(
            temperature: .init(value: 18.5,
                               unit: .celsius),
            humidity: .init(value: 42,
                            unit: .percent),
            weatherTrend: .rain5
        )))
    }
}

#Preview("both") {
    VStack {
        HomeView(home: .loaded(.init(
            temperature: .init(value: 18.5,
                               unit: .celsius),
            humidity: .init(value: 42,
                            unit: .percent),
            lowBattery: true,
            weatherTrend: .rain5
        )))
    }
}

#Preview("error") {
    VStack {
        HomeView(home: .failed(CancellationError()))
    }
}

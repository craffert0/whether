// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct ContentView: View {
    @State var model: WhetherModel
    @State private var isDebugPresented: Bool = false

    var body: some View {
        ZStack {
            mainView
            infoView
        }
        .onShake {
            model.refresh()
        }
        .sheet(isPresented: $isDebugPresented) {
            debugView
        }
        .padding()
    }

    @ViewBuilder
    private var mainView: some View {
        if let w = model.weather {
            WhetherView(w: w, home: model.home)
        } else {
            noWhetherView
        }
    }

    private var noWhetherView: some View {
        VStack {
            HomeView(home: model.home)
            Spacer()
            BigImage(
                systemName: "\(model.location == nil ? "location" : "bolt").slash",
                size: 120
            )
            Spacer()
        }
    }

    private var infoView: some View {
        Button {
            isDebugPresented = true
        } label: {
            Label("", systemImage: "info.circle")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,
               alignment: .topTrailing)
    }

    private var debugView: some View {
        TabView {
            Tab("Weather", systemImage: "sunrise") {
                WhetherDebugView(model: model)
            }
            Tab("Home", systemImage: "apple.homekit") {
                HomeDebugView(model: model)
            }
            Tab("Location", systemImage: "map") {
                LocationDebugView(model: model)
            }
        }
    }
}

#Preview("nothing") {
    VStack {
        ContentView(model: .init(service: MockWhetherService()))
    }
}

#Preview("location only") {
    VStack {
        ContentView(
            model: {
                let model = WhetherModel(service: MockWhetherService())
                model.locations.add(item: .init(latitude: 40.67,
                                                longitude: -73.97))
                return model
            }()
        )
    }
}

#Preview("home only") {
    VStack {
        ContentView(
            model: {
                let model = WhetherModel(service: MockWhetherService())
                model.homes.add(item: .loaded(.rainy))
                return model
            }()
        )
    }
}

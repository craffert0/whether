// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeDebugView: View {
    @State var model: WhetherModel

    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    Text("time")
                    Text("weather")
                }
                ForEach(model.homes.elements.reversed()) { e in
                    GridRow {
                        Text(e.time.plain_time)
                        HomeView(home: e.item)
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        HomeDebugView(
            model: {
                let model = WhetherModel(service: MockWhetherService())
                model.homes.add(item: .failed(CancellationError()))
                model.homes.add(item: .loaded(.basic))
                model.homes.add(item: .loaded(.low))
                model.homes.add(item: .loaded(.rainy))
                model.homes.add(item: .loaded(.both))
                return model

            }()
        )
    }
}

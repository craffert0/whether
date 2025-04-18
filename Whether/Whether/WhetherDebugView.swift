// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct WhetherDebugView: View {
    @Environment(WhetherModel.self) private var model

    var body: some View {
        ScrollView {
            Grid {
                GridRow {
                    Text("request")
                    Text("forecast")
                }
                ForEach(model.weathers.elements.reversed()) { e in
                    GridRow {
                        Text(e.time.plain_time)
                        Text(e.item.currentWeather.date.plain_time)
                        Image(systemName: e.item.currentWeather.symbolName)
                        Text(e.item.currentWeather.temperature.whether)
                    }
                }
            }
        }
    }
}

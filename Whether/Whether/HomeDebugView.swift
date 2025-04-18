// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct HomeDebugView: View {
    @Environment(HomeStore.self) private var homeStore

    var body: some View {
        if let eve = homeStore.eve {
            ScrollView {
                Grid {
                    ForEach(eve.readings.elements.reversed()) { e in
                        GridRow {
                            Text(e.time.plain_time)
                            Text(e.item.temperature.whether)
                            Text("\(Int(e.item.humidity))%")
                        }
                    }
                }
            }
        } else {
            Text("no eve")
        }
    }
}

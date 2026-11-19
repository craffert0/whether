// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct ContentView: View {
    let model: WhetherModel

    var body: some View {
        VStack {
            WhetherView(model: model)
        }
        .padding()
    }
}

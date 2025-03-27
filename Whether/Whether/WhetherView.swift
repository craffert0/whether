// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI

struct WhetherView: View {
    @State var model = WhetherModel()

    var body: some View {
        VStack {
            if let w = model.weather {
                CurrentWeatherView(with: w.currentWeather)
            } else {
                Text("no location 😢")
            }
        }
    }
}

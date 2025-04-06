// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    var w: CurrentWeather

    init(with w: CurrentWeather) {
        self.w = w
    }

    var body: some View {
        VStack {
            Image(systemName: w.symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Text(w.temperature.whether).font(.largeTitle)
        }
    }
}

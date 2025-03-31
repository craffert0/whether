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
        HStack {
            let c = w.condition.description
            let t = w.temperature.whether
            Image(systemName: w.symbolName)
            Text("\(t) \(c)")
        }
    }
}

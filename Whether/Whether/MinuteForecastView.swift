// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct MinuteForecastView: View {
    var f: Forecast<MinuteWeather>

    init(with f: Forecast<MinuteWeather>) {
        self.f = f
    }

    var body: some View {
        if f.summary != "" {
            Text(f.summary)
        }
    }
}

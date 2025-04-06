// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct DayView: View {
    var tag: String
    var m: DayPartForecast

    init(_ tag: String, for m: DayPartForecast) {
        self.tag = tag
        self.m = m
    }

    var body: some View {
        HStack {
            Text(tag)
            Text("\(m.highTemperature.whether)/\(m.lowTemperature.whether)")
            Text(m.condition.description)
        }
    }
}

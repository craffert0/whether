// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct CurrentWeatherView: View {
    var w: CurrentWeather
    @State private var isDetailPresented: Bool = false

    init(with w: CurrentWeather) {
        self.w = w
    }

    var body: some View {
        VStack {
            Image(systemName: w.symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            Button {
                isDetailPresented = true
            } label: {
                Text(w.temperature.whether).font(.largeTitle)
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $isDetailPresented) {
                detailView
            }
        }
    }

    private var detailView: some View {
        Grid {
            Text(w.condition.description)
            GridRow {
                Text("Temperature")
                Text(w.temperature.whether)
            }
            GridRow {
                Text("Feels like")
                Text(w.apparentTemperature.whether)
            }
            GridRow {
                Text("Dew point")
                Text(w.dewPoint.whether)
            }
            GridRow {
                Text("Humidity")
                Text("\(Int(100 * w.humidity))%")
            }
        }
    }
}

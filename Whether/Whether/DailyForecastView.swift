// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation
import SwiftUI
import WeatherKit

extension DayWeather: @retroactive Identifiable {
    public var id: Date { date }
}

struct DailyForecastView: View {
    var f: Forecast<DayWeather>

    init(with f: Forecast<DayWeather>) {
        self.f = f
    }

    var body: some View {
        VStack {
            if Calendar.current.component(.hour, from: Date.now) < 18 {
                DayView("Today", for: f[0].restOfDayForecast!)
            } else {
                DayView("Overnight", for: f[0].overnightForecast)
            }

            // Table(of: DayWeather.self) {
            //     TableColumn("sym") { d in
            //         Image(systemName: d.symbolName)
            //     }
            //     TableColumn("day") { d in
            //         Text(d.date.formatted(Date.FormatStyle().weekday(.short)))
            //     }
            //     TableColumn("temp") { d in
            //         Text("\(d.highTemperature.whether)/\(d.lowTemperature.whether)")
            //     }
            //     TableColumn("desc") { d in
            //         Text(d.condition.description)
            //     }
            // } rows: {
            //     ForEach(f.forecast.dropFirst()) { d in
            //         TableRow(d)
            //     }
            // }

            // Spacer()

            // VStack(alignment: .leading) {
            //     ForEach(f.forecast.dropFirst()) { d in
            //         HStack {
            //             Text(d.date.formatted(Date.FormatStyle().weekday(.short)))
            //             Image(systemName: d.symbolName)
            //             Text("\(d.highTemperature.whether)/\(d.lowTemperature.whether)")
            //             Text(d.condition.description)
            //         }
            //     }
            // }

            // Spacer()

            HStack {
                VStack {
                    ForEach(f.forecast.dropFirst()) { d in
                        HStack {
                            Text(d.date.formatted(Date.FormatStyle().weekday(.short)))
                            Image(systemName: d.symbolName)
                        }
                    }
                }
                VStack {
                    ForEach(f.forecast.dropFirst()) { d in
                        Text("\(d.highTemperature.whether)/\(d.lowTemperature.whether)")
                    }
                }
                VStack {
                    ForEach(f.forecast.dropFirst()) { d in
                        Text(d.condition.description)
                    }
                }
            }
        }
    }
}

// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import Foundation

struct HomeModel {
    let temperature: Measurement<UnitTemperature>
    let humidity: Measurement<UnitPercent>
    let lowBattery: Bool?
    let weatherTrend: EveWeatherTrend?

    init(temperature: Measurement<UnitTemperature>,
         humidity: Measurement<UnitPercent>,
         lowBattery: Bool? = nil,
         weatherTrend: EveWeatherTrend? = nil)
    {
        self.temperature = temperature
        self.humidity = humidity
        self.lowBattery = lowBattery
        self.weatherTrend = weatherTrend
    }
}

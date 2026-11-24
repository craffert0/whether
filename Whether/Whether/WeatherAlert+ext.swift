// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import WeatherKit

extension WeatherAlert {
    struct Pair: Identifiable {
        let id: Int
        let a: WeatherAlert
    }
}

extension [WeatherAlert] {
    var pairs: [WeatherAlert.Pair] {
        enumerated().map { id, a in WeatherAlert.Pair(id: id, a: a) }
    }
}

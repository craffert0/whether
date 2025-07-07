// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation
import WeatherKit

extension CurrentWeather {
    // https://www.omnicalculator.com/physics/wet-bulb#how-to-calculate-the-wet-bulb-temperature
    // https://journals.ametsoc.org/view/journals/apme/50/11/jamc-d-11-0143.1.xml
    var wetBulb: Measurement<UnitTemperature> {
        let T = temperature.converted(to: .celsius).value
        let RH = 100.0 * humidity
        let Tw = T * atan(0.151977 * sqrt(RH + 8.313659))
            + 0.00391838 * pow(RH, 1.5) * atan(0.023101 * RH)
            - atan(RH - 1.676331)
            + atan(T + RH)
            - 4.686035
        return Measurement(value: Tw, unit: .celsius)
    }
}

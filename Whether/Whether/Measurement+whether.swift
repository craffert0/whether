// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation

extension Measurement<UnitTemperature> {
    var whether: String {
        formatted(.measurement(width: .narrow,
                               usage: .weather,
                               numberFormatStyle: .whether))
    }
}

extension Measurement<UnitPercent> {
    var whether: String { "\(Int(value))\(unit.symbol)" }
}

extension Measurement<UnitLength> {
    var distance: String {
        let inches = converted(to: .inches).value
        if inches < 1 {
            return String(format: "%.2f", inches)
        } else {
            return String(Int(inches))
        }
    }

    var whether: String {
        "\(distance) in"
    }

    func whetherRange(through high: Measurement<UnitLength>) -> String {
        "\(distance)-\(high.distance) in"
    }
}

extension Measurement<UnitSpeed> {
    var whether: String {
        let mph = Int(converted(to: .milesPerHour).value)
        return "\(mph) mph"
    }
}

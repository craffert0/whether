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

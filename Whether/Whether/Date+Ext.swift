// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation

extension Date {
    var plain_time: String {
        formatted(
            Date.FormatStyle()
                .hour(.conversationalDefaultDigits(amPM: .abbreviated))
                .minute()
        )
    }

    var wholeText: String {
        formatted(
            Date.FormatStyle()
                .weekday(.wide)
                .month(.wide)
                .day(.twoDigits)
        )
    }
}

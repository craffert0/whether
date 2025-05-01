// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation

class UnitPercent: Unit, @unchecked Sendable {
    static var percent = UnitPercent()

    init() {
        super.init(symbol: "%")
    }

    required convenience init?(coder _: NSCoder) {
        self.init()
    }
}

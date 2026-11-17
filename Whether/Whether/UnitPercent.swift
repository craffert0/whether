// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation

nonisolated class UnitPercent: Unit, @unchecked Sendable {
    static let percent = UnitPercent()

    init() {
        super.init(symbol: "%")
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

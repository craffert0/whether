// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation

extension FloatingPointFormatStyle<Double> {
    static let whether = FloatingPointFormatStyle<Double>().rounded(increment: 1.0)
}

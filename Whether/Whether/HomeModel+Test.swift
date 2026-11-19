// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import Foundation

extension HomeModel {
    static let basic = HomeModel(
        temperature: .init(value: 18.5,
                           unit: .celsius),
        humidity: .init(value: 42,
                        unit: .percent)
    )

    static let low = HomeModel(
        temperature: .init(value: 18.5,
                           unit: .celsius),
        humidity: .init(value: 42,
                        unit: .percent),
        lowBattery: true
    )

    static let rainy = HomeModel(
        temperature: .init(value: 18.5,
                           unit: .celsius),
        humidity: .init(value: 42,
                        unit: .percent),
        weatherTrend: .rain5
    )

    static let both = HomeModel(
        temperature: .init(value: 18.5,
                           unit: .celsius),
        humidity: .init(value: 42,
                        unit: .percent),
        lowBattery: true,
        weatherTrend: .rain5
    )
}

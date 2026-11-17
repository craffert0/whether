// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import WeatherKit

nonisolated struct MockWhetherService: WhetherService {
    var result: Weather?

    func weather(for _: CLLocation) async -> Weather? {
        result
    }
}

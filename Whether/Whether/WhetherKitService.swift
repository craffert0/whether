// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import WeatherKit

nonisolated struct WhetherKitService: WhetherService {
    @concurrent
    func weather(for location: CLLocation) async -> Weather? {
        try? await WeatherService.shared.weather(for: location)
    }
}

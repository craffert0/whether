// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import CoreLocation
@preconcurrency import WeatherKit

extension WeatherService {
    func weather(
        for location: CLLocation,
        _ completion: @escaping (Result<Weather, Error>) -> Void
    ) {
        Task(operation: { try await self.weather(for: location) },
             completion: completion)
    }

    func weather<each T>(
        for location: CLLocation,
        including dataSet: repeat WeatherQuery<each T>,
        completion: @escaping (Result<(repeat each T), Error>) -> Void
    ) {
        Task(operation: {
                 try await self.weather(for: location,
                                        including: repeat each dataSet)
             },
             completion: completion)
    }
}

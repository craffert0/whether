// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import Observation
import WeatherKit

@Observable
@MainActor
final class WhetherModel {
    let service: WhetherService

    var locations = Series<CLLocation>()
    var location: CLLocation? {
        locations.latest
    }

    var weathers = Series<Weather>()
    var weather: Weather? {
        weathers.latest
    }

    init(service: WhetherService) {
        self.service = service
    }

    func refresh() {
        guard let location else { return }
        Task { @MainActor in
            await refresh(for: location)
        }
    }

    private func refresh(for location: CLLocation) async {
        guard let weather = await service.weather(for: location)
        else { return }
        weathers.add(item: weather)
    }
}

extension WhetherModel {
    convenience init(service: WhetherService,
                     locations: Series<CLLocation>)
    {
        self.init(service: service)
        self.locations = locations
    }
}

extension WhetherModel: LocationUpdateProtocol {
    func didUpdate(location: CLLocation) {
        locations.add(item: location)
        Task { @MainActor in
            await refresh(for: location)
        }
    }
}

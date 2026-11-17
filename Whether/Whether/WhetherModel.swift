// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import Observation
import WeatherKit

@Observable
@MainActor
final class WhetherModel: NSObject {
    let service: WhetherService

    private let locationManager = CLLocationManager()
    var locations = Series<CLLocation>()
    var location: CLLocation? {
        locations.latest
    }

    var weathers = Series<Weather>()
    var weather: Weather? {
        weathers.latest
    }

    init(service: WhetherService,
         live: Bool = true)
    {
        self.service = service
        super.init()
        if live {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
        }
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
        self.init(service: service, live: false)
        self.locations = locations
    }
}

extension WhetherModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startMonitoringSignificantLocationChanges()
        default:
            manager.stopMonitoringSignificantLocationChanges()
        }
    }

    func locationManager(_: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else { return }
        self.locations.add(item: location)
        Task { @MainActor in
            await refresh(for: location)
        }
    }
}

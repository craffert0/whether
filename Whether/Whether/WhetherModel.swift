// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import Observation
@preconcurrency import WeatherKit

@Observable
class WhetherModel: NSObject {
    private let locationManager = CLLocationManager()
    var locations = Series<CLLocation>()
    var location: CLLocation? { locations.latest }
    var weathers = Series<Weather>()
    var weather: Weather? { weathers.latest }

    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    func refresh() {
        guard let location else { return }
        refresh(for: location)
    }

    private func refresh(for location: CLLocation) {
        WeatherService.shared.weather(for: location) { result in
            Task { @MainActor in
                switch result {
                case let .success(weather):
                    self.weathers.add(item: weather)
                case let .failure(error):
                    print("error", error.localizedDescription)
                }
            }
        }
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
        refresh(for: location)
        Task { @MainActor in
            self.locations.add(item: location)
        }
    }
}

// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import CoreLocation
import Observation
@preconcurrency import WeatherKit

@Observable
class WhetherModel: NSObject {
    private let locationManager = CLLocationManager()
    private var lastLocation: CLLocation?
    private var weatherService = WeatherService.shared
    var weather: Weather?

    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
}

extension WhetherModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        print("location status: \(status.string)")
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager
                .startMonitoringSignificantLocationChanges()
        default:
            locationManager.stopUpdatingLocation()
        }
    }

    func locationManager(_: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.last else { return }
        guard lastLocation == nil else { return }
        WeatherService.shared.weather(for: location) {
            self.lastLocation = location
            switch $0 {
            case let .success(weather):
                self.weather = weather
            case let .failure(error):
                print("error", error.localizedDescription)
            }
        }
    }

    func locationManager(_: CLLocationManager,
                         didFailWithError error: any Error)
    {
        print("fuck", error.localizedDescription)
    }
}

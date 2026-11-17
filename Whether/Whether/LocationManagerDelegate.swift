// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import CoreLocation

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    private let delegate: LocationUpdateProtocol
    private let locationManager = CLLocationManager()

    init(delegate: LocationUpdateProtocol) {
        self.delegate = delegate
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

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
        Task { @MainActor in
            delegate.didUpdate(location: location)
        }
    }
}

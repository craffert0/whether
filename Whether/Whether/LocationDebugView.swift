// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import MapKit
import SwiftUI

struct LocationDebugView: View {
    @Environment(WhetherModel.self) private var model

    var body: some View {
        VStack {
            map
            list
        }
    }

    var map: some View {
        Map {
            MapPolyline(
                coordinates: model.locations.elements.map(\.item.coordinate)
            )
            .stroke(.blue, lineWidth: 5)

            ForEach(model.locations.elements) { e in
                Marker(e.time.plain_time, coordinate: e.item.coordinate)
            }
        }
    }

    var list: some View {
        ScrollView {
            Grid {
                ForEach(model.locations.elements.reversed()) { e in
                    let c = e.item.coordinate
                    GridRow {
                        Text(e.time.plain_time)
                        Button("\(c.latitude)/\(c.longitude)") {
                            let placemark =
                                MKPlacemark(coordinate: e.item.coordinate)
                            let mapItem = MKMapItem(placemark: placemark)
                            mapItem.name = e.time.plain_time
                            mapItem.openInMaps()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    VStack {
        LocationDebugView()
            .environment(
                WhetherModel(locations: {
                    let locations: Series<CLLocation> = Series()
                    var date = Date.now
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.690208,
                                             longitude: -73.985239)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.685813,
                                             longitude: -73.983899)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.683780,
                                             longitude: -73.978614)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.680206,
                                             longitude: -73.974790)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.676346,
                                             longitude: -73.971717)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.672494,
                                             longitude: -73.970424)
                        ))
                    date = Calendar.current.date(byAdding: .minute, value: -1,
                                                 to: date)!
                    locations.elements.append(
                        Series.Element(
                            time: date,
                            item: CLLocation(latitude: 40.668548,
                                             longitude: -73.973408)
                        ))

                    return locations
                }()))
    }
}

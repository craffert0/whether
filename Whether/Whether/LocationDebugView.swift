// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import MapKit
import SwiftUI

struct LocationDebugView: View {
    @Environment(WhetherModel.self) private var model

    var body: some View {
        map
        list
    }

    var map: some View {
        Map {
            MapPolyline(
                coordinates: model.locations.elements.map(\.item.coordinate)
            )

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
            .environment(WhetherModel())
    }
}

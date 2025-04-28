// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import MapKit
import SwiftUI

struct LocationDebugView: View {
    @Environment(WhetherModel.self) private var model

    var body: some View {
        ScrollView {
            Grid {
                ForEach(model.locations.elements.reversed()) { e in
                    GridRow {
                        Text(e.time.plain_time)
                        Button("\(e.item.coordinate.latitude)/\(e.item.coordinate.longitude)") {
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

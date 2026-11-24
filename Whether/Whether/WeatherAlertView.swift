// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import SwiftUI
import WeatherKit

struct WeatherAlertView: View {
    let alert: WeatherAlert
    @State private var isDetailsPresented = false

    var body: some View {
        Button {
            isDetailsPresented = true
        } label: {
            Label(alert.summary, systemImage: "exclamationmark.triangle.fill")
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $isDetailsPresented) {
            SafariView(url: alert.detailsURL)
        }
    }
}

#Preview {
    let jsonData = """
    {
      "date" : 817227022,
      "issuedDate" : 817194000,
      "detailsURL" : "https://weatherkit.apple.com/alertDetails/index.html?ids=30b6e936-f836-5771-8174-e36ed4c84eac&lang=en-US&timezone=America/New_York",
      "summary" : "High Wind Watch",
      "source" : "National Weather Service",
      "metadata" : {
        "date" : 817227022,
        "latitude" : 40.7130012512207,
        "longitude" : -74.00599670410156,
        "expirationDate" : 817227322,
        "attribution" : {
          "storage" : {
            "combinedMarkDarkURL" : "https://weatherkit.apple.com/assets/branding/combined-mark-dark.png",
            "sourceURL" : "https://weatherkit.apple.com/alertDetails/index.html?ids=30b6e936-f836-5771-8174-e36ed4c84eac&lang=en-US&timezone=America/New_York",
            "combinedMarkLightURL" : "https://weatherkit.apple.com/assets/branding/combined-mark-light.png",
            "serviceName" : "National Weather Service",
            "legalPageURL" : "https://weatherkit.apple.com/legal-attribution.html",
            "squareMarkURL" : "https://weatherkit.apple.com/assets/branding/square-mark.png"
          }
        }
      },
      "description" : "High Wind Watch",
      "onsetTime" : 817398000,
      "severity" : "severe",
      "endDate" : 817452000,
      "id" : "30B6E936-F836-5771-8174-E36ED4C84EAC",
      "importance" : "high",
      "expirationDate" : 817243200
    }
    """.data(using: .utf8)!
    let alert =
        try! JSONDecoder().decode(WeatherAlert.self, from: jsonData)
    VStack {
        WeatherAlertView(alert: alert)
    }
}

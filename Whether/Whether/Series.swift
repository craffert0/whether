// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2025 Colin Rafferty <colin@rafferty.net>

import Foundation
import Observation

@Observable
class Series<T> {
    @Observable
    class Element {
        let time: Date
        let item: T

        init(time: Date, item: T) {
            self.time = time
            self.item = item
        }
    }

    var elements: [Element] = []
    var latest: T? { elements.last?.item }

    func add(item: T) {
        elements.append(Element(time: Date.now, item: item))
    }
}

extension Series.Element: Identifiable {
    var id: Date { time }
}

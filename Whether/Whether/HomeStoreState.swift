// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

enum HomeStoreState: String {
    case begin, noEve, hasEve, hasTemperature, hasHumidity,
         temperatureEnabled, active
}

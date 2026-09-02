// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

// https://gist.github.com/simont77/3f4d4330fa55b83f8ca96388d9004e7d?permalink_comment_id=4456904#gistcomment-4456904

// 1,9 - Sunny
// 3,11 - Sunny/Cloudy
// 4,5,6,7 - Rainy
// 12,13,14,15 - Windy/Rainy

enum EveWeatherTrend: Int {
    case sunny1 = 1
    case sunny9 = 9
    case cloudy3 = 3
    case cloudy11 = 11
    case rain4 = 4
    case rain5 = 5
    case rain6 = 6
    case rain7 = 7
    case wind12 = 12
    case wind13 = 13
    case wind14 = 14
    case wind15 = 15
}

extension EveWeatherTrend {
    var systemName: String {
        switch self {
        case .sunny1, .sunny9: "sun.max"
        case .cloudy3, .cloudy11: "cloud.sun"
        case .rain4, .rain5, .rain6, .rain7: "cloud.rain"
        case .wind12, .wind13, .wind14, .wind15: "wind"
        }
    }
}

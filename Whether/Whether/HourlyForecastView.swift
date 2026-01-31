// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import Foundation
import SwiftUI
import WeatherKit

extension HourWeather: @retroactive Identifiable {
    public var id: Date { date }
}

struct HourlyForecastView: View {
    var h: Forecast<HourWeather>

    var body: some View {
        VStack {
            Text("\(h.metadata.date.plain_time) - \(h.metadata.expirationDate.plain_time)")
            List(h.forecast) { f in
                HStack {
                    Text(f.date.formatted(Date.FormatStyle().weekday(.short)))
                    Text(f.date.plain_time)
                    Image(systemName: f.symbolName)
                    Text("\(f.temperature.whether) / \(f.apparentTemperature.whether)")
                    Text(f.condition.description)
                }
            }
        }
    }
}

#Preview {
    let jsonData = """
    {
      "metadata": {
        "latitude": 40.66999816894531,
        "date": 791046472,
        "expirationDate": 791050072,
        "longitude": -73.97000122070312
      },
      "forecast": [
        {
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "precipitationChance": 0,
          "cloudCoverLow": 0.01,
          "precipitation": "none",
          "condition": "mostlyClear",
          "apparentTemperature": {
            "value": -11.171897888183594,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "cloudCoverByAltitude": {
            "low": 0.01,
            "high": 0.07,
            "medium": 0.33
          },
          "pressureTrend": "rising",
          "symbolName": "moon.stars",
          "isDaylight": false,
          "cloudCoverHigh": 0.07,
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "pressure": {
            "value": 1039.1300048828125,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 100
              },
              "symbol": "mbar"
            }
          },
          "date": 791002800,
          "humidity": 0.41,
          "cloudCoverMid": 0.33,
          "visibility": {
            "value": 50500,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            }
          },
          "dewPoint": {
            "value": -20.035064697265625,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "cloudCover": 0.19,
          "apparentPrecipitationIntensity": {
            "category": "light",
            "value": 0
          },
          "temperature": {
            "value": -9.180000305175781,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "wind": {
            "direction": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              },
              "value": 359
            },
            "speed": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              },
              "value": 7.563600063323975
            },
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 14.641199111938477
            },
            "compassDirection": "north"
          }
        },
        {
          "snowfallAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 0
          },
          "precipitationChance": 0,
          "cloudCoverLow": 0.01,
          "precipitation": "none",
          "condition": "mostlyCloudy",
          "apparentTemperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -10.769283294677734
          },
          "cloudCoverByAltitude": {
            "medium": 0.76,
            "low": 0.01,
            "high": 0.15
          },
          "pressureTrend": "steady",
          "symbolName": "cloud",
          "isDaylight": false,
          "cloudCoverHigh": 0.15,
          "precipitationAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 0
          },
          "pressure": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 100
              },
              "symbol": "mbar"
            },
            "value": 1038.9300537109375
          },
          "date": 791006400,
          "humidity": 0.42,
          "cloudCoverMid": 0.76,
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "constant": 0,
                "coefficient": 1
              }
            },
            "value": 50728
          },
          "dewPoint": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -19.891693115234375
          },
          "cloudCover": 0.66,
          "apparentPrecipitationIntensity": {
            "value": 0,
            "category": "light"
          },
          "temperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -9.329999923706055
          },
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "wind": {
            "compassDirection": "north",
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 7.448400020599365
            },
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 11.653200149536133
            },
            "direction": {
              "value": 6,
              "unit": {
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                },
                "symbol": "°"
              }
            }
          }
        },
        {
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "precipitationChance": 0,
          "cloudCoverLow": 0.02,
          "precipitation": "none",
          "condition": "partlyCloudy",
          "apparentTemperature": {
            "value": -11.199118614196777,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "cloudCoverByAltitude": {
            "low": 0.02,
            "medium": 0.41,
            "high": 0.15
          },
          "pressureTrend": "steady",
          "symbolName": "cloud.moon",
          "isDaylight": false,
          "cloudCoverHigh": 0.15,
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "pressure": {
            "value": 1038.3800048828125,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 100
              },
              "symbol": "mbar"
            }
          },
          "date": 791010000,
          "humidity": 0.44,
          "cloudCoverMid": 0.41,
          "visibility": {
            "value": 49868,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "dewPoint": {
            "value": -19.560302734375,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "cloudCover": 0.43,
          "apparentPrecipitationIntensity": {
            "category": "light",
            "value": 0
          },
          "temperature": {
            "value": -9.5600004196167,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "wind": {
            "compassDirection": "northNortheast",
            "gust": {
              "value": 11.966399192810059,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            },
            "speed": {
              "value": 7.426799774169922,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            },
            "direction": {
              "value": 29,
              "unit": {
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                },
                "symbol": "°"
              }
            }
          }
        },
        {
          "cloudCoverByAltitude": {
            "medium": 0.97,
            "low": 0.04,
            "high": 0.2
          },
          "precipitationChance": 0,
          "apparentPrecipitationIntensity": {
            "value": 0,
            "category": "light"
          },
          "precipitation": "none",
          "apparentTemperature": {
            "value": -11.560102462768555,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "cloudCover": 0.96,
          "cloudCoverLow": 0.04,
          "visibility": {
            "value": 48512,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            }
          },
          "cloudCoverMid": 0.97,
          "isDaylight": false,
          "condition": "cloudy",
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "dewPoint": {
            "value": -19.955978393554688,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "cloudCoverHigh": 0.2,
          "temperature": {
            "value": -9.699999809265137,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "humidity": 0.43,
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "pressure": {
            "value": 1038.1700439453125,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 100
              },
              "symbol": "mbar"
            }
          },
          "symbolName": "cloud",
          "date": 791013600,
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "wind": {
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 8.802000045776367
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              },
              "value": 24
            },
            "compassDirection": "northNortheast",
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 14.648399353027344
            }
          },
          "pressureTrend": "falling"
        },
        {
          "cloudCoverByAltitude": {
            "low": 0.03,
            "high": 0.9,
            "medium": 0.96
          },
          "precipitationChance": 0,
          "apparentPrecipitationIntensity": {
            "category": "light",
            "value": 0
          },
          "precipitation": "none",
          "apparentTemperature": {
            "value": -12.342106819152832,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "cloudCover": 0.95,
          "cloudCoverLow": 0.03,
          "visibility": {
            "value": 44136,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "cloudCoverMid": 0.96,
          "isDaylight": false,
          "condition": "cloudy",
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "dewPoint": {
            "value": -19.899307250976562,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "cloudCoverHigh": 0.9,
          "temperature": {
            "value": -9.930000305175781,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "humidity": 0.44,
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "pressure": {
            "value": 1037.6199951171875,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            }
          },
          "symbolName": "cloud",
          "date": 791017200,
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "wind": {
            "compassDirection": "northNortheast",
            "speed": {
              "value": 9.972000122070312,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            },
            "direction": {
              "value": 32,
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              }
            },
            "gust": {
              "value": 17.258399963378906,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            }
          },
          "pressureTrend": "falling"
        },
        {
          "cloudCoverLow": 0.06,
          "symbolName": "cloud",
          "cloudCoverHigh": 0.21,
          "precipitationChance": 0,
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.45,
          "pressure": {
            "value": 1037.030029296875,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -19.85821533203125,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "precipitation": "none",
          "visibility": {
            "value": 41734,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "temperature": {
            "value": -10.170000076293945,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "cloudCover": 0.96,
          "isDaylight": false,
          "cloudCoverByAltitude": {
            "high": 0.21,
            "medium": 0.98,
            "low": 0.06
          },
          "apparentTemperature": {
            "value": -12.206622123718262,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "condition": "cloudy",
          "date": 791020800,
          "apparentPrecipitationIntensity": {
            "category": "light",
            "value": 0
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              },
              "value": 35
            },
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 9.147599220275879
            },
            "compassDirection": "northeast",
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 17.528400421142578
            }
          }
        },
        {
          "cloudCoverLow": 0.22,
          "symbolName": "cloud",
          "cloudCoverHigh": 0.11,
          "precipitationChance": 0,
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.49,
          "pressure": {
            "value": 1036.6199951171875,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -18.993331909179688,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "precipitation": "none",
          "visibility": {
            "value": 39256,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "temperature": {
            "value": -10.3100004196167,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "precipitationAmount": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "cloudCover": 0.98,
          "isDaylight": false,
          "cloudCoverByAltitude": {
            "high": 0.11,
            "medium": 0.98,
            "low": 0.22
          },
          "apparentTemperature": {
            "value": -11.676039695739746,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "condition": "cloudy",
          "date": 791024400,
          "apparentPrecipitationIntensity": {
            "value": 0,
            "category": "light"
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "compassDirection": "northeast",
            "speed": {
              "value": 8.02440071105957,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "direction": {
              "value": 51,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "gust": {
              "value": 14.80679988861084,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            }
          }
        },
        {
          "cloudCoverLow": 0.24,
          "symbolName": "cloud",
          "cloudCoverHigh": 0.14,
          "precipitationChance": 0,
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.56,
          "pressure": {
            "value": 1036.6300048828125,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            }
          },
          "dewPoint": {
            "value": -17.62432861328125,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "precipitation": "none",
          "visibility": {
            "value": 31095,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "temperature": {
            "value": -10.529999732971191,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "precipitationAmount": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 0
          },
          "cloudCover": 0.99,
          "isDaylight": false,
          "cloudCoverByAltitude": {
            "high": 0.14,
            "medium": 0.98,
            "low": 0.24
          },
          "apparentTemperature": {
            "value": -12.337336540222168,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "condition": "cloudy",
          "date": 791028000,
          "apparentPrecipitationIntensity": {
            "category": "light",
            "value": 0
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "direction": {
              "value": 42,
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              }
            },
            "gust": {
              "value": 15.170400619506836,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              }
            },
            "compassDirection": "northeast",
            "speed": {
              "value": 8.895599365234375,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              }
            }
          }
        },
        {
          "cloudCoverLow": 0.49,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 0.97,
          "precipitationChance": 0.7,
          "snowfallAmount": {
            "value": 18.492021560668945,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.78,
          "pressure": {
            "value": 1036.010009765625,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -14.412582397460938,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "precipitation": "snow",
          "visibility": {
            "value": 3599,
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "temperature": {
            "value": -11.34000015258789,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "precipitationAmount": {
            "value": 0.8650000095367432,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "cloudCover": 1,
          "isDaylight": false,
          "cloudCoverByAltitude": {
            "low": 0.49,
            "high": 0.97,
            "medium": 0.98
          },
          "apparentTemperature": {
            "value": -12.832355499267578,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "condition": "heavySnow",
          "date": 791031600,
          "apparentPrecipitationIntensity": {
            "value": 2.007999897003174,
            "category": "heavy"
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "direction": {
              "unit": {
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                },
                "symbol": "°"
              },
              "value": 63
            },
            "gust": {
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              },
              "value": 15.569998741149902
            },
            "speed": {
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              },
              "value": 8.510400772094727
            },
            "compassDirection": "eastNortheast"
          }
        },
        {
          "cloudCoverLow": 0.53,
          "symbolName": "snowflake",
          "cloudCoverHigh": 0.96,
          "precipitationChance": 0.73,
          "snowfallAmount": {
            "value": 13.409581184387207,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.82,
          "pressure": {
            "value": 1035.3299560546875,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -13.5755615234375,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          },
          "precipitation": "snow",
          "visibility": {
            "value": 3266,
            "unit": {
              "symbol": "m",
              "converter": {
                "constant": 0,
                "coefficient": 1
              }
            }
          },
          "temperature": {
            "value": -11.109999656677246,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "precipitationAmount": {
            "value": 0.6370000243186951,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "cloudCover": 1,
          "isDaylight": false,
          "cloudCoverByAltitude": {
            "low": 0.53,
            "medium": 0.98,
            "high": 0.96
          },
          "apparentTemperature": {
            "value": -12.28801441192627,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "condition": "snow",
          "date": 791035200,
          "apparentPrecipitationIntensity": {
            "value": 1.8250000476837158,
            "category": "medium"
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 7.984799861907959
            },
            "compassDirection": "northeast",
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 16.210798263549805
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              },
              "value": 53
            }
          }
        },
        {
          "cloudCoverLow": 0.59,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 0.96,
          "precipitationChance": 0.74,
          "snowfallAmount": {
            "value": 26.958580017089844,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.85,
          "pressure": {
            "value": 1034.489990234375,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            }
          },
          "dewPoint": {
            "value": -12.86773681640625,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "precipitation": "snow",
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            },
            "value": 1133
          },
          "temperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -10.84000015258789
          },
          "precipitationAmount": {
            "value": 1.3040000200271606,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "cloudCover": 0.99,
          "isDaylight": true,
          "cloudCoverByAltitude": {
            "medium": 0.98,
            "high": 0.96,
            "low": 0.59
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -14.179106712341309
          },
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "condition": "heavySnow",
          "date": 791038800,
          "apparentPrecipitationIntensity": {
            "value": 2.2179999351501465,
            "category": "heavy"
          },
          "cloudCoverMid": 0.98,
          "wind": {
            "gust": {
              "value": 17.964000701904297,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "direction": {
              "value": 59,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "compassDirection": "eastNortheast",
            "speed": {
              "value": 10.630800247192383,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            }
          }
        },
        {
          "cloudCoverLow": 0.84,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 1,
          "precipitationChance": 0.76,
          "snowfallAmount": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 29.767353057861328
          },
          "pressureTrend": "falling",
          "humidity": 0.85,
          "pressure": {
            "unit": {
              "symbol": "mbar",
              "converter": {
                "constant": 0,
                "coefficient": 100
              }
            },
            "value": 1032.8299560546875
          },
          "dewPoint": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -12.179916381835938
          },
          "precipitation": "snow",
          "visibility": {
            "value": 804,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            }
          },
          "temperature": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            },
            "value": -10.140000343322754
          },
          "precipitationAmount": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 1.5089999437332153
          },
          "cloudCover": 1,
          "isDaylight": true,
          "cloudCoverByAltitude": {
            "low": 0.84,
            "medium": 1,
            "high": 1
          },
          "apparentTemperature": {
            "value": -17.082962036132812,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "uvIndex": {
            "category": "low",
            "value": 1
          },
          "condition": "heavySnow",
          "date": 791042400,
          "apparentPrecipitationIntensity": {
            "value": 2.2709999084472656,
            "category": "heavy"
          },
          "cloudCoverMid": 1,
          "wind": {
            "compassDirection": "northeast",
            "speed": {
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              },
              "value": 15.534000396728516
            },
            "direction": {
              "unit": {
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                },
                "symbol": "°"
              },
              "value": 51
            },
            "gust": {
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              },
              "value": 20.768400192260742
            }
          }
        },
        {
          "cloudCoverLow": 0.95,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 0.98,
          "precipitationChance": 1,
          "snowfallAmount": {
            "value": 30.29670524597168,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "pressureTrend": "falling",
          "humidity": 0.88,
          "pressure": {
            "value": 1031.280029296875,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "constant": 0,
                "coefficient": 100
              }
            }
          },
          "dewPoint": {
            "value": -9.893539428710938,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "precipitation": "snow",
          "visibility": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            },
            "value": 655
          },
          "temperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -8.260000228881836
          },
          "precipitationAmount": {
            "value": 1.7419999837875366,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "cloudCover": 1,
          "isDaylight": true,
          "cloudCoverByAltitude": {
            "high": 0.98,
            "low": 0.95,
            "medium": 1
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -16.707523345947266
          },
          "uvIndex": {
            "category": "low",
            "value": 1
          },
          "condition": "heavySnow",
          "date": 791046000,
          "apparentPrecipitationIntensity": {
            "category": "heavy",
            "value": 2.2809998989105225
          },
          "cloudCoverMid": 1,
          "wind": {
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              },
              "value": 63
            },
            "compassDirection": "eastNortheast",
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 33.249603271484375
            },
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 18.1835994720459
            }
          }
        },
        {
          "cloudCoverLow": 0.7,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 0.99,
          "precipitationChance": 1,
          "snowfallAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 43.081504821777344
          },
          "pressureTrend": "falling",
          "humidity": 0.87,
          "pressure": {
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            },
            "value": 1030.3399658203125
          },
          "dewPoint": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -9.230850219726562
          },
          "precipitation": "snow",
          "visibility": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            },
            "value": 455
          },
          "temperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -7.440000057220459
          },
          "precipitationAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 2.617000102996826
          },
          "cloudCover": 0.99,
          "isDaylight": true,
          "cloudCoverByAltitude": {
            "high": 0.99,
            "medium": 1,
            "low": 0.7
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -15.100984573364258
          },
          "uvIndex": {
            "value": 2,
            "category": "low"
          },
          "condition": "heavySnow",
          "date": 791049600,
          "apparentPrecipitationIntensity": {
            "category": "heavy",
            "value": 2.4590001106262207
          },
          "cloudCoverMid": 1,
          "wind": {
            "speed": {
              "value": 16.63559913635254,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "compassDirection": "eastNortheast",
            "direction": {
              "value": 62,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "gust": {
              "value": 33.029998779296875,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            }
          }
        },
        {
          "cloudCoverLow": 0.94,
          "symbolName": "cloud.snow",
          "cloudCoverHigh": 1,
          "precipitationChance": 0.78,
          "snowfallAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 36.677513122558594
          },
          "pressureTrend": "falling",
          "humidity": 0.84,
          "pressure": {
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            },
            "value": 1028.6800537109375
          },
          "dewPoint": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -8.5888671875
          },
          "precipitation": "snow",
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "constant": 0,
                "coefficient": 1
              }
            },
            "value": 469
          },
          "temperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -6.329999923706055
          },
          "precipitationAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 2.4000000953674316
          },
          "cloudCover": 0.99,
          "isDaylight": true,
          "cloudCoverByAltitude": {
            "medium": 1,
            "high": 1,
            "low": 0.94
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -15.372511863708496
          },
          "uvIndex": {
            "value": 2,
            "category": "low"
          },
          "condition": "heavySnow",
          "date": 791053200,
          "apparentPrecipitationIntensity": {
            "value": 2.380000114440918,
            "category": "heavy"
          },
          "cloudCoverMid": 1,
          "wind": {
            "gust": {
              "value": 36.46799850463867,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "compassDirection": "northeast",
            "direction": {
              "value": 50,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "speed": {
              "value": 19.601999282836914,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "value": 2.4019999504089355,
            "category": "heavy"
          },
          "condition": "heavySnow",
          "snowfallAmount": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 38.32230758666992
          },
          "symbolName": "cloud.snow",
          "uvIndex": {
            "value": 2,
            "category": "low"
          },
          "precipitationChance": 0.78,
          "precipitation": "snow",
          "cloudCoverMid": 1,
          "date": 791056800,
          "cloudCover": 0.99,
          "temperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -5.260000228881836
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 2.694000005722046
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -15.128251075744629
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "high": 1,
            "medium": 1,
            "low": 0.99
          },
          "humidity": 0.81,
          "cloudCoverLow": 0.99,
          "isDaylight": true,
          "wind": {
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 42.37200164794922
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              },
              "value": 53
            },
            "compassDirection": "northeast",
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 21.848398208618164
            }
          },
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            },
            "value": 525
          },
          "pressure": {
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            },
            "value": 1025.8900146484375
          },
          "dewPoint": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -8.0091552734375
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "category": "heavy",
            "value": 2.3320000171661377
          },
          "condition": "heavySnow",
          "snowfallAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            },
            "value": 33.41462326049805
          },
          "symbolName": "cloud.snow",
          "uvIndex": {
            "category": "low",
            "value": 1
          },
          "precipitationChance": 0.78,
          "precipitation": "snow",
          "cloudCoverMid": 1,
          "date": 791060400,
          "cloudCover": 0.99,
          "temperature": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -4.449999809265137
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            },
            "value": 2.4800000190734863
          },
          "apparentTemperature": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -14.410187721252441
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "high": 1,
            "medium": 1,
            "low": 1
          },
          "humidity": 0.78,
          "cloudCoverLow": 1,
          "isDaylight": true,
          "wind": {
            "gust": {
              "value": 44.53200149536133,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              },
              "value": 54
            },
            "compassDirection": "northeast",
            "speed": {
              "value": 22.52519989013672,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            }
          },
          "visibility": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            },
            "value": 732
          },
          "pressure": {
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            },
            "value": 1023.0700073242188
          },
          "dewPoint": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            },
            "value": -7.7067413330078125
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "value": 1.5119999647140503,
            "category": "medium"
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "value": 1,
            "category": "low"
          },
          "precipitationChance": 0.79,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791064000,
          "cloudCover": 0.99,
          "temperature": {
            "value": -3.7799999713897705,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "value": 2.5989999771118164,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "apparentTemperature": {
            "value": -14.001350402832031,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "high": 1,
            "low": 0.98,
            "medium": 1
          },
          "humidity": 0.77,
          "cloudCoverLow": 0.98,
          "isDaylight": true,
          "wind": {
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              },
              "value": 59
            },
            "speed": {
              "value": 24.044401168823242,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              }
            },
            "gust": {
              "value": 51.19200134277344,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              }
            },
            "compassDirection": "eastNortheast"
          },
          "visibility": {
            "value": 1061,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            }
          },
          "pressure": {
            "value": 1021,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "constant": 0,
                "coefficient": 100
              }
            }
          },
          "dewPoint": {
            "value": -7.222564697265625,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "category": "medium",
            "value": 1.6180000305175781
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 0
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "precipitationChance": 0.78,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791067600,
          "cloudCover": 0.99,
          "temperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -3.299999952316284
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 3.1559998989105225
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -12.298108100891113
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "low": 0.98,
            "high": 1,
            "medium": 1
          },
          "humidity": 0.77,
          "cloudCoverLow": 0.98,
          "isDaylight": true,
          "wind": {
            "direction": {
              "value": 50,
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              }
            },
            "gust": {
              "value": 48.38399887084961,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            },
            "compassDirection": "northeast",
            "speed": {
              "value": 22.435199737548828,
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              }
            }
          },
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            },
            "value": 1413
          },
          "pressure": {
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            },
            "value": 1018.5700073242188
          },
          "dewPoint": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -6.7563018798828125
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "category": "medium",
            "value": 1.5449999570846558
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "precipitationChance": 0.78,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791071200,
          "cloudCover": 0.99,
          "temperature": {
            "value": -2.819999933242798,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "value": 2.765000104904175,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "apparentTemperature": {
            "value": -10.360177040100098,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "low": 0.98,
            "medium": 1,
            "high": 1
          },
          "humidity": 0.79,
          "cloudCoverLow": 0.98,
          "isDaylight": true,
          "wind": {
            "speed": {
              "value": 21.743999481201172,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "compassDirection": "northeast",
            "direction": {
              "value": 50,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "gust": {
              "value": 46.58399963378906,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            }
          },
          "visibility": {
            "value": 1228,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            }
          },
          "pressure": {
            "value": 1017.1799926757812,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            }
          },
          "dewPoint": {
            "value": -5.95404052734375,
            "unit": {
              "symbol": "°C",
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              }
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "value": 1.5110000371932983,
            "category": "medium"
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "precipitationChance": 0.8,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791074800,
          "cloudCover": 0.99,
          "temperature": {
            "value": -3,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "value": 2.5950000286102295,
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            }
          },
          "apparentTemperature": {
            "value": -11.695653915405273,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "low": 0.96,
            "medium": 1,
            "high": 1
          },
          "humidity": 0.86,
          "cloudCoverLow": 0.96,
          "isDaylight": false,
          "wind": {
            "compassDirection": "northeast",
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                }
              },
              "value": 24.843599319458008
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                }
              },
              "value": 48
            },
            "gust": {
              "value": 49.35599899291992,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            }
          },
          "visibility": {
            "value": 1814,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            }
          },
          "pressure": {
            "value": 1014.3800048828125,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -5.011749267578125,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "value": 1.4850000143051147,
            "category": "medium"
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "precipitationChance": 0.81,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791078400,
          "cloudCover": 0.99,
          "temperature": {
            "value": -2.430000066757202,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "value": 2.4709999561309814,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "apparentTemperature": {
            "value": -10.85429859161377,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            }
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "high": 1,
            "low": 0.97,
            "medium": 1
          },
          "humidity": 0.86,
          "cloudCoverLow": 0.97,
          "isDaylight": false,
          "wind": {
            "gust": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 48.74399948120117
            },
            "speed": {
              "unit": {
                "symbol": "km/h",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                }
              },
              "value": 24.220800399780273
            },
            "direction": {
              "unit": {
                "symbol": "°",
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                }
              },
              "value": 48
            },
            "compassDirection": "northeast"
          },
          "visibility": {
            "value": 1982,
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            }
          },
          "pressure": {
            "value": 1012.1500244140625,
            "unit": {
              "converter": {
                "coefficient": 100,
                "constant": 0
              },
              "symbol": "mbar"
            }
          },
          "dewPoint": {
            "value": -4.4512786865234375,
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "category": "medium",
            "value": 1.4670000076293945
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 0
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "precipitationChance": 0.81,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791082000,
          "cloudCover": 0.99,
          "temperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -1.809999942779541
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 2.390000104904175
          },
          "apparentTemperature": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -9.520576477050781
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "low": 0.97,
            "medium": 1,
            "high": 1
          },
          "humidity": 0.86,
          "cloudCoverLow": 0.97,
          "isDaylight": false,
          "wind": {
            "direction": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              },
              "value": 42
            },
            "speed": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              },
              "value": 22.352399826049805
            },
            "gust": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              },
              "value": 45.46799850463867
            },
            "compassDirection": "northeast"
          },
          "visibility": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "m"
            },
            "value": 2059
          },
          "pressure": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 100
              },
              "symbol": "mbar"
            },
            "value": 1010.260009765625
          },
          "dewPoint": {
            "value": -3.8416595458984375,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "category": "medium",
            "value": 1.121000051498413
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 0
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "category": "low",
            "value": 0
          },
          "precipitationChance": 0.77,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791085600,
          "cloudCover": 0.99,
          "temperature": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -1.1100000143051147
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 1.187000036239624
          },
          "apparentTemperature": {
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            },
            "value": -8.720003128051758
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "medium": 1,
            "high": 1,
            "low": 0.96
          },
          "humidity": 0.86,
          "cloudCoverLow": 0.96,
          "isDaylight": false,
          "wind": {
            "speed": {
              "value": 22.32720184326172,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            },
            "direction": {
              "value": 45,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 1
                },
                "symbol": "°"
              }
            },
            "compassDirection": "northeast",
            "gust": {
              "value": 44.891998291015625,
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.277778
                },
                "symbol": "km/h"
              }
            }
          },
          "visibility": {
            "unit": {
              "symbol": "m",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            },
            "value": 2930
          },
          "pressure": {
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            },
            "value": 1007.72998046875
          },
          "dewPoint": {
            "unit": {
              "converter": {
                "constant": 273.15,
                "coefficient": 1
              },
              "symbol": "°C"
            },
            "value": -3.153411865234375
          }
        },
        {
          "apparentPrecipitationIntensity": {
            "value": 1.0099999904632568,
            "category": "medium"
          },
          "condition": "wintryMix",
          "snowfallAmount": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "symbolName": "cloud.sleet",
          "uvIndex": {
            "value": 0,
            "category": "low"
          },
          "precipitationChance": 0.74,
          "precipitation": "mixed",
          "cloudCoverMid": 1,
          "date": 791089200,
          "cloudCover": 0.99,
          "temperature": {
            "value": -0.41999998688697815,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "pressureTrend": "falling",
          "precipitationAmount": {
            "unit": {
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              },
              "symbol": "mm"
            },
            "value": 0.921999990940094
          },
          "apparentTemperature": {
            "value": -6.561071395874023,
            "unit": {
              "symbol": "°C",
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              }
            }
          },
          "cloudCoverHigh": 1,
          "cloudCoverByAltitude": {
            "low": 1,
            "medium": 1,
            "high": 1
          },
          "humidity": 0.87,
          "cloudCoverLow": 1,
          "isDaylight": false,
          "wind": {
            "direction": {
              "value": 35,
              "unit": {
                "converter": {
                  "coefficient": 1,
                  "constant": 0
                },
                "symbol": "°"
              }
            },
            "gust": {
              "value": 37.11600112915039,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            },
            "speed": {
              "value": 18.727201461791992,
              "unit": {
                "converter": {
                  "coefficient": 0.277778,
                  "constant": 0
                },
                "symbol": "km/h"
              }
            },
            "compassDirection": "northeast"
          },
          "visibility": {
            "value": 5313,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 1
              },
              "symbol": "m"
            }
          },
          "pressure": {
            "value": 1006.7100219726562,
            "unit": {
              "symbol": "mbar",
              "converter": {
                "coefficient": 100,
                "constant": 0
              }
            }
          },
          "dewPoint": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 273.15
              },
              "symbol": "°C"
            },
            "value": -2.3187103271484375
          }
        }
      ]
    }
    """.data(using: .utf8)!
    let hourly =
        try! JSONDecoder().decode(Forecast<HourWeather>.self, from: jsonData)
    VStack {
        HourlyForecastView(h: hourly)
    }
}

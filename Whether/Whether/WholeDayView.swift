// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import Foundation
import SwiftUI
import WeatherKit

extension UVIndex.ExposureCategory {
    var text: String { "\(description) (\(rangeValue.lowerBound)-\(rangeValue.upperBound))" }
}

extension Wind {
    var text: String {
        "\(compassDirection.abbreviation) winds @ \(speed.whether)"
    }

    var gustText: String? {
        guard let gust else { return nil }
        return "Gusting to \(gust.whether)"
    }
}

struct WholeDayView: View {
    let day: DayWeather

    var body: some View {
        VStack {
            Spacer()
            Text(day.date.wholeText).font(.largeTitle)

            Spacer()

            BigImage(systemName: day.symbolName)
            // Text(day.condition.description).font(.largeTitle)
            Text("\(day.daytimeForecast.lowTemperature.whether)/\(day.daytimeForecast.highTemperature.whether)")
                .font(.largeTitle)

            Spacer()

            DayView("Overnight:", for: day.overnightForecast)
            if day.precipitationChance != 0 {
                Text("\(day.precipitation.description): \(day.precipitationChance.percentage)% chance")
            }

            Spacer()

            windView

            Spacer()

            uvIndexView
            precipitationView

            Spacer()
        }
    }

    private var windView: some View {
        VStack {
            Text(day.wind.text)
            if let highWindSpeed = day.highWindSpeed {
                Text("Sustained at \(highWindSpeed.whether)")
            }
            if let gustText = day.wind.gustText {
                Text(gustText)
            }
        }
    }

    private var uvIndexView: some View {
        Text("UV Index: \(day.uvIndex.category.text)")
    }

    private var precipitationView: some View {
        VStack {
            snowfallAmountView(day.precipitationAmountByType.snowfallAmount)
            onePrecipitationView(day.precipitationAmountByType.mixed, "wintry mix")
            onePrecipitationView(day.precipitationAmountByType.sleet, "sleet")
            onePrecipitationView(day.precipitationAmountByType.rainfall, "rain")
            onePrecipitationView(day.precipitationAmountByType.hail, "hail")
        }
    }

    private func snowfallAmountView(_ amt: SnowfallAmount) -> some View {
        Group {
            if amt.maximum.value != 0 {
                Text("snow: \(amt.minimum.whetherRange(through: amt.maximum))")
            }
        }
    }

    private func onePrecipitationView(_ m: Measurement<UnitLength>,
                                      _ tag: String) -> some View
    {
        Group {
            if m.value != 0 {
                Text("\(tag): \(m.whether)")
            }
        }
    }
}

#Preview {
    let jsonData = """
    {
      "humidityMax": 0.88,
      "daytimeForecast": {
        "humidity": 0.84,
        "forecastEnd": 791078400,
        "minimumUVIndex": {
          "category": "low",
          "value": 0
        },
        "isDaylight": true,
        "cloudCoverByAltitude": {
          "medium": 1,
          "low": 0.85,
          "high": 0.97
        },
        "maximumUVIndex": {
          "category": "low",
          "value": 2
        },
        "condition": "wintryMix",
        "forecastStart": 791035200,
        "highTemperature": {
          "unit": {
            "symbol": "°C",
            "converter": {
              "coefficient": 1,
              "constant": 273.15
            }
          },
          "value": -3.509999990463257
        },
        "lowTemperature": {
          "unit": {
            "symbol": "°C",
            "converter": {
              "coefficient": 1,
              "constant": 273.15
            }
          },
          "value": -10.109999656677246
        },
        "precipitationAmountByType": {
          "mixed": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 6.912999629974365
          },
          "rainfall": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 0
          },
          "sleet": {
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            },
            "value": 0
          },
          "snowfallAmount": {
            "amount": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 257.2430419921875
            },
            "amountLiquidEquivalent": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 16.075998306274414
            },
            "maximum": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 282.9673767089844
            },
            "minimum": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 231.51873779296875
            },
            "minimumLiquidEquivalent": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 16.075998306274414
            },
            "maximumLiquidEquivalent": {
              "unit": {
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                },
                "symbol": "mm"
              },
              "value": 16.075998306274414
            }
          },
          "precipitation": {
            "value": 22.98900032043457,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              },
              "symbol": "mm"
            }
          },
          "hail": {
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            },
            "value": 0
          }
        },
        "precipitationIntensityMax": {
          "category": "heavy",
          "value": 2.865000009536743
        },
        "cloudCover": 0.99,
        "maximumHumidity": 0.85,
        "wind": {
          "speed": {
            "value": 21.477750778198242,
            "unit": {
              "converter": {
                "coefficient": 0.277778,
                "constant": 0
              },
              "symbol": "km/h"
            }
          },
          "compassDirection": "northeast",
          "direction": {
            "unit": {
              "converter": {
                "coefficient": 1,
                "constant": 0
              },
              "symbol": "°"
            },
            "value": 52
          },
          "gust": {
            "value": 53.099998474121094,
            "unit": {
              "converter": {
                "coefficient": 0.277778,
                "constant": 0
              },
              "symbol": "km/h"
            }
          }
        },
        "precipitation": "mixed",
        "precipitationChance": 0.95,
        "perceivedPrecipitationIntensityMax": {
          "category": "medium",
          "value": 1.565000057220459
        },
        "minimumHumidity": 0.78,
        "minimumVisibility": {
          "unit": {
            "converter": {
              "coefficient": 1,
              "constant": 0
            },
            "symbol": "m"
          },
          "value": 567
        },
        "highWindSpeed": {
          "value": 26.784000396728516,
          "unit": {
            "symbol": "km/h",
            "converter": {
              "coefficient": 0.277778,
              "constant": 0
            }
          }
        },
        "maximumVisibility": {
          "unit": {
            "converter": {
              "coefficient": 1,
              "constant": 0
            },
            "symbol": "m"
          },
          "value": 2932
        }
      },
      "windSpeedMax": {
        "unit": {
          "converter": {
            "constant": 0,
            "coefficient": 0.277778
          },
          "symbol": "km/h"
        },
        "value": 26.784000396728516
      },
      "date": 791010000,
      "lowTemperature": {
        "value": -10.609999656677246,
        "unit": {
          "converter": {
            "constant": 273.15,
            "coefficient": 1
          },
          "symbol": "°C"
        }
      },
      "uvIndex": {
        "value": 2,
        "category": "low"
      },
      "highTemperature": {
        "value": -1.520241141319275,
        "unit": {
          "converter": {
            "constant": 273.15,
            "coefficient": 1
          },
          "symbol": "°C"
        }
      },
      "windGustSpeedMax": {
        "unit": {
          "converter": {
            "constant": 0,
            "coefficient": 0.277778
          },
          "symbol": "km/h"
        },
        "value": 53.099998474121094
      },
      "symbolName": "cloud.sleet",
      "visibilityMax": 38652,
      "moon": {
        "phase": "waxingCrescent",
        "moonrise": 791047510
      },
      "wind": {
        "speed": {
          "value": 18.67537498474121,
          "unit": {
            "symbol": "km/h",
            "converter": {
              "constant": 0,
              "coefficient": 0.277778
            }
          }
        },
        "compassDirection": "northeast",
        "direction": {
          "unit": {
            "symbol": "°",
            "converter": {
              "constant": 0,
              "coefficient": 1
            }
          },
          "value": 52
        },
        "gust": {
          "value": 53.099998474121094,
          "unit": {
            "symbol": "km/h",
            "converter": {
              "constant": 0,
              "coefficient": 0.277778
            }
          }
        }
      },
      "lowTemperatureTime": 791010000,
      "humidityMin": 0.57,
      "humidity": 0,
      "condition": "wintryMix",
      "windSpeedAvg": {
        "unit": {
          "converter": {
            "constant": 0,
            "coefficient": 0.277778
          },
          "symbol": "km/h"
        },
        "value": 18.67537498474121
      },
      "visibilityMin": 567,
      "precipitationAmountByType": {
        "hail": {
          "unit": {
            "symbol": "mm",
            "converter": {
              "coefficient": 0.001,
              "constant": 0
            }
          },
          "value": 0
        },
        "sleet": {
          "unit": {
            "symbol": "mm",
            "converter": {
              "constant": 0,
              "coefficient": 0.001
            }
          },
          "value": 0
        },
        "rainfall": {
          "unit": {
            "symbol": "mm",
            "converter": {
              "constant": 0,
              "coefficient": 0.001
            }
          },
          "value": 0
        },
        "snowfallAmount": {
          "minimum": {
            "value": 231.51873779296875,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "amount": {
            "value": 257.2430419921875,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "minimumLiquidEquivalent": {
            "value": 16.075998306274414,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "amountLiquidEquivalent": {
            "value": 16.075998306274414,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "maximumLiquidEquivalent": {
            "value": 16.075998306274414,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          },
          "maximum": {
            "value": 282.9673767089844,
            "unit": {
              "symbol": "mm",
              "converter": {
                "coefficient": 0.001,
                "constant": 0
              }
            }
          }
        },
        "mixed": {
          "unit": {
            "converter": {
              "constant": 0,
              "coefficient": 0.001
            },
            "symbol": "mm"
          },
          "value": 13.409997940063477
        },
        "precipitation": {
          "unit": {
            "symbol": "mm",
            "converter": {
              "constant": 0,
              "coefficient": 0.001
            }
          },
          "value": 29.486000061035156
        }
      },
      "maximumVisibility": 38652,
      "sun": {
        "civilDusk": 791073284,
        "sunset": 791071517,
        "astronomicalDawn": 791030216,
        "nauticalDusk": 791075267,
        "solarMidnight": 791010484,
        "astronomicalDusk": 791077214,
        "civilDawn": 791034146,
        "sunrise": 791035905,
        "solarNoon": 791053707,
        "nauticalDawn": 791032155
      },
      "highWindSpeed": {
        "unit": {
          "converter": {
            "constant": 0,
            "coefficient": 0.277778
          },
          "symbol": "km/h"
        },
        "value": 26.784000396728516
      },
      "precipitation": "mixed",
      "highTemperatureTime": 791093355,
      "maximumHumidity": 0.88,
      "precipitationChance": 0.97,
      "minimumHumidity": 0.57,
      "snowfallAmount": {
        "value": 257.2430419921875,
        "unit": {
          "converter": {
            "constant": 0,
            "coefficient": 0.001
          },
          "symbol": "mm"
        }
      },
      "overnightForecast": {
        "humidity": 0.87,
        "forecastEnd": 791121600,
        "minimumUVIndex": {
          "value": 0,
          "category": "low"
        },
        "isDaylight": false,
        "cloudCoverByAltitude": {
          "medium": 0.61,
          "high": 0.44,
          "low": 0.99
        },
        "maximumUVIndex": {
          "value": 0,
          "category": "low"
        },
        "condition": "wintryMix",
        "forecastStart": 791078400,
        "highTemperature": {
          "value": -1.520241141319275,
          "unit": {
            "symbol": "°C",
            "converter": {
              "constant": 273.15,
              "coefficient": 1
            }
          }
        },
        "lowTemperature": {
          "value": -3.549999952316284,
          "unit": {
            "symbol": "°C",
            "converter": {
              "constant": 273.15,
              "coefficient": 1
            }
          }
        },
        "precipitationAmountByType": {
          "mixed": {
            "value": 7.0960001945495605,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "sleet": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "rainfall": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "precipitation": {
            "value": 7.095999717712402,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          },
          "snowfallAmount": {
            "amount": {
              "value": 0,
              "unit": {
                "symbol": "mm",
                "converter": {
                  "constant": 0,
                  "coefficient": 0.001
                }
              }
            },
            "maximumLiquidEquivalent": {
              "value": 0,
              "unit": {
                "converter": {
                  "coefficient": 0.001,
                  "constant": 0
                },
                "symbol": "mm"
              }
            },
            "amountLiquidEquivalent": {
              "value": 0,
              "unit": {
                "converter": {
                  "coefficient": 0.001,
                  "constant": 0
                },
                "symbol": "mm"
              }
            },
            "minimum": {
              "value": 0,
              "unit": {
                "converter": {
                  "coefficient": 0.001,
                  "constant": 0
                },
                "symbol": "mm"
              }
            },
            "maximum": {
              "value": 0,
              "unit": {
                "converter": {
                  "coefficient": 0.001,
                  "constant": 0
                },
                "symbol": "mm"
              }
            },
            "minimumLiquidEquivalent": {
              "value": 0,
              "unit": {
                "converter": {
                  "coefficient": 0.001,
                  "constant": 0
                },
                "symbol": "mm"
              }
            }
          },
          "hail": {
            "value": 0,
            "unit": {
              "symbol": "mm",
              "converter": {
                "constant": 0,
                "coefficient": 0.001
              }
            }
          }
        },
        "precipitationIntensityMax": {
          "value": 1.7480000257492065,
          "category": "medium"
        },
        "cloudCover": 0.99,
        "maximumHumidity": 0.88,
        "wind": {
          "direction": {
            "value": 23,
            "unit": {
              "symbol": "°",
              "converter": {
                "coefficient": 1,
                "constant": 0
              }
            }
          },
          "speed": {
            "value": 17.88825035095215,
            "unit": {
              "symbol": "km/h",
              "converter": {
                "coefficient": 0.277778,
                "constant": 0
              }
            }
          },
          "compassDirection": "northNortheast",
          "gust": {
            "value": 53.099998474121094,
            "unit": {
              "converter": {
                "constant": 0,
                "coefficient": 0.277778
              },
              "symbol": "km/h"
            }
          }
        },
        "precipitation": "mixed",
        "precipitationChance": 0.91,
        "perceivedPrecipitationIntensityMax": {
          "value": 1.305999994277954,
          "category": "medium"
        },
        "minimumHumidity": 0.85,
        "minimumVisibility": {
          "unit": {
            "converter": {
              "constant": 0,
              "coefficient": 1
            },
            "symbol": "m"
          },
          "value": 1400
        },
        "highWindSpeed": {
          "value": 26.013599395751953,
          "unit": {
            "symbol": "km/h",
            "converter": {
              "coefficient": 0.277778,
              "constant": 0
            }
          }
        },
        "maximumVisibility": {
          "unit": {
            "converter": {
              "constant": 0,
              "coefficient": 1
            },
            "symbol": "m"
          },
          "value": 18018
        }
      },
      "rainfallAmount": {
        "value": 29.486000061035156,
        "unit": {
          "converter": {
            "coefficient": 0.001,
            "constant": 0
          },
          "symbol": "mm"
        }
      },
      "minimumVisibility": 567
    }
    """.data(using: .utf8)!
    let day = try! JSONDecoder().decode(DayWeather.self, from: jsonData)
    VStack {
        WholeDayView(day: day)
    }
}

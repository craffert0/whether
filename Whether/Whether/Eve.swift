// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import HomeKit
import Observation

@Observable
class Eve: NSObject {
    var temperature: Measurement<UnitTemperature>?
    var humidity: Measurement<UnitPercent>?
    var lowBattery: Bool?

    private let actual: HMAccessory
    private let temperatureC: HMCharacteristic
    private let humidityC: HMCharacteristic
    private let lowBatteryC: HMCharacteristic

    @MainActor
    init?(from manager: HMHomeManager) async throws {
        guard let actual = manager.eve,
              let temperatureC = actual.eveTemperature,
              let humidityC = actual.eveHumidity,
              let lowBatteryC = actual.eveLowBattery
        else { return nil }

        self.actual = actual
        self.temperatureC = temperatureC
        self.humidityC = humidityC
        self.lowBatteryC = lowBatteryC

        super.init()

        self.actual.delegate = self

        try await self.temperatureC.readValue()
        temperature = self.temperatureC.temperature
        try await self.temperatureC.enableNotification(true)

        try await self.humidityC.readValue()
        humidity = self.humidityC.humidity
        try await self.humidityC.enableNotification(true)

        try await self.lowBatteryC.readValue()
        lowBattery = ((self.lowBatteryC.value as? NSNumber) ?? 0) != 0
        try await self.lowBatteryC.enableNotification(true)
    }
}

extension Eve: HMAccessoryDelegate {
    func accessory(_: HMAccessory,
                   service _: HMService,
                   didUpdateValueFor characteristic: HMCharacteristic)
    {
        if characteristic == temperatureC {
            let temperature = temperatureC.temperature
            Task { @MainActor in
                self.temperature = temperature
            }
        } else if characteristic == humidityC {
            let humidity = humidityC.humidity
            Task { @MainActor in
                self.humidity = humidity
            }
        } else if characteristic == lowBatteryC {
            let lowBattery = ((lowBatteryC.value as? NSNumber) ?? 0) != 0
            Task { @MainActor in
                self.lowBattery = lowBattery
            }
        }
    }
}

//   for s in actual.services {
//       print("  \(s.name) \(s.isPrimaryService ? "y" : "n")/\(s.isUserInteractive ? "y" : "n"): \(s.serviceType.serviceTypeReadable ?? s.serviceType)")
//       for c in s.characteristics {
//           print("   \(c.localizedDescription): \(c.characteristicType.characteristicTypeReadable ?? c.characteristicType): \(c.properties.map { $0.dropFirst(24) })")

// Eve Weather F3E8 n/y: 00000701-0000-1000-8000-0026BB765291
//  Custom: EveThreadStatus: ["Readable", "SupportsEventNotification"]
//     value: 8
//     manufacturerDescription: Thread Status
//     minimumValue: 0
//     maximumValue: 127
//     stepValue: 1
//     format: uint16
//  Custom: EveCurrentTransport: ["Readable"]
//     value: 1
//     manufacturerDescription: Current Transport
//     format: bool
//  Custom: EveThreadOpenThreadVersion: ["Readable"]
//     value: OPENTHREAD/20170716-02552-geb173c52; NRF52840; May  8 2023 17:01:35
//     manufacturerDescription: Thread OpenThread Version
//     maxLength: 64
//     format: string
//  Custom: EveThreadNodeCapabilities: ["Readable"]
//     value: 2
//     manufacturerDescription: Thread Node Capabilities
//     minimumValue: 0
//     maximumValue: 31
//     stepValue: 1
//     format: uint16
// Eve Weather F3E8 n/y: 00000239-0000-1000-8000-0026BB765291
//  Custom: EveSleepInterval: ["Readable"]
//     value: 5000
//     manufacturerDescription: Sleep Interval
//     minimumValue: 10
//     maximumValue: 67108863
//     stepValue: 1
//     format: uint32
//  Custom: EvePing: ["Readable"]
//     value: {length = 0, bytes = 0x}
//     manufacturerDescription: Ping
//     format: data
//  Custom: EveHeartBeat: ["Readable", "SupportsEventNotification"]
//     value: 356
//     manufacturerDescription: Heart Beat
//     format: uint32
// Eve Weather F3E8 n/y: Battery
//  Name: Name: ["Readable"]
//     value: Battery
//     manufacturerDescription: Name
//     maxLength: 64
//     format: string
//  Status Low Battery: StatusLowBattery: ["Readable", "SupportsEventNotification"]
//     value: 0
//     manufacturerDescription: Status Low Battery
//     minimumValue: 0
//     maximumValue: 1
//     stepValue: 1
//     format: uint8
//  Battery Level: BatteryLevel: ["Readable", "SupportsEventNotification"]
//     value: 100
//     manufacturerDescription: Battery Level
//     minimumValue: 0
//     maximumValue: 100
//     stepValue: 1
//     format: uint8
//     units: percentage
// Eve Weather F3E8 n/n: AccessoryInformation
//  Name: Name: ["Readable"]
//     value: Eve Weather F3E8
//     manufacturerDescription: Name
//     maxLength: 64
//     format: string
//  Identify: Identify: ["Writable"]
//     manufacturerDescription: Identify
//     format: bool
//  Serial Number: EveSerialNumber: ["Readable"]
//     value: SV35L1A00012
//     manufacturerDescription: Serial Number
//     maxLength: 64
//     format: string
//  Hardware Version: HardwareVersion: ["Readable"]
//     value: 1.1
//     manufacturerDescription: Hardware Revision
//     maxLength: 64
//     format: string
//  Model: EveModel: ["Readable"]
//     value: Eve Weather 20EBS9901
//     manufacturerDescription: Model
//     maxLength: 64
//     format: string
//  Custom: EveADKVersion: ["Readable", "Hidden"]
//     value: "5.2";30b0d575
//     maxLength: 64
//     format: string
//  Firmware Version: EveFirmwareRevision: ["Readable"]
//     manufacturerDescription: Firmware Revision
//     maxLength: 64
//     format: string
//  Manufacturer: EveManufacturer: ["Readable"]
//     value: Eve Systems
//     manufacturerDescription: Manufacturer
//     maxLength: 64
//     format: string
// Eve Weather F3E8 n/n: EveCustomLogExchange
//  Custom: EveLogArray: ["Readable", "Hidden"]
//     value: {length = 40, bytes = 0x141f5a02 00104365 043f8109 871bdc27 ... cf1bd927 0103910b }
//     format: data
//  Custom: EveLogStatus: ["Readable", "Hidden"]
//     value: {length = 106, bytes = 0xd9182c1c b3129b46 614702bb cd95a53f ... 04e50b94 07510101 }
//     format: data
//  Custom: E863F11C-079E-48FF-8F27-9C2605A29F52: ["Writable", "Hidden"]
//     format: data
//  Custom: EveMaybeModelAndVersion: ["Writable", "Readable", "Hidden"]
//     value: {length = 18, bytes = 0x1f00010e5700b40b0b00ad2b2ef7526cef80}
//     format: data
//  Custom: EveTimeFromTotalizerReset: ["Writable", "Readable", "Hidden"]
//     value: 0
//     format: uint32
//  Custom: E863F158-079E-48FF-8F27-9C2605A29F52: ["Writable", "Readable", "Hidden"]
//     value: {length = 121, bytes = 0x80010000 0842941d a7af874d 1f01025c ... 34393436 34313436 }
//     format: data
//  Custom: E863F121-079E-48FF-8F27-9C2605A29F52: ["Writable", "Hidden"]
//     format: data
//  Custom: EveLogEntryMetadata: ["Readable", "Hidden"]
//     value: {length = 39, bytes = 0xff466504 72106304 ae694630 06010202 ... 0200f8fb 4b040100 }
//     format: data
//  Custom: E863F11D-079E-48FF-8F27-9C2605A29F52: ["Writable", "Hidden"]
//     format: data
// Eve Weather F3E8 n/y: EvePressure
//  Custom: EveAirPressure: ["Readable"]
//     value: 1020.1
//     manufacturerDescription: air-pressure
//     minimumValue: 870
//     maximumValue: 1100
//     stepValue: 0.1
//     format: float
//  Custom: EveAltitude: ["Writable", "Readable", "SupportsEventNotification"]
//     value: 51
//     manufacturerDescription: altitude
//     minimumValue: -450
//     maximumValue: 9000
//     stepValue: 1
//     format: float
//  Custom: EveWeatherTrend: ["Readable", "SupportsEventNotification"]
//     value: 3
//     manufacturerDescription: weather-trend
//     minimumValue: 0
//     maximumValue: 15
//     format: uint8
//  Name: Name: ["Readable"]
//     value: Eve Weather
//     manufacturerDescription: Name
//     maxLength: 64
//     format: string
// Humidity Sensor n/y: HumiditySensor
//  Name: Name: ["Readable"]
//     value: Eve Weather
//     manufacturerDescription: Name
//     maxLength: 64
//     format: string
//  Current Relative Humidity: CurrentRelativeHumidity: ["Readable", "SupportsEventNotification"]
//     value: 72
//     manufacturerDescription: Current Relative Humidity
//     minimumValue: 0
//     maximumValue: 100
//     stepValue: 1
//     format: float
//     units: percentage
// Temperature Sensor y/y: TemperatureSensor
//  Current Temperature: CurrentTemperature: ["Readable", "SupportsEventNotification"]
//     value: 24.2
//     manufacturerDescription: Current Temperature
//     minimumValue: -30
//     maximumValue: 100
//     stepValue: 0.1
//     format: float
//     units: celsius
//  Temperature Display Units: TemperatureUnits: ["Writable", "Readable", "SupportsEventNotification"]
//     value: 1
//     manufacturerDescription: Temperature Display Units
//     minimumValue: 0
//     maximumValue: 1
//     stepValue: 1
//     format: uint8
//  Name: Name: ["Readable"]
//     value: Eve Weather
//     manufacturerDescription: Name
//     maxLength: 64
//     format: string

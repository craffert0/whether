// SPDX-License-Identifier: GPL-2.0-or-later
// Copyright (C) 2026 Colin Rafferty <colin@rafferty.net>

import HomeKit

public let HMServiceTypeEvePressure = "E863F00A-079E-48FF-8F27-9C2605A29F52"
public let HMServiceTypeEveLogExchange = "E863F007-079E-48FF-8F27-9C2605A29F52"

public extension String {
    var serviceTypeReadable: String? {
        switch self {
        case HMServiceTypeEveLogExchange: "EveLogExchange"
        case HMServiceTypeEvePressure: "EvePressure"
        case HMServiceTypeAccessoryInformation: "AccessoryInformation"
        case HMServiceTypeAirPurifier: "AirPurifier"
        case HMServiceTypeAirQualitySensor: "AirQualitySensor"
        case HMServiceTypeBattery: "Battery"
        case HMServiceTypeCameraControl: "CameraControl"
        case HMServiceTypeCameraRTPStreamManagement: "CameraRTPStreamManagement"
        case HMServiceTypeCarbonDioxideSensor: "CarbonDioxideSensor"
        case HMServiceTypeCarbonMonoxideSensor: "CarbonMonoxideSensor"
        case HMServiceTypeContactSensor: "ContactSensor"
        case HMServiceTypeDoor: "Door"
        case HMServiceTypeDoorbell: "Doorbell"
        case HMServiceTypeFan: "Fan"
        case HMServiceTypeFaucet: "Faucet"
        case HMServiceTypeFilterMaintenance: "FilterMaintenance"
        case HMServiceTypeGarageDoorOpener: "GarageDoorOpener"
        case HMServiceTypeHeaterCooler: "HeaterCooler"
        case HMServiceTypeHumidifierDehumidifier: "HumidifierDehumidifier"
        case HMServiceTypeHumiditySensor: "HumiditySensor"
        case HMServiceTypeInputSource: "InputSource"
        case HMServiceTypeIrrigationSystem: "IrrigationSystem"
        case HMServiceTypeLabel: "Label"
        case HMServiceTypeLeakSensor: "LeakSensor"
        case HMServiceTypeLightbulb: "Lightbulb"
        case HMServiceTypeLightSensor: "LightSensor"
        case HMServiceTypeLockManagement: "LockManagement"
        case HMServiceTypeLockMechanism: "LockMechanism"
        case HMServiceTypeMicrophone: "Microphone"
        case HMServiceTypeMotionSensor: "MotionSensor"
        case HMServiceTypeOccupancySensor: "OccupancySensor"
        case HMServiceTypeOutlet: "Outlet"
        case HMServiceTypeSecuritySystem: "SecuritySystem"
        case HMServiceTypeSlats: "Slats"
        case HMServiceTypeSmokeSensor: "SmokeSensor"
        case HMServiceTypeSpeaker: "Speaker"
        case HMServiceTypeStatefulProgrammableSwitch: "StatefulProgrammableSwitch"
        case HMServiceTypeStatelessProgrammableSwitch: "StatelessProgrammableSwitch"
        case HMServiceTypeSwitch: "Switch"
        case HMServiceTypeTelevision: "Television"
        case HMServiceTypeTemperatureSensor: "TemperatureSensor"
        case HMServiceTypeThermostat: "Thermostat"
        case HMServiceTypeValve: "Valve"
        case HMServiceTypeVentilationFan: "VentilationFan"
        case HMServiceTypeWiFiRouter: "WiFiRouter"
        case HMServiceTypeWiFiSatellite: "WiFiSatellite"
        case HMServiceTypeWindow: "Window"
        case HMServiceTypeWindowCovering: "WindowCovering"
        default: nil
        }
    }
}

//
//  DeviceFile.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 17/10/24.
//

import Foundation

import UIKit

public extension UIDevice
{
    var modelName: String
    {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad7,5", "iPad7,6":                      return "iPad 6"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    static let deviceModelType: DeviceModelType = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> DeviceModelType { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod1,1":                                       return .iPod_touch
            case "iPod2,1":                                       return .iPod_touch_2nd_generation
            case "iPod3,1":                                       return .iPod_touch_3rd_generation
            case "iPod4,1":                                       return .iPod_touch_4th_generation
            case "iPod5,1":                                       return .iPod_touch_5th_generation
            case "iPod7,1":                                       return .iPod_touch_6th_generation
            case "iPod9,1":                                       return .iPod_touch_7th_generation
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return .iPhone_4
            case "iPhone4,1":                                     return .iPhone_4s
            case "iPhone5,1", "iPhone5,2":                        return .iPhone_5
            case "iPhone5,3", "iPhone5,4":                        return .iPhone_5c
            case "iPhone6,1", "iPhone6,2":                        return .iPhone_5s
            case "iPhone7,2":                                     return .iPhone_6
            case "iPhone7,1":                                     return .iPhone_6_Plus
            case "iPhone8,1":                                     return .iPhone_6s
            case "iPhone8,2":                                     return .iPhone_6s_Plus
            case "iPhone9,1", "iPhone9,3":                        return .iPhone_7
            case "iPhone9,2", "iPhone9,4":                        return .iPhone_7_Plus
            case "iPhone10,1", "iPhone10,4":                      return .iPhone_8
            case "iPhone10,2", "iPhone10,5":                      return .iPhone_8_Plus
            case "iPhone10,3", "iPhone10,6":                      return .iPhone_X
            case "iPhone11,2":                                    return .iPhone_XS
            case "iPhone11,4", "iPhone11,6":                      return .iPhone_XS_Max
            case "iPhone11,8":                                    return .iPhone_XR
            case "iPhone12,1":                                    return .iPhone_11
            case "iPhone12,3":                                    return .iPhone_11_Pro
            case "iPhone12,5":                                    return .iPhone_11_Pro_Max
            case "iPhone13,1":                                    return .iPhone_12_mini
            case "iPhone13,2":                                    return .iPhone_12
            case "iPhone13,3":                                    return .iPhone_12_Pro
            case "iPhone13,4":                                    return .iPhone_12_Pro_Max
            case "iPhone14,4":                                    return .iPhone_13_mini
            case "iPhone14,5":                                    return .iPhone_13
            case "iPhone14,2":                                    return .iPhone_13_Pro
            case "iPhone14,3":                                    return .iPhone_13_Pro_Max
            case "iPhone8,4":                                     return .iPhone_SE
            case "iPhone12,8":                                    return .iPhone_SE_2nd_generation
            case "iPhone14,6":                                    return .iPhone_SE_3rd_generation
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return .iPad_2
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return .iPad_3rd_generation
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return .iPad_4th_generation
            case "iPad6,11", "iPad6,12":                          return .iPad_5th_generation
            case "iPad7,5", "iPad7,6":                            return .iPad_6th_generation
            case "iPad7,11", "iPad7,12":                          return .iPad_7th_generation
            case "iPad11,6", "iPad11,7":                          return .iPad_8th_generation
            case "iPad12,1", "iPad12,2":                          return .iPad_9th_generation
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return .iPad_Air
            case "iPad5,3", "iPad5,4":                            return .iPad_Air_2
            case "iPad11,3", "iPad11,4":                          return .iPad_Air_3rd_generation
            case "iPad13,1", "iPad13,2":                          return .iPad_Air_4th_generation
            case "iPad13,16", "iPad13,17":                        return .iPad_Air_5th_generation
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return .iPad_mini
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return .iPad_mini_2
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return .iPad_mini_3
            case "iPad5,1", "iPad5,2":                            return .iPad_mini_4
            case "iPad11,1", "iPad11,2":                          return .iPad_mini_5th_generation
            case "iPad14,1", "iPad14,2":                          return .iPad_mini_6th_generation
            case "iPad6,3", "iPad6,4":                            return .iPad_Pro_9_7_inch
            case "iPad7,3", "iPad7,4":                            return .iPad_Pro_10_5_inch
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return .iPad_Pro_11_inch_1st_generation
            case "iPad8,9", "iPad8,10":                           return .iPad_Pro_11_inch_2nd_generation
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return .iPad_Pro_11_inch_3rd_generation
            case "iPad6,7", "iPad6,8":                            return .iPad_Pro_12_9_inch_1st_generation
            case "iPad7,1", "iPad7,2":                            return .iPad_Pro_12_9_inch_2nd_generation
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return .iPad_Pro_12_9_inch_3rd_generation
            case "iPad8,11", "iPad8,12":                          return .iPad_Pro_12_9_inch_4th_generation
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return .iPad_Pro_12_9_inch_5th_generation
            case "AppleTV5,3":                                    return .Apple_TV
            case "AppleTV6,2":                                    return .Apple_TV_4K
            case "AudioAccessory1,1":                             return .HomePod
            case "AudioAccessory5,1":                             return .HomePodMini
            case "i386", "x86_64", "arm64":                       return mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS")
            default:                                              return .unknown
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return .Apple_TV
            case "AppleTV6,2": return .Apple_TV_4K
            case "i386", "x86_64": return .simulator
            default: return .unknown
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()

    enum DeviceModelType : String {
        case iPod_touch = "iPod touch"
        case iPod_touch_2nd_generation = "iPod touch (2nd generation)"
        case iPod_touch_3rd_generation = "iPod touch (3rd generation)"
        case iPod_touch_4th_generation = "iPod touch (4th generation)"
        case iPod_touch_5th_generation = "iPod touch (5th generation)"
        case iPod_touch_6th_generation = "iPod touch (6th generation)"
        case iPod_touch_7th_generation = "iPod touch (7th generation)"
        case iPhone_4 = "iPhone 4"
        case iPhone_4s = "iPhone 4s"
        case iPhone_5 = "iPhone 5"
        case iPhone_5c = "iPhone 5c"
        case iPhone_5s = "iPhone 5s"
        case iPhone_6 = "iPhone 6"
        case iPhone_6_Plus = "iPhone 6 Plus"
        case iPhone_6s = "iPhone 6s"
        case iPhone_6s_Plus = "iPhone 6s Plus"
        case iPhone_7 = "iPhone 7"
        case iPhone_7_Plus = "iPhone 7 Plus"
        case iPhone_8 = "iPhone 8"
        case iPhone_8_Plus = "iPhone 8 Plus"
        case iPhone_X = "iPhone X"
        case iPhone_XS = "iPhone XS"
        case iPhone_XS_Max = "iPhone XS Max"
        case iPhone_XR = "iPhone XR"
        case iPhone_11 = "iPhone 11"
        case iPhone_11_Pro = "iPhone 11 Pro"
        case iPhone_11_Pro_Max = "iPhone 11 Pro Max"
        case iPhone_12_mini = "iPhone 12 mini"
        case iPhone_12 = "iPhone 12"
        case iPhone_12_Pro = "iPhone 12 Pro"
        case iPhone_12_Pro_Max = "iPhone 12 Pro Max"
        case iPhone_13_mini = "iPhone 13 mini"
        case iPhone_13 = "iPhone 13"
        case iPhone_13_Pro = "iPhone 13 Pro"
        case iPhone_13_Pro_Max = "iPhone 13 Pro Max"
        case iPhone_SE = "iPhone SE"
        case iPhone_SE_2nd_generation = "iPhone SE (2nd generation)"
        case iPhone_SE_3rd_generation = "iPhone SE (3rd generation)"
        case iPad_2 = "iPad 2"
        case iPad_3rd_generation = "iPad (3rd generation)"
        case iPad_4th_generation = "iPad (4th generation)"
        case iPad_5th_generation = "iPad (5th generation)"
        case iPad_6th_generation = "iPad (6th generation)"
        case iPad_7th_generation = "iPad (7th generation)"
        case iPad_8th_generation = "iPad (8th generation)"
        case iPad_9th_generation = "iPad (9th generation)"
        case iPad_Air = "iPad Air"
        case iPad_Air_2 = "iPad Air 2"
        case iPad_Air_3rd_generation = "iPad Air (3rd generation)"
        case iPad_Air_4th_generation = "iPad Air (4th generation)"
        case iPad_Air_5th_generation = "iPad Air (5th generation)"
        case iPad_mini = "iPad mini"
        case iPad_mini_2 = "iPad mini 2"
        case iPad_mini_3 = "iPad mini 3"
        case iPad_mini_4 = "iPad mini 4"
        case iPad_mini_5th_generation = "iPad mini (5th generation)"
        case iPad_mini_6th_generation = "iPad mini (6th generation)"
        case iPad_Pro_9_7_inch = "iPad Pro (9.7-inch)"
        case iPad_Pro_10_5_inch = "iPad Pro (10.5-inch)"
        case iPad_Pro_11_inch_1st_generation = "iPad Pro (11-inch) (1st generation)"
        case iPad_Pro_11_inch_2nd_generation = "iPad Pro (11-inch) (2nd generation)"
        case iPad_Pro_11_inch_3rd_generation = "iPad Pro (11-inch) (3rd generation)"
        case iPad_Pro_12_9_inch_1st_generation = "iPad Pro (12.9-inch) (1st generation)"
        case iPad_Pro_12_9_inch_2nd_generation = "iPad Pro (12.9-inch) (2nd generation)"
        case iPad_Pro_12_9_inch_3rd_generation = "iPad Pro (12.9-inch) (3rd generation)"
        case iPad_Pro_12_9_inch_4th_generation = "iPad Pro (12.9-inch) (4th generation)"
        case iPad_Pro_12_9_inch_5th_generation = "iPad Pro (12.9-inch) (5th generation)"
        case Apple_TV = "Apple TV"
        case Apple_TV_4K = "Apple TV 4K"
        case HomePod = "HomePod"
        case HomePodMini = "HomePod mini"
        
        case simulator = "simulator"
        case unknown = "unknown"
        
        func contains(_ whereElements: Self...) -> Bool {
            return whereElements.filter({ $0 == self }).count > 0
        }
        
    }
    
    
    
}

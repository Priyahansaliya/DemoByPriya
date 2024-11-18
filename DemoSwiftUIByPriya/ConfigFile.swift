//
//  ConfigFile.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 17/10/24.
//

import UIKit
import MobileCoreServices

let DeviceID = UIDevice.current.identifierForVendor!.uuidString
//MARK:- Devices Type
let IS_IPAD = (UIDevice.current.userInterfaceIdiom == .pad)
let IS_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
let osVersion = UIDevice.current.systemVersion
//var appDelegate : AppDelegate! { return UIApplication.shared.delegate as? AppDelegate }
//MARK:- Get Devices Width and Height
var SCREEN_WIDTH: CGFloat { return UIScreen.main.bounds.size.width }
var SCREEN_HEIGHT: CGFloat { return UIScreen.main.bounds.size.height }
var SCREEN_MAX_LENGTH: CGFloat { return max(SCREEN_WIDTH, SCREEN_HEIGHT) }
var SCREEN_MIN_LENGTH: CGFloat { return min(SCREEN_WIDTH, SCREEN_HEIGHT) }
let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
let IS_IPHONE_X = (IS_IPHONE && SCREEN_HEIGHT >= 812.0)

public typealias JSONObject = [String : Any]

var IS_IPHONE_PRO_MAX: Bool { return IS_IPHONE && SCREEN_HEIGHT >= 926 }
var IS_IPHONE_SE_DOWN_MODEL: Bool { return UIDevice.deviceModelType.contains(.iPhone_4, .iPhone_5, .iPhone_5c, .iPhone_5s, .iPhone_SE, .iPhone_SE_2nd_generation, .iPhone_SE_3rd_generation) }

var bottomMarginFromSafeArea: CGFloat {
    return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
}

var topMarginFromSafeArea: CGFloat {
    return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
}

var isDarkModeAppearance: Bool {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.userInterfaceStyle == .dark
    } else {
        return false
    }
}

var applicationName: String { return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "" }

let IS_IPHONE_WITH_NOTCH = (IS_IPHONE && STATUS_BAR_HEIGHT > 20)
let IPAD_MARGIN: CGFloat = 70

var STATUS_BAR_HEIGHT : CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.delegate?.window??.windowScene?.statusBarManager?.statusBarFrame.height ?? UIApplication.shared.statusBarFrame.height
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}



//MARK:- DeviceID
//let DeviceID = UIDevice.current.identifierForVendor!.uuidString //"75a30533aaaa87b"

//MARK:- NotificationCenter
let K_NC = NotificationCenter.default

//MARK:- DeviceID
//private var d_ID: String!
//var DeviceID: String {
//    if d_ID == nil {
//        d_ID = Global.uniQueID()
//    }
//    return d_ID
//}

//MARK:- TableView

let ALPHABETS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let NUMERIC = "1234567890"
let ALLOWED_SPECIAL_CHARACTER = "&@._-'/"
let ALPHABETS_NUMERIC_SPACE = "\(ALPHABETS)\(NUMERIC) "
let ALPHABETS_SPACE = "\(ALPHABETS) "
let MOBILE_LENGTH_VALIDATION = 10
let OTP_LENGTH = 6
let CIN_NO_LENGTH = 21
let PAN_CARD_LENGTH = 10
let GST_NO_LENGTH = 25
let Address_Length = 300
var textAlignmentNOA : NSTextAlignment = isRightToLeftLocalization ? .right : .left
var isRightToLeftLocalization = false
var ONLY_PDF_Types: [String] { return [kUTTypePDF as String] }
var AllDoc_Types: [String] { return ["public.content"] }
let arrdocTypesForProfile : [String] = ["public.image", kUTTypePDF as String]


var PHASSET_GIF_IMAGE_TYPE: String { return kUTTypeGIF as String }

func common_htmlStringWithDiv(font_size:Int = 36, htmlString: String) -> String {
    """
    <!doctype html>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <html>
        <head>
            <style>
                body {
                    font-size: \(font_size)px;
                    display:flex;
                }
            </style>
        </head>
        <body>
            <div>
                \(htmlString)
            </div>
        </body>
    </html>
    """

}

func getIPAddress() -> String {
    var address: String?
    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
    if getifaddrs(&ifaddr) == 0 {
        var ptr = ifaddr
        while ptr != nil {
            defer { ptr = ptr?.pointee.ifa_next }

            guard let interface = ptr?.pointee else { return "" }
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]

                let name: String = String(cString: (interface.ifa_name))
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
    }
    return address ?? ""
}

import Foundation

//MARK:- Get Value from Dict
func getInteger(anything: Any?) -> Int
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.intValue
        }
        else if let str = any as? NSString
        {
            return str.integerValue
        }
    }
    return 0
}

func getDouble(anything: Any?) -> Double
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.doubleValue
        }
        else if let str = any as? NSString
        {
            return str.doubleValue
        }
    }
    return 0
}

func getFloat(anything: Any?) -> Float
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.floatValue
        }
        else if let str = any as? NSString
        {
            return str.floatValue
        }
    }
    return 0
}

func getInteger64(anything: Any?) -> Int64
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.int64Value
        }
        else if let str = any as? NSString
        {
            return str.longLongValue
        }
    }
    return 0
}

func getString(anything: Any?) -> String
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.stringValue
        }
        else if let str = any as? String
        {
            return str
        }
        else if let char = any as? Character
        {
            return "\(char)"
        }
    }
    return ""
}

func getBoolean(anything: Any?) -> Bool
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return num.boolValue
        }
        else if let str = any as? NSString
        {
            return str.boolValue
        }
    }
    return false
}

func getCGFloat(anything: Any?) -> CGFloat
{
    if let any:Any = anything
    {
        if let num = any as? NSNumber
        {
            return CGFloat(num.floatValue)
        }
        else if let str = any as? NSString
        {
            return CGFloat(str.floatValue)
        }
    }
    return 0
}


extension String {
   
    var isStringEmpty : Bool {
        return !(trimming_WS_NL.count > 0)
    }
    
    var nsString : NSString {
        return NSString(string: self)
    }
    
    var trimming_WS_NL : String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimming_WS : String {
        return trimmingCharacters(in: .whitespaces)
    }
    
    var is_trimming_WS_NL_to_String : String? {
        return trimming_WS_NL.count > 0 ? self : nil
    }
}

extension String{
    //MARK:- Validation Functions
    //Length validation
    var isEmptyString: Bool {
        return trimming_WS_NL.count == 0
    }
    
    var isValidUrl: Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    var isValidPanCard : Bool {
        let regEx = "^([A-Z]){5}([0-9]){4}([A-Z]){1}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        // least one uppercase,
        // least one lowercase,
        // least one digit
        // least one special character
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$" //"^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
}

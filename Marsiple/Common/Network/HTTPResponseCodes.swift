//
//  HTTPResponseCodes.swift
//  Marsiple
//
//  Created by Matej Korman on 27/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum HTTPResponseCode: Int {
    case code200 = 200
    case code201 = 201
    case code204 = 204
    case code400 = 400
    case code401 = 401
    case code403 = 403
    case code404 = 404
    case code405 = 405
    case code406 = 406
    case code415 = 415
    
    var message: String {
        switch self {
        case .code200:
            return LocalizationKey.HTTPResponseCodes.code200.localized()
        case .code201:
            return LocalizationKey.HTTPResponseCodes.code201.localized()
        case .code204:
            return LocalizationKey.HTTPResponseCodes.code204.localized()
        case .code400:
            return LocalizationKey.HTTPResponseCodes.code400.localized()
        case .code401:
            return LocalizationKey.HTTPResponseCodes.code401.localized()
        case .code403:
            return LocalizationKey.HTTPResponseCodes.code403.localized()
        case .code404:
            return LocalizationKey.HTTPResponseCodes.code404.localized()
        case .code405:
            return LocalizationKey.HTTPResponseCodes.code405.localized()
        case .code406:
            return LocalizationKey.HTTPResponseCodes.code406.localized()
        case .code415:
            return LocalizationKey.HTTPResponseCodes.code415.localized()
        }
    }
}

//
//  HTTPResponseCodes.swift
//  Marsiple
//
//  Created by Matej Korman on 27/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum HTTPResponseCode: Int {
    case ok = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case unsupportedMediaType = 415
    
    var message: String {
        switch self {
        case .ok:
            return LocalizationKey.HTTPResponseCodes.ok.localized()
        case .created:
            return LocalizationKey.HTTPResponseCodes.created.localized()
        case .noContent:
            return LocalizationKey.HTTPResponseCodes.noContent.localized()
        case .badRequest:
            return LocalizationKey.HTTPResponseCodes.badRequest.localized()
        case .unauthorized:
            return LocalizationKey.HTTPResponseCodes.unauthorized.localized()
        case .forbidden:
            return LocalizationKey.HTTPResponseCodes.forbidden.localized()
        case .notFound:
            return LocalizationKey.HTTPResponseCodes.notFound.localized()
        case .methodNotAllowed:
            return LocalizationKey.HTTPResponseCodes.methodNotAllowed.localized()
        case .notAcceptable:
            return LocalizationKey.HTTPResponseCodes.notAcceptable.localized()
        case .unsupportedMediaType:
            return LocalizationKey.HTTPResponseCodes.unsupportedMediaType.localized()
        }
    }
}

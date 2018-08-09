//
//  FetcherError.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum DataManagerError: LocalizedError {
    case urlCreationFailure
    case dataUnwrapingFailure
    case parsingDataFailure
    case dataEncodingFailure
    case castingResponseFailure
    case httpResponseCode(Int)
    case generic(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlCreationFailure:
            return LocalizationKey.DataManagerError.urlCreationFailure.localized()
        case .dataUnwrapingFailure:
            return LocalizationKey.DataManagerError.dataUnwrapingFailure.localized()
        case .parsingDataFailure:
            return LocalizationKey.DataManagerError.parsingDataFailure.localized()
        case .dataEncodingFailure:
            return LocalizationKey.DataManagerError.dataEncodingFailura.localized()
        case .castingResponseFailure:
            return LocalizationKey.DataManagerError.castingResponseFailure.localized()
        case .httpResponseCode(let code):
            guard let message = HTTPResponseCode(rawValue: code)?.message
                else { return LocalizationKey.HTTPResponseCodes.unknownCode.localized() }
            return message
        case .generic(let error):
            return error.localizedDescription
        }
    }
}

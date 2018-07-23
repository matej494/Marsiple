//
//  FetcherError.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

enum DataFetcherError: LocalizedError {
    case urlCreationFailure
    case dataUnwrapingFailure
    case parsingDataFailure
    case generic(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlCreationFailure:
            return LocalizationKey.PostsFetcherError.urlCreationFailure.localized()
        case .dataUnwrapingFailure:
            return LocalizationKey.PostsFetcherError.dataUnwrapingFailure.localized()
        case .parsingDataFailure:
            return LocalizationKey.PostsFetcherError.parsingDataFailure.localized()
        case .generic(let error):
            return error.localizedDescription
        }
    }
}

//
//  LocalizationKey.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct LocalizationKey {
    struct Posts {
        static let navigationBarTitle = "posts_navigation_bar_title"
    }
    
    struct PostsFetcherError {
        static let urlCreationFailure = "posts_fetcher_url_creation_failure"
        static let dataUnwrapingFailure = "posts_fetcher_data_unwrapping_failure"
        static let parsingDataFailure = "posts_fetcher_parsing_data_failure"
    }
    
    struct PostDetails {
        static let navigationBarTitle = "post_details-navigation_bar_title"
    }
    
    struct Comment {
        static let navigationBarTitle = "comment_navigation_bar_title"
        static let successAlertTitle = "succes_alert_title"
        static let successAlertMessage = "succes_alert_message"
        static let failureAlertTitle = "failure_alert_title"
        static let failureAlertMessage = "failure_alert_message"
        static let okAlertAction = "ok_alert_action"
        static let cancelAlertAction = "cancel_alert_action"
        static let stayHereAlertAction = "stay_here_alert_action"
    }
    
    struct HTTPResponseCodes {
        static let code200 = "http_response_code_200"
        static let code201 = "http_response_code_201"
        static let code204 = "http_response_code_204"
        static let code400 = "http_response_code_400"
        static let code401 = "http_response_code_401"
        static let code403 = "http_response_code_403"
        static let code404 = "http_response_code_404"
        static let code405 = "http_response_code_405"
        static let code406 = "http_response_code_406"
        static let code415 = "http_response_code_415"
        static let unknownCode = "http_response_code_unknown_code"
    }
}

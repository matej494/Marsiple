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
    
    struct DataManagerError {
        static let urlCreationFailure = "data_manager_url_creation_failure"
        static let dataUnwrapingFailure = "data_manager_data_unwrapping_failure"
        static let parsingDataFailure = "data_manager_parsing_data_failure"
        static let dataEncodingFailura = "data_manager_data_encoding_failure"
        static let castingResponseFailure = "data_manager_casting_response_failure"
    }
    
    struct Todos {
        static let navigationBarTitle = "todos_navigation_bar_title"
        static let completedSectionHeader = "todos_completed_section_header"
    }

    struct PostDetails {
        static let navigationBarTitle = "post_details_navigation_bar_title"
    }
    
    struct BarButtonItem {
        static let commentTitle = "comment_bar_button_title"
        static let saveTitle = "save_bar_button_title"
    }
    
    struct Comment {
        static let navigationBarTitle = "comment_navigation_bar_title"
        static let successAlertTitle = "success_alert_title"
        static let successAlertMessage = "success_alert_message"
        static let failureAlertTitle = "failure_alert_title"
        static let failureAlertMessage = "failure_alert_message"
        static let okAlertAction = "ok_alert_action"
        static let cancelAlertAction = "cancel_alert_action"
        static let stayHereAlertAction = "stay_here_alert_action"
        static let commentTextPlaceholder = "comment_text_placeholder"
    }
    
    struct HTTPResponseCodes {
        static let ok = "http_response_code_200"
        static let created = "http_response_code_201"
        static let noContent = "http_response_code_204"
        static let badRequest = "http_response_code_400"
        static let unauthorized = "http_response_code_401"
        static let forbidden = "http_response_code_403"
        static let notFound = "http_response_code_404"
        static let methodNotAllowed = "http_response_code_405"
        static let notAcceptable = "http_response_code_406"
        static let unsupportedMediaType = "http_response_code_415"
        static let unknownCode = "http_response_code_unknown_code"
    }
}

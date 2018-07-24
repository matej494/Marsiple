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
    }
}

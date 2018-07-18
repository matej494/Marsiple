//
//  MatrianApi.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct MartianApi {
    static let url = "https://demo.martian.agency/api"
    
    struct Headers {
        static let contentType = "Content-Type"
        static let contentTypeValue = "application/json"
        static let xAuth = "X-Auth"
        static let xAuthValue = "bWFydGlhbmFuZG1hY2hpbmU="
    }
    struct Methods {
        static let get = "GET"
        static let post = "POST"
        static let put = "PUT"
        static let patch = "PATCH"
        static let delete = "DELETE"
    }
}

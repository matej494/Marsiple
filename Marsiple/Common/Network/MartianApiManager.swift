//
//  DataFetcher.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class MartianApiManager<DataType: Codable & Identifiable & Pathable> {
    static func getData(withParentId id: Int? = nil, success: @escaping ([DataType]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = createUrl(withParentId: id)
            else { return DispatchQueue.main.async { failure(DataManagerError.urlCreationFailure) } }
        getDataFromServer(url: url, success: success, failure: failure)
    }
    
    static func postData(data: DataType, success: @escaping (String) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = createUrl()
            else { return DispatchQueue.main.async { failure(DataManagerError.urlCreationFailure) } }
        print(url)
        uploadDataToServer(data: data, requestMethod: .post, url: url, success: success, failure: failure)
    }
    
    static func patchData(data: DataType, success: @escaping (String) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let url = createUrl(withDataTypeId: data.id)
            else { return DispatchQueue.main.async { failure(DataManagerError.urlCreationFailure) } }
        uploadDataToServer(data: data, requestMethod: .patch, url: url, success: success, failure: failure)
    }
}

private extension MartianApiManager {
    static func getDataFromServer(url: URL, success: @escaping ([DataType]) -> Void, failure: @escaping (LocalizedError) -> Void) {
        let request = URLRequest.martianApiURLRequest(url: url, method: .get)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async { failure(DataManagerError.generic(error)) }
            }
            do {
                guard let unwrappedData = data
                    else { return DispatchQueue.main.async { failure(DataManagerError.dataUnwrapingFailure) } }
                let decodedData = try JSONDecoder().decode([DataType].self, from: unwrappedData)
                DispatchQueue.main.async { success(decodedData) }
            } catch {
                DispatchQueue.main.async { failure(DataManagerError.parsingDataFailure) }
            }
        }
        task.resume()
    }
    
    static func uploadDataToServer(data: DataType, requestMethod: HTTPRequestMethod, url: URL, success: @escaping (String) -> Void, failure: @escaping (LocalizedError) -> Void) {
        guard let json = encodeData(data: data)
            else { return DispatchQueue.main.async { failure(DataManagerError.dataEncodingFailure) } }
        let request = URLRequest.martianApiURLRequest(url: url, method: requestMethod, body: json)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                return DispatchQueue.main.async { failure(DataManagerError.generic(error)) }
            }
            guard let httpResponse = response as? HTTPURLResponse
                else { return DispatchQueue.main.async { failure(DataManagerError.castingResponseFailure) } }
            if httpResponse.statusCode == HTTPResponseCode.created.rawValue && requestMethod == HTTPRequestMethod.post {
                return DispatchQueue.main.async { success(HTTPResponseCode.created.message) }
            } else if httpResponse.statusCode == HTTPResponseCode.ok.rawValue && requestMethod == HTTPRequestMethod.patch {
                return DispatchQueue.main.async { success(HTTPResponseCode.ok.message) }
            } else {
                return DispatchQueue.main.async { failure(DataManagerError.httpResponseCode(httpResponse.statusCode)) }
            }
        }
        task.resume()
    }

    static func encodeData(data: DataType) -> Data? {
        do {
            return try JSONEncoder().encode(data)
        } catch {
            print("Error encoding data.")
            return nil
        }
    }
    
    static func createUrl(withDataTypeId id: Int? = nil, withParentId parentid: Int? = nil) -> URL? {
        var url = MartianApi.url
        if let id = parentid {
            url = url?.appendingPathComponent(DataType.parentPath)
                .appendingPathComponent("\(id)")
        }
        url = url?.appendingPathComponent(DataType.path)
        if let id = id { url = url?.appendingPathComponent("\(id)") }
        return url
    }
}

//
//  network_helper.swift
//  concurrency_swift
//
//  Created by Jemi on 02/01/2022.
//

import Foundation

class NetworkHelper {
    
    static private var BASE_URL = "https://jsonplaceholder.typicode.com/"
    
    static func getData(path:String) async throws -> Data {
        let data = try await URLSession.shared.asyncData(from: URL(string: "\(BASE_URL)\(path)")!)
        return data.0
    }
    
}

extension URLSession {
    func asyncData(from url:URL) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                        let response = response
                else {
                    continuation.resume(throwing: AppError.noData)
                    return
                }
                continuation.resume(returning: (data, response))
                return
            }.resume()
        })
    }
}

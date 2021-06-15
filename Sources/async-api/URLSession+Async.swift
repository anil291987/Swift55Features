//
//  URLSession+Async.swift
//  async-api
//
//  Created by Upadhyay, Anil (623) on 14/06/21.
//

import Foundation

extension URLSession {
    func data(url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation({ continuation in
            dataTask(with: url) { data, _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    continuation.resume(returning: data)
                } else  {
                    continuation.resume(throwing: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Bad Response"]))
                }
            }
            .resume()
        })
    }
}

//
//  FetchAPITask.swift
//  async-api
//
//  Created by Alfian Losari on 5/29/21.
//

import Foundation

func fetchAPI<D: Decodable>(url: URL) async throws -> D {
    let task = Task {() -> D in
        try await fetchAndDecode(url: url)
    }
    
    return try await task.value
}
func fetchAndDecode<D: Decodable>(url: URL) async throws -> D {
    let data = try await URLSession.shared.data(url: url)
    let decodedData = try JSONDecoder().decode(D.self, from: data)
    return decodedData
}

func fetchAPIGroup<D: Decodable>(urls: [URL]) async throws -> [D] {
    try await withThrowingTaskGroup(of: D.self){ group in
        for url in urls {
            group.async {
                try await fetchAndDecode(url: url)
            }
        }
        
        var results = [D] ()
        for try await result in group {
            results.append(result)
        }
        return results
    }
}

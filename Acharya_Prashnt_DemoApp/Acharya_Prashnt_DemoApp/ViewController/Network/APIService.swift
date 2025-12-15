//
//  APIService.swift
//  Acharya_Prashnt's_DemoApp
//
//  Created by Mayank on 13/12/25.
//

import Foundation

final class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchCoverages(limit: Int) async throws -> [MediaCoverage] {
        let urlString =
        "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=\(limit)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([MediaCoverage].self, from: data)
    }
}

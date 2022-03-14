//
//  APICaller.swift
//  Trading App
//
//  Created by Pengju Zhang on 3/13/22.
//

import Foundation
import SwiftUI
final class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadLinesURL = URL(
            string: "https://cryptopanic.com/api/v1/posts/?auth_token=a9639a0fe322f49013587bb3be81ed2016cfae0e"
        )
    }
    
    private init() {}
    
    public func getNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.topHeadLinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.results[0].title)")
                    completion(.success(result.results))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}

// model

struct APIResponse: Codable {
    let results: [Article]
}

struct Article: Codable {
    let title: String
    let published_at: String
}

//
//  WebServer.swift
//  Coin Info
//
//  Created by Pengju Zhang on 3/8/22.
//

import Foundation

enum CoinError: Error {
    case invalidServerResponse
}

class WebServer {
    func getCoins(url: URL) async throws -> [CoinAPIModel] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw CoinError.invalidServerResponse
              }
        return try JSONDecoder().decode([CoinAPIModel].self, from: data)
    }
}

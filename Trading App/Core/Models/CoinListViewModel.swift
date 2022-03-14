//
//  CoinListViewModel.swift
//  Coin Info
//
//  Created by Pengju Zhang on 3/8/22.
//

import Foundation

class CoinListViewModel {
    
    private(set) var coins: [CoinViewModel] = []
    
    func populateCoins(url: URL) async {
        
        do {
            let coins = try await WebServer().getCoins(url: url)
            self.coins = coins.map(CoinViewModel.init)
        }
        catch {
            print(error)
        }
    }
}

struct CoinViewModel {
    
    private let coin: CoinAPIModel
    
    init(coin: CoinAPIModel) {
        self.coin = coin
    }
    
    var name: String {
        coin.name
    }
    
    var current_price: Double {
        coin.current_price
    }
    
    var image: String {
        coin.image
    }
    
    var price_change_percentage_24h_in_currency: Double {
        coin.price_change_percentage_24h_in_currency
    }
}

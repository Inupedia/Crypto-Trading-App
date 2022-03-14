//
//  Constaints.swift
//  Coin Info
//
//  Created by Pengju Zhang on 3/8/22.
//

import Foundation
struct Constaints {
    struct Urls {
        static let allCoins = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&price_change_percentage=24h")!
    }
}

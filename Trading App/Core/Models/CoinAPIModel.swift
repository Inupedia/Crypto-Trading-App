//
//  CoinAPIModel.swift
//  Coin Info
//
//  Created by Pengju Zhang on 3/8/22.
//

import Foundation
struct CoinAPIModel: Decodable {
    
    var name: String
    var current_price: Double
    var image: String
    var price_change_percentage_24h_in_currency: Double
    
}

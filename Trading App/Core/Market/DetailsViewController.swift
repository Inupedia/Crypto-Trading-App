//
//  ViewController.swift
//  Coin Info
//
//  Created by Pengju Zhang on 3/8/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var info: UILabel!
    var coinAPIModel: CoinViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let coin = coinAPIModel {
            let trend: String = coin.price_change_percentage_24h_in_currency > 0 ? "increased" : "decreased"
            coinName.text = coin.name
            info.text = "\(coin.name) is \(trend) by \(coin.price_change_percentage_24h_in_currency) percent in 24 hours"
        }
    }

}


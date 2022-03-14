//
//  ViewController.swift
//  Trading App
//
//  Created by Pengju Zhang on 2/14/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let vm = CoinListViewModel()
    @IBOutlet weak var AI_Bot_CardView: UIView!
    @IBOutlet weak var AI_Bot_CardEffect: UIVisualEffectView!
    @IBOutlet weak var positionCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await populateCoins()
        }
    }
    private func populateCoins() async {
        await vm.populateCoins(url: Constaints.Urls.allCoins)
        DispatchQueue.main.async {
            self.positionCollection.delegate = self
            self.positionCollection.dataSource = self
        }
        // print(vm.coins)
    }
    @IBAction func trialButtonAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Maintenance", message: "AI Trading WIP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present (alert, animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(vm.coins.count)
        return vm.coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coin = vm.coins[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PositionCell", for: indexPath) as! PositionCollectionViewCell
        cell.coinNameLabel.text = coin.name
        cell.percentLabel.text = "\(round(coin.price_change_percentage_24h_in_currency * 100) / 100.0) %"
        cell.percentLabel.textColor = UIColor.green
        cell.priceLabel.text = "\(coin.current_price)"
        cell.gradient.colors = [UIColor.red.cgColor, UIColor.systemPink.cgColor]
        cell.banner.load(url: coin.image)
        return cell
    }
    
    
}

extension UIImageView {
    func load(url: String) {
        guard let url = URL(string: url) else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
// preview
//#if DEBUG && canImport(SwiftUI)
//import SwiftUI
//
//@available(iOS 13, *)
//struct ViewControllerPreview: PreviewProvider {
//    static var previews: some View {
//        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController").toPreview()
//            .preview(Preview(device: .iPhone_13_Pro_Max, colorScheme: .light))
//    }
//}
//#endif

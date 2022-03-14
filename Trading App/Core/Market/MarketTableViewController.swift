//
//  MarketTableViewController.swift
//  Trading App
//
//  Created by Pengju Zhang on 3/11/22.
//

import UIKit

class MarketTableViewController: UITableViewController {
    
    private let vm = CoinListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await populateCoins()
        }
    }

    private func populateCoins() async {
        await vm.populateCoins(url: Constaints.Urls.allCoins)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(vm.coins)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vm.coins.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coin = vm.coins[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = coin.name
        cell.detailTextLabel?.text = String(coin.current_price)
        cell.detailTextLabel?.textColor = coin.price_change_percentage_24h_in_currency > 0 ? UIColor.green : UIColor.red
        // cell.imageView?.image = UIImage(named: "robot 3")
        cell.imageView?.load(url: coin.image)
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {
           if let indexPath = self.tableView.indexPathForSelectedRow {
               detailsViewController.coinAPIModel = vm.coins[indexPath.row]
           }
       }
    }


}


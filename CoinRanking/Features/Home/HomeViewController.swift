//
//  HomeViewController.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation

import UIKit

class HomeViewController: UITableViewController {
    
    private var coins: [Coin] = []
    private let viewModel = HomeViewModel()
    private let favouritesViewModel = FavouritesViewmodel()
    
    private var limit = 20
    private var offset = 0
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coins"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetchData()
    }
    
    private func fetchData() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            let newCoins = await viewModel.fetchData(limit: "\(limit)", offset: "\(offset)")
            DispatchQueue.main.async {
                self.coins.append(contentsOf: newCoins)
                self.tableView.reloadData()
                self.offset += self.limit
                self.title = "Coins \(self.coins.count)"
                self.isLoading = false
            }
        }
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let coin = coins[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = coin.name ?? "--"
        content.textProperties.font = UIFont.systemFont(ofSize: 16)
        cell.contentConfiguration = content

        // Star button setup
        let starButton = UIButton(type: .system)
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.tintColor = .systemBlue
        starButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30) // IMPORTANT!
        starButton.addAction(UIAction { [weak self] _ in
            self?.favouritesViewModel.saveCoin(coin: coin)
        }, for: .touchUpInside)

        cell.accessoryView = starButton
        return cell
    }


    // MARK: - Pagination

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height * 2 {
            fetchData()
            title = "Coins \(coins.count)"
        }
    }
}

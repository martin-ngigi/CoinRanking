//
//  LocalFavouritesDataSource.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation
import CoreData

class LocalFavouritesDataSource {
    
    private let viewContext = DataProvider.shared.nsPersistentContainer.viewContext
    
    func fetchFavourites() -> [Coin] {
        let request = CoinLocal.fetchRequest()
        do {
            let coinLocals: [CoinLocal] = try viewContext.fetch(request)
            let coins = coinLocals.compactMap { coinLocal -> Coin? in
                return Coin(coinLocal: coinLocal)
            }
            print("fetchFavourites coins: \(coins.count)")
            return coins
        }
        catch {
            return []
        }
    }
    
    func saveCoin(coin: Coin) {
        let coinLocal = CoinLocal(context: viewContext)
        coinLocal.uuid = coin.uuid
        coinLocal.name = coin.name
        try? viewContext.save()
        print("saveCoin coins: \(coinLocal)")
    }
    
    
    func deleteCoin(coin: Coin){
        let request = CoinLocal.fetchRequest()
        do {
            let coinLocals: [CoinLocal] = try viewContext.fetch(request)
            guard let coinLocal = coinLocals.first(where: { $0.uuid == coin.uuid }) else {
                return
            }
            viewContext.delete(coinLocal)
            try? viewContext.save()
        }
        catch {

        }
    }
}

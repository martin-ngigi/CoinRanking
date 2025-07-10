//
//  FavouritesViewmodel.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation

class FavouritesViewmodel: ObservableObject{
    var datasource = LocalFavouritesDataSource()
    
    func saveCoin(coin: Coin){
        datasource.saveCoin(coin: coin)
    }
    
    func fetchFavourites() -> [Coin]{
        let favourites = datasource.fetchFavourites()
        return favourites
    }
    
    func deleteCoin(coin: Coin){
        datasource.deleteCoin(coin: coin)
    }
}

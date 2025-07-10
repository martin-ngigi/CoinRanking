//
//  FavouritesView.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import SwiftUI

struct FavouritesView: View {
    @StateObject var favouritesViewmodel = FavouritesViewmodel()
    @State var favourites: [Coin] = []
    
    var body: some View {
        List{
            Text("Total favourites: \(favourites.count)")

            ForEach(favourites, id: \.uuid) { item in
                Text(item.name ?? "--")
            }
            .onDelete(perform: deleteItems)
        }
        .onAppear{
            favourites = favouritesViewmodel.fetchFavourites()
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
          for index in offsets {
              favouritesViewmodel.deleteCoin(coin: favourites[index])
          }
          favourites.remove(atOffsets: offsets)
      }
}

#Preview {
    FavouritesView()
}

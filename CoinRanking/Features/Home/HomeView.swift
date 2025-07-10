//
//  HomeView.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State var coins: [Coin] = []
    @State var limit = 20
    @State var offset = 0
    var body: some View {
        VStack{
            Text("Total coins: \(coins.count)")
            List{
                ForEach(coins, id: \.uuid) { item in
                    Text(item.name ?? "--")
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.4))
                        .cornerRadius(8)
                }
                
                Color.clear
                    .onAppear {
                        Task{ await fetchMoreData()}
                    }
            }
            .listStyle(.plain)
        }
    }
    
    func fetchMoreData() async {
        let newCoins = await homeViewModel.fetchData(limit: "\(limit)", offset: "\(offset)")
        if newCoins.isEmpty { return }
        for coin in newCoins {
            coins.append(coin)
        }
        offset += limit
    }
    
    private func shouldLoadMore(item: Coin) -> Bool {
        return item.uuid == coins.last?.uuid && !homeViewModel.isFetching
    }

}

#Preview {
    HomeView()
}

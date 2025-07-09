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
            ScrollView(showsIndicators: false) {
                VStack{
                    ForEach(coins, id: \.uuid){ item in
                        Text(item.name)
                            .padding(15)
                            .frame(maxWidth: .infinity)
                            .background(.gray.opacity(0.4))
                            .cornerRadius(8)
                            .onAppear{
                                Task {
                                    print("DEBUG: name \(item.name), item.uuid  \(item.uuid), coins.last?.uuid  \(coins.last?.uuid ?? "") isLast \(item.uuid == coins.last?.uuid )")

                                    if shouldLoadMore(item: item) {
                                        Task {
                                            await fetchMoreData()
                                        }
                                    }
                                }
                            }
                        
                    }
                    
                    if homeViewModel.isFetching{
                        ProgressView()
                    }
                }
                .padding()
            }
            .onAppear{
                Task {
                    coins = await homeViewModel.fetchData(limit: "\(limit)", offset: "\(offset)")
                }
            }
            
        }
    }
    
    /*
    func fetchMoreData() async{
        offset += limit
        coins += await homeViewModel.fetchData(limit: "\(limit)", offset: "\(offset)")
    }
    */
    
    func fetchMoreData() async {
        offset += limit
        let newCoins = await homeViewModel.fetchData(limit: "\(limit)", offset: "\(offset)")
        if newCoins.isEmpty { return }
        coins += newCoins
    }
    
    private func shouldLoadMore(item: Coin) -> Bool {
        return item.uuid == coins.last?.uuid && !homeViewModel.isFetching
    }

}

#Preview {
    HomeView()
}

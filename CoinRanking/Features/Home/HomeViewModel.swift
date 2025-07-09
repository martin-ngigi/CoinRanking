//
//  HomeViewModel.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import Foundation


class HomeViewModel: ObservableObject {
    @Published var isFetching = false

    @MainActor
    func fetchData(limit: String, offset: String) async ->  [Coin]  {
        guard !isFetching else { return [] }
        isFetching = true
        defer { isFetching = false }
        
        guard let url = URL(string: "\(Constants.baseURL)/coins/?limit=\(limit)&offset=\(offset)") else { return []}
        let results = await APICallUtil.shared.fetch(
            returnType: CoinsModel.self,
            url: url
        )
        switch results {
        case .success(let response):
            return response.data.coins
        case .failure(let failure):
            print("DEBUG: fetchData \(failure)")
            return []
        }
    }
}

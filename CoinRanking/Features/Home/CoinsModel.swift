//
//  CoinsModel.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import Foundation

struct CoinsModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let coins: [Coin]
}

struct Coin: Codable {
    let uuid, symbol, name, color: String?
    let iconURL: String?
    let marketCap, price: String?
    let listedAt, tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String]?
    let lowVolume: Bool?
    let coinrankingURL: String?
    let the24HVolume, btcPrice: String?
    let contractAddresses: [String]?
    let isWrappedTrustless: Bool?

    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinrankingURL = "coinrankingUrl"
        case the24HVolume = "24hVolume"
        case btcPrice, contractAddresses, isWrappedTrustless
    }
    
    init(
        uuid: String? = nil,
        symbol: String? = nil,
        name: String? = nil,
        color: String? = nil,
        iconURL: String? = nil,
        marketCap: String? = nil,
        price: String? = nil,
        listedAt: Int? = nil,
        tier: Int? = nil,
        change: String? = nil,
        rank: Int? = nil,
        sparkline: [String]? = nil,
        lowVolume: Bool? = nil,
        coinrankingURL: String? = nil,
        the24HVolume: String? = nil,
        btcPrice: String? = nil,
        contractAddresses: [String]? = nil,
        isWrappedTrustless: Bool? = nil
    ) {
        self.uuid = uuid
        self.symbol = symbol
        self.name = name
        self.color = color
        self.iconURL = iconURL
        self.marketCap = marketCap
        self.price = price
        self.listedAt = listedAt
        self.tier = tier
        self.change = change
        self.rank = rank
        self.sparkline = sparkline
        self.lowVolume = lowVolume
        self.coinrankingURL = coinrankingURL
        self.the24HVolume = the24HVolume
        self.btcPrice = btcPrice
        self.contractAddresses = contractAddresses
        self.isWrappedTrustless = isWrappedTrustless
    }
    
    init?(coinLocal: CoinLocal) {
        self.init(
            uuid: coinLocal.uuid,
            name: coinLocal.name
        )
    }
}





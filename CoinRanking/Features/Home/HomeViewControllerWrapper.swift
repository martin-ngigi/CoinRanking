//
//  HomeViewControllerWrapper.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation

import SwiftUI

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let homeVC = HomeViewController()
        let navController = UINavigationController(rootViewController: homeVC)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

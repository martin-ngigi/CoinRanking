//
//  HomeViewControllerWrapper.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation

import SwiftUI

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // No updates needed for now
    }
}

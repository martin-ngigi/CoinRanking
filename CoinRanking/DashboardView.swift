//
//  DashboardView.swift
//  CoinRanking
//
//  Created by Hummingbird on 08/07/2025.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)
            
            FavouritesView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(1)
            
            Text("More")
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .accentColor(.blue) // Customize selected tab color
    }
}

#Preview {
    DashboardView()
}

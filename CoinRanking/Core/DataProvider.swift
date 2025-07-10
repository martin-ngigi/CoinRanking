//
//  DataProvider.swift
//  CoinRanking
//
//  Created by Hummingbird on 10/07/2025.
//

import Foundation
import CoreData

struct DataProvider {
    static let shared = DataProvider()
    let nsPersistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        nsPersistentContainer.viewContext
    }
    
    private init() {
        nsPersistentContainer = NSPersistentContainer(name: "CoreData")
        nsPersistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("Unable to load persistent stores: \(error)")
            }
        }
    }
}

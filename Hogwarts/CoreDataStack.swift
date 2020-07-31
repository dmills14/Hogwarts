//
//  CoreDataStack.swift
//  Hogwarts
//
//  Created by Drew Miller on 7/30/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Hogwarts") //Change name to project
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo), \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
    
}


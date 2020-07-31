//
//  HouseGuessController.swift
//  Hogwarts
//
//  Created by Drew Miller on 7/30/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import Foundation
import CoreData

class HouseGuessController {
    
    //MARK: - Singleton
    static let shared = HouseGuessController()
    
    //MARK: - Properties - Source of Truth
    let fetchedResultsController: NSFetchedResultsController<HouseGuess> = {
        
        let fetchRequest: NSFetchRequest<HouseGuess> = HouseGuess.fetchRequest()
        let veiledSort = NSSortDescriptor(key: "isVisible", ascending: false)
        
        fetchRequest.sortDescriptors = [veiledSort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isVisible", cacheName: nil)
    }()
    
    init() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---n \(error)")
        }
    }
    
    //MARK: - CRUD
    func createGuess(guessName: String, house: String) {
        // 1. Create an instance
        let newGuess = HouseGuess(guessName: guessName, house: house)
        
        // 2.  Jump to persistence and then write the save part
        //Save
        saveToPersistentStore()
    }
    
    func updateVisibility(houseGuess: HouseGuess) {
        houseGuess.isVisible.toggle()
        // houseGuess.isVisible = !houseGuess.isVisible
        //Save
        saveToPersistentStore()
    }
    
    func remove(houseGuess: HouseGuess) {
        
        let moc = CoreDataStack.context
        moc.delete(houseGuess)
        //Save
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    //Now that persistence is created, add to create, update, and remove
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
           print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}//end of class

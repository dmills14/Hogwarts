//
//  MainTableViewController.swift
//  Hogwarts
//
//  Created by Drew Miller on 7/30/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        presentAlertController()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return HouseGuessController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return HouseGuessController.shared.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Guard because it is a custom cell
        //Can't can't until a custom TableViewCellController is created.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "guessCell", for: indexPath) as? HouseGuessTableViewCell else { return UITableViewCell() }
        
        let guessToDisplay = HouseGuessController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.guess = guessToDisplay
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //If using CoreData, use your remove function here.
            let guessToDelete = HouseGuessController.shared.fetchedResultsController.object(at: indexPath)
            HouseGuessController.shared.remove(houseGuess: guessToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 7
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HouseGuessController.shared.fetchedResultsController.sectionIndexTitles[section]
            == "0" ? "Invisibility Cloack" : "Visibility"
    }
    
    //MARK: - Helpers
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Add House Guess", message: nil, preferredStyle: .alert)
        //Index 0
        alertController.addTextField { (textField) in
            textField.placeholder = "Person's name..."
        }
        //Index 1
        alertController.addTextField { (textField) in
            textField.placeholder = "Person's Hogwarts House..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addGuessAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let guessName = alertController.textFields?[0].text, !guessName.isEmpty, let house = alertController.textFields![1].text, !house.isEmpty else { return }
            
            HouseGuessController.shared.createGuess(guessName: guessName, house: house)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(addGuessAction)
        
        present(alertController, animated: true)
        
    }//end of function
    
}//end of class

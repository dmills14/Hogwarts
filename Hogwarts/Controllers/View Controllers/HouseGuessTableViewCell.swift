//
//  HouseGuessTableViewCell.swift
//  Hogwarts
//
//  Created by Drew Miller on 7/30/20.
//  Copyright © 2020 DevMtn. All rights reserved.
//

import UIKit

class HouseGuessTableViewCell: UITableViewCell {

    //Landing Pad
    var guess: HouseGuess? {
        didSet {
            updateViews()
        }
    }
    //MARK: - Outlets
    @IBOutlet weak var personGuessLabel: UILabel!
    @IBOutlet weak var houseImageButton: UIButton!
    
    
    //MARK: - Actions
    @IBAction func houseButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Helpers
    
    func updateViews() {
        
        guard let guess = guess else { return }
        personGuessLabel.text = guess.guessName
        //Next add updateViews() to computed property of guess
    }
    
}//end of class

//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by John Tate on 8/29/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {


    // MARK: - Properties
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    

    // MARK: - Button
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    
    func updateButton(_ isComplete: Bool) {
        let image = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: image), for: .normal)
    }
    
}

extension ButtonTableViewCell {
    
    func update(withTask task: Task) {
        
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

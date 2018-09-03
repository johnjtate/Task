//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by John Tate on 8/29/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
    
}


class ButtonTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    var task: Task? {
        didSet{
           updateViews()
        }
    }

    func updateViews(){
        guard let task = task else {return}
        primaryLabel.text = task.name
        if task.isComplete {
            completeButton.imageView?.image = #imageLiteral(resourceName: "complete")
        } else {
            completeButton.imageView?.image = #imageLiteral(resourceName: "incomplete")
        }
        updateButton()
    }
    
    var delegate: ButtonTableViewCellDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    

    // MARK: - Button
    
    @IBAction func buttonTapped(_ sender: Any) {
        updateViews()
        delegate?.buttonCellButtonTapped(self)
        
    }
    
    func updateButton() {
        
        guard let task = task else { return }
        
        if task.isComplete{
            completeButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            completeButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
    
}

extension ButtonTableViewCell {
    
    func update(withTask task: Task) {
        primaryLabel.text = task.name
        updateButton()
    }
}



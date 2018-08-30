//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by John Tate on 8/29/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
    }

    // MARK: Properties
    
    var task: Task? {
        didSet{
            if isViewLoaded{
            updateViews()
            }
        }
    }
        
    var dueDateValue: Date?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    // MARK: Button Actions
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text else {return}
        let notes = notesTextView.text
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: dueDateValue)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: dueDateValue)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dueDateValue = dueDatePicker.date
        // Will set dueDateTextField to the date picker value
        updateViews()
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        resignFirstResponder()
    }
    
    
    
    // MARK: Data Source
    
    func updateViews() {
        taskNameTextField.text = task?.name
        if let dueDate = dueDateValue {
            dueDateTextField.text = dueDate.stringValue()
        } else {
            dueDateTextField.text = Date().stringValue()
        }
        notesTextView.text = task?.notes
    }
    
}

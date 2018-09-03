//
//  TaskListTableViewController.swift
//  Task
//
//  Created by John Tate on 8/30/18.
//  Copyright © 2018 John Tate. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else {return}
        let task = TaskController.shared.fetchedResultsController.object(at: index)
        TaskController.shared.toggleIsCompleteFor(task: task)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchedResultsController.delegate = self
        TaskController.shared.load()
    }

    // MARK: - MSFetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        tableView.reloadData()
        // able to put something here to protect against crashing when one of the table sections becomes empty?
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return TaskController.shared.fetchedResultsController.sections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = TaskController.shared.fetchedResultsController.sections else { fatalError("No sections in fetchedResultsController")}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskListCell", for: indexPath) as? ButtonTableViewCell
        let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
        cell?.delegate = self 
        cell?.task = task
        return cell ?? UITableViewCell()
    }
 
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        guard let sectionInfo = TaskController.shared.fetchedResultsController.sections?[section] else {return nil}
        
        return section == 0 ? "Incomplete" : "Complete"
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let task = TaskController.shared.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            TaskController.shared.remove(task: task)
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailTask" {
            if let detailViewController = segue.destination as? TaskDetailTableViewController {
                
                if let selectedRow = tableView.indexPathForSelectedRow?.row {
                    let task = TaskController.shared.fetchedResultsController.fetchedObjects?[selectedRow]
                    detailViewController.task = task
                    detailViewController.dueDateValue = task?.due
                }
            }
        }
    }
}

//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by Артур Дохно on 25.02.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func plusTask(_ sender: Any) {
        let alertController = UIAlertController(title: "Новая задача",
                                                message: "Введите задачу",
                                                preferredStyle: .alert)
        let saveTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTask = textField?.text {
                self.tasks.insert(newTask, at: 0)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }

    
}

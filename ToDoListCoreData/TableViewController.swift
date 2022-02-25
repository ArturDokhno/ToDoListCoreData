//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by Артур Дохно on 25.02.2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var tasks: [Tasks] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

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
                self.saveTask(wuthTitle: newTask)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        if let tasks = try? context.fetch(fetchRequest) {
            for task in tasks {
                context.delete(task)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
    }
    
    func saveTask(wuthTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }

    
}

//
//  TableViewController.swift
//  ToDoListCoreData
//
//  Created by Артур Дохно on 25.02.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks: [String] = ["Artur IOS Developer"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

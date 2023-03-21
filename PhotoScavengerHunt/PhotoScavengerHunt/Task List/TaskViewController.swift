//
//  TaskViewController.swift
//  PhotoScavengerHunt
//
//  Created by CHENGTAO on 3/19/23.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskTableView.tableHeaderView = UIView()
        
        taskTableView.dataSource = self
        
        tasks = Task.mockedTasks
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This will reload data in order to reflect any changes made to a task after returning from the detail screen.
        taskTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        // Get the cell that triggered the segue
//        if let cell = sender as? UITableViewCell,
//           // Get the index path of the cell from the table view
//           let indexPath = taskTableView.indexPath(for: cell),
//           // Get the TaskDetailViewController (who we want to send data for)
//        let taskDetailViewController = segue.destination as? TaskDetailViewController {
//
//            // Set the track on the detail view controller
//            taskDetailViewController.task = tasks[indexPath.row]
//
//        }
        
        // On the other way
        if let taskDetailViewController = segue.destination as? TaskDetailViewController,
           
            // Get the index path for the current selected table view row.
           let selectedIndexPath = taskTableView.indexPathForSelectedRow {
            
            // Get the task associated with the selected index path and Set the selected task on the detail view controller.
            taskDetailViewController.task = tasks[selectedIndexPath.row]
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            fatalError("Unable to dequeue Task Cell")
        }
        
        cell.configure(with: tasks[indexPath.row])
        
        return cell
        
    }
    
    
}

//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 20/08/23.
//

import UIKit
import CoreData
import SnapKit

class TaskVC: UIViewController {
    
    var todoListItem: [Task2] = []
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let conteiner = AppDelegate.container.viewContext
        let featchRequest: NSFetchRequest<Task2> = Task2.fetchRequest()
        
        do{
            todoListItem = try conteiner.fetch(featchRequest)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    func configure(){
        navigationItem.title = "ToDo List"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(0)
        }

    }

    @objc func addButtonTapped() {
      
        let ac = UIAlertController(title: "Add Task", message: "add", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = ac.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
            self.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .default)
        ac.addTextField()
        ac.addAction(ok)
        ac.addAction(cancel)

        present(ac, animated: true)
    }
    
    func saveTask(taskToDo: String){
        
        let conteiner = AppDelegate.container.viewContext
        let task = Task2(context: conteiner)
        task.taskToDo = taskToDo
        
        do{
            try conteiner.save()
            todoListItem.append(task)
        }catch{
            print(error.localizedDescription)
        }
        
    }

}

extension TaskVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = todoListItem[indexPath.row]
        cell.textLabel?.text = task.taskToDo
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let task = todoListItem[indexPath.row]
            todoListItem.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            let context = AppDelegate.container.viewContext
            context.delete(task)
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

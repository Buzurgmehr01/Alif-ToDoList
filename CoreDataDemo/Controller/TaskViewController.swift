//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 20/08/23.
//

import UIKit
import CoreData
import SnapKit

protocol TaskUpdateDelegate: AnyObject{
    func didUpdateTasks()
}

class TaskViewController: UIViewController, TaskUpdateDelegate {
    
    let coreDataManager = CoreDataManager.shared
    let tableView = UITableView()
    var items:[SaveEntity] = []
    lazy var taskManager: Taskmanager = {
        Taskmanager.init(coreDataManeger: coreDataManager)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = taskManager.getTasks()
        configure()
    }
    
    
    func didUpdateTasks() {
        items = taskManager.getTasks()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func configure(){
        navigationItem.title = "Задачи"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        view.backgroundColor = .mainViewColor
        tableView.backgroundColor = .mainViewColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func addButtonTapped() {
        
        let alertControler = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) {  [weak alertControler] _ in
            guard let textFields = alertControler?.textFields, textFields.count >= 2 else {return}
            
            if let titleTF = textFields[0].text, !titleTF.isEmpty,
               let desriptionTF = textFields[1].text, !desriptionTF.isEmpty {
                
                self.taskManager.saveTask(title: titleTF, description: desriptionTF) { [weak self] tasks in
                        if let tasks = tasks {
                            self?.items = tasks
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: tasks.count - 1, section: 0)
                                self?.tableView.beginUpdates()
                                self?.tableView.insertRows(at: [indexPath], with: .automatic)
                                self?.tableView.endUpdates()
                            }
                        } else {
                            print("Error")
                            
                        }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .default)
        alertControler.addTextField{ (textfield) in
            textfield.placeholder = "Title"
        }
        alertControler.addTextField{ (textfield) in
            textfield.placeholder = "Исполнитель"
        }
        alertControler.addAction(okAction)
        alertControler.addAction(cancel)
        
        present(alertControler, animated: true)
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        let task = items[indexPath.row]
        cell.configuration(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = EditViewController(task: items[indexPath.row])
        vc.taskUpdateDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let task = items[indexPath.row]
            items.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            taskManager.deleteTask(task: task)        }
    }
}

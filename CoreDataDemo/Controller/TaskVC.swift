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
    
    var saveTask:[SaveEntity] = []
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let conteiner = AppDelegate.container.viewContext
        let featchRequest: NSFetchRequest<SaveEntity> = SaveEntity.fetchRequest()
        
        do{
            saveTask = try conteiner.fetch(featchRequest)
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
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(0)
        }
    }
    
    @objc func addButtonTapped() {
        
        let ac = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {  [weak ac] _ in
            guard let textFields = ac?.textFields else {return}
     
            if let titleTF = textFields[0].text,
               let desriptionTF = textFields[1].text {
                self.saveTask(title: titleTF, description: desriptionTF)
            }
            self.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "cancel", style: .default)
        ac.addTextField{ (textfield) in
            textfield.placeholder = "Title"
        }
        ac.addTextField{ (textfield) in
            textfield.placeholder = "Description"
        }
        ac.addAction(ok)
        ac.addAction(cancel)

        present(ac, animated: true)
    }
    
    func saveTask(title: String, description: String) {
        let context = AppDelegate.container.viewContext
        let user = SaveEntity(context: context)
        user.title = title
        user.taskDescription = description
        
        do {
            try context.save()
            saveTask.append(user)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
}

extension TaskVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        tableView.separatorStyle = .none
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
    
        let task = saveTask[indexPath.row]
        let taskTitle = task.title ?? ""
        let taskDesk = task.taskDescription ?? ""

        cell.configuration(title: taskTitle, desc: taskDesk)
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            let task = saveTask[indexPath.row]
            saveTask.remove(at: indexPath.row)

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

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
    
    let coreDataManager = CoreDataManager()
    let tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataManager.checkTask()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    func configure(){
        navigationItem.title = "ToDo List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
                self.coreDataManager.saveTask(title: titleTF, description: desriptionTF)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
}

extension TaskVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.saveTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
    
        let task = coreDataManager.saveTask[indexPath.row]
        cell.configuration(task: task)
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete{
            let task = coreDataManager.saveTask[indexPath.row]
            coreDataManager.saveTask.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
            coreDataManager.deleteTask(task: task)
        }
    }
}

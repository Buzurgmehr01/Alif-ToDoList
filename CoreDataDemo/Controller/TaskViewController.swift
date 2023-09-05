//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 20/08/23.
//

import UIKit
import CoreData
import SnapKit

class TaskViewController: UIViewController {
    
    
    let coreDataManager = CoreDataManager()
    let tableView = UITableView()
    var items:[SaveEntity] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = coreDataManager.getTasks()
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        items = coreDataManager.getTasks()
        
        NotificationCenter.default.addObserver(forName: Notification.Name("Test"), object: nil, queue: nil) { [weak self] notific in
            print(notific)
            
            self?.items = self?.coreDataManager.getTasks() ?? []
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            //
        }
        //
        //        coreDataManager.checkTask()
        tableView.reloadData()
        
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
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(0)
        }
    }
    
    @objc func addButtonTapped() {
        
        let ac = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) {  [weak ac] _ in
            guard let textFields = ac?.textFields else {return}
            
            if let titleTF = textFields[0].text, !titleTF.isEmpty,
               let desriptionTF = textFields[1].text, !desriptionTF.isEmpty {
                
                self.coreDataManager.saveTask(title: titleTF, description: desriptionTF) { [weak self] tasks in
                    if let tasks = tasks {
                        self?.items = tasks
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    } else {
                        print("Error")
                        
                    }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "cancel", style: .default)
        ac.addTextField{ (textfield) in
            textfield.placeholder = "Title"
        }
        ac.addTextField{ (textfield) in
            textfield.placeholder = "Исполнитель"
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        
        present(ac, animated: true)
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
            coreDataManager.deleteTask(task: task)
        }
    }
}

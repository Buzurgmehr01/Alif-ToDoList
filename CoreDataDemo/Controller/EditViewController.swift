//
//  EditViewController.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 04/09/23.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    
    private let coreDataManager = CoreDataManager()
    let task: SaveEntity
    
    init(task: SaveEntity) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = InfoLabel().infoLabel(text: "Задача")
    private let executorLabel: UILabel = InfoLabel().infoLabel(text: "Исполнитель")
    
    private lazy var titleTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название задачи"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.text = task.title
        return textField
    }()

    private lazy var executorTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Испольнитель"
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.becomeFirstResponder()
        textField.text = task.taskDescription
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setUpNavBar()
    }
    
    func setUpNavBar(){
        
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        let leftButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(popVC))
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveChanges))
        leftButton.tintColor = UIColor.mainPrimary
        rightButton.tintColor = UIColor.mainPrimary
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }

    func configure(){
        
        view.backgroundColor = .mainViewColor
        view.addSubview(titleLabel)
        view.addSubview(executorLabel)
        view.addSubview(titleTF)
        view.addSubview(executorTF)
        
       
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(26)
        }
        
        titleTF.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(26)
        }

        executorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTF.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(26)
        }
        
        executorTF.snp.makeConstraints { make in
            make.top.equalTo(executorLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(26)
        }
        
    }
    
    @objc func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveChanges() {
        
        guard let newTitleName = titleTF.text, !newTitleName.isEmpty else{
            CoreDataAlert.showAlert(title: "Pfgjkybnt", message: "")
            return
        }
        
        let titleName = task.title ?? ""
        let executor = executorTF.text ?? ""
        
        coreDataManager.changeTask(title: titleName, exeutor: executor, newTitleName: newTitleName)
        popVC()
    }
    
}

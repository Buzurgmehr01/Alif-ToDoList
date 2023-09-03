//
//  TaskCell.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 31/08/23.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    let taskView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(){
        self.addSubview(taskView)
        taskView.addSubview(titleLabel)
        taskView.addSubview(descriptionLabel)

        taskView.backgroundColor = .mainViewColor
        taskView.layer.cornerRadius = 12
        taskView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.width.equalTo(200)
            $0.height.equalTo(100)

        }
        
        titleLabel.font = .Helvetica20
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
        }
        
        descriptionLabel.font = .Helvetica13
        descriptionLabel.numberOfLines = 2
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(15)
        }
    }
    
    func configuration(task: SaveEntity){
        titleLabel.text = task.title
        descriptionLabel.text = task.taskDescription
    }
}

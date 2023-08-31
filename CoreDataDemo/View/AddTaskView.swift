//
//  AddTaskView.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 31/08/23.
//

import UIKit

class AddTaskView: UIView {
    
    let mainLabel = UILabel()
    let titleLabel = UILabel()
    let desriptionLabel = UILabel()
    let statusLabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        
    }
}

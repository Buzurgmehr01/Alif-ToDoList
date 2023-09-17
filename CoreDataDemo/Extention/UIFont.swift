//
//  UIFont.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//

import UIKit

extension UIFont{
    
    static var Helvetica30: UIFont{
        return UIFont(name: "Helvetica", size: 30) ?? UIFont.systemFont(ofSize: 30)
    }
    
    static var Helvetica13: UIFont{
        return UIFont(name: "Helvetica", size: 13) ?? UIFont.systemFont(ofSize: 13)
    }
    
    static var Helvetica20: UIFont{
        return UIFont(name: "Helvetica", size: 20) ?? UIFont.systemFont(ofSize: 20)
    }
}

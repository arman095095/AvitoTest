//
//  UIViewController + Alert.swift
//  Avito
//
//  Created by Arman Davidoff on 30.12.2020.
//

import UIKit

extension UIViewController {
    
    func alert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

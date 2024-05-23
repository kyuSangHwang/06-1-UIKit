//
//  NextViewController.swift
//  NavigationController
//
//  Created by 황규상 on 5/23/24.
//

import UIKit

protocol NextViewControllerDelegate {
    func save(animal: Animal)
}

class NextViewController: UIViewController {
    var animal: Animal?
    
    var delegate: NextViewControllerDelegate? 

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "다음 화면"
        
        let label = UILabel()
        label.text = animal?.name ?? "-"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let button = UIButton(type: .custom)
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("전달", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] _ in
            if let delegate = self?.delegate {
//                delegate.save(animal: self?.animal ?? Animal(name: ""))
                delegate.save(animal: Animal(name: "ViewController에서 호랑이 전달 받았고 NextViewController에서 강아지 전달해줄께"))
                self?.navigationController?.popViewController(animated: true)
            }
        }, for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        ])
        
    }
}

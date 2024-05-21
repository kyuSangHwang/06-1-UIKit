//
//  ViewController.swift
//  StackView
//
//  Created by Jungman Bae on 5/20/24.
//

import UIKit

class ViewController: UIViewController {
    let slider = UISlider()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "값: 0.5"
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.isContinuous = true
        slider.addAction(UIAction {[weak self] _ in
            self?.label.text = "값: \(String(format:"%.1f", self?.slider.value ?? 0))"
        }, for: .valueChanged)
        
        
        let stackView = UIStackView(arrangedSubviews: [label, slider])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}


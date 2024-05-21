//
//  ViewController.swift
//  Picker
//
//  Created by Jungman Bae on 5/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    // iOS에 자원이 부족하면 호출되는 함수
    override func didReceiveMemoryWarning() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Color Picker"
        config.cornerStyle = .capsule
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(UIAction { [unowned self] _ in
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            colorPicker.supportsAlpha = false
            colorPicker.selectedColor = self.view.backgroundColor ?? .white
            self.present(colorPicker, animated: true)
        }, for: .touchUpInside)
        
        self.view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        view.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
}

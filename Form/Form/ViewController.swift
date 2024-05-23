//
//  ViewController.swift
//  Form
//
//  Created by 황규상 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {
    let formOneLabel = UILabel()
    let formOneTextField = UITextField()
    let formTwoLabel = UILabel()
    let formTwoTextField = UITextField()
    let resultLabelOne = UILabel()
    let resultLabelTwo = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupFormOne()
        setupFormTwo()
        setupResults()
        
//        formOneTextField.addAction(UIAction {[weak self] _ in
//            self?.resultLabelOne.text = "Form #1 = \(self?.formOneTextField.text ?? "")"
//        }, for: .editingChanged)
//        
//        formTwoTextField.addAction(UIAction {[weak self] _ in
//            self?.resultLabelOne.text = "Form #1 = \(self?.formTwoTextField.text ?? "")"
//        }, for: .editingChanged)

//        formOneTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        formTwoTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        formOneTextField.addAction(UIAction(handler: textFieldDidChange), for: .editingChanged)
        formTwoTextField.addAction(UIAction(handler: textFieldDidChange), for: .editingChanged)
    }
    
    func setupFormOne() {
        formOneLabel.text = "이것은 첫 번째 폼입니다."
        formOneLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formOneLabel)
        
        formOneTextField.borderStyle = .roundedRect
        formOneTextField.placeholder = "여기에 입력하세요."
        formOneTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formOneTextField)
        
        NSLayoutConstraint.activate([
            formOneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            formOneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formOneTextField.topAnchor.constraint(equalTo: formOneLabel.bottomAnchor, constant: 10),
            formOneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formOneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupFormTwo() {
        formTwoLabel.text = "이것은 두 번째 폼입니다."
        formTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formTwoLabel)
        
        formTwoTextField.borderStyle = .roundedRect
        formTwoTextField.placeholder = "여기에 입력하세요."
        formTwoTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formTwoTextField)
        
        NSLayoutConstraint.activate([
            formTwoLabel.topAnchor.constraint(equalTo: formOneTextField.bottomAnchor, constant: 20),
            formTwoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formTwoTextField.topAnchor.constraint(equalTo: formTwoLabel.bottomAnchor, constant: 10),
            formTwoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formTwoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupResults() {
        resultLabelOne.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabelOne)
        
        resultLabelTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabelTwo)
        
        NSLayoutConstraint.activate([
            resultLabelOne.topAnchor.constraint(equalTo: formTwoTextField.bottomAnchor, constant: 20),
            resultLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabelTwo.topAnchor.constraint(equalTo: resultLabelOne.bottomAnchor, constant: 10),
            resultLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        if textField == formOneTextField {
//            resultLabelOne.text = " #1=\(textField.text ?? "")"
//        } else if textField == formTwoTextField {
//            resultLabelTwo.text=" #2=\(textField.text ?? "")"
//        }
//    }
    
    func textFieldDidChange(_ action: UIAction) {
        guard let textField = action.sender as? UITextField else { return }
        
        if textField == formOneTextField {
            resultLabelOne.text = "폼 #1 = \(textField.text ?? "")"
        } else {
            resultLabelTwo.text = "폼 #2 = \(textField.text ?? "")"
        }
    }
    
}


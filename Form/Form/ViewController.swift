//
//  ViewController.swift
//  Form
//
//  Created by 황규상 on 5/23/24.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource {
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let formOneLabel = UILabel()
    let formOneTextField = UITextField()
    let formOneSwitch = UISwitch()
    let formTwoLabel = UILabel()
    let formTwoTextField = UITextField()
    let resultLabelOne = UILabel()
    let resultLabelTwo = UILabel()
    let resultButton = UIButton(type: .system)
    lazy var textFieldAction = UIAction(handler: textFieldDidChange)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        switch section {
        case 0:
            return 3
        case 1:
            return formOneSwitch.isOn ? 2 : 0
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "결과"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "폼 #1"
        case 1:
            return formOneSwitch.isOn ? "폼 #2" : nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.contentView.subviews.forEach({ view in view.removeFromSuperview() })
        
        switch indexPath.section {
        case 0:
            setupFormOne(view: cell.contentView, indexPath: indexPath)
        case 1:
            setupFormTwo(view: cell.contentView, indexPath: indexPath)
        case 2:
            setupResults(view: cell.contentView, indexPath: indexPath)
        default:
            break
        }
        return cell
    }
    
    
    // 액션 개체 생성 / 삭제 코드 추가
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        formOneTextField.addAction(textFieldAction, for: .editingChanged)
        formTwoTextField.addAction(textFieldAction, for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        formOneTextField.removeAction(textFieldAction, for: .editingChanged)
        formTwoTextField.removeAction(textFieldAction, for: .editingChanged)
    }
    
    func setupFormOne(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 0 { return }
        switch indexPath.row {
        case 0:
            formOneLabel.text = "이것은 첫 번째 폼입니다"
            formOneLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formOneLabel)
            NSLayoutConstraint.activate([
                formOneLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formOneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
        case 1:
            formOneTextField.borderStyle = .roundedRect
            formOneTextField.placeholder = "여기에 입력하세요"
            formOneTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formOneTextField)
            NSLayoutConstraint.activate([
                formOneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formOneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                formOneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        case 2:
            formOneSwitch.translatesAutoresizingMaskIntoConstraints = false
            
            formOneSwitch.addAction(UIAction { [weak self] _ in self?.tableView.reloadData() }, for: .valueChanged)
            
            view.addSubview(formOneSwitch)
            NSLayoutConstraint.activate([
                formOneSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                formOneSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        default:
            break
        }
    }
    
    func setupFormTwo(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 1 { return }
        switch indexPath.row {
        case 0:
            formTwoLabel.text = "이것은 두 번째 폼입니다"
            formTwoLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formTwoLabel)
            NSLayoutConstraint.activate([
                formTwoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formTwoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
        case 1:
            formTwoTextField.borderStyle = .roundedRect
            formTwoTextField.placeholder = "여기에 입력하세요"
            formTwoTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formTwoTextField)
            NSLayoutConstraint.activate([
                formTwoTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formTwoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                formTwoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        default:
            break
        }
    }
    
    func setupResults(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 2 { return }
        switch indexPath.row {
        case 0:
            resultLabelOne.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultLabelOne)
            NSLayoutConstraint.activate([
                resultLabelOne.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                resultLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            ])
            
        case 1:
            resultLabelTwo.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultLabelTwo)
            NSLayoutConstraint.activate([
                resultLabelTwo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                resultLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            ])
        case 2:
            resultButton.translatesAutoresizingMaskIntoConstraints = false
            
            resultButton.setTitle("클릭하세요.", for: .normal)
            resultButton.isEnabled = formOneSwitch.isOn
            view.addSubview(resultButton)
            
            NSLayoutConstraint.activate([
                resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                resultButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
        default:
            break
        }
    }

    func textFieldDidChange(_ action: UIAction) {
        guard let textField = action.sender as? UITextField else { return }
        
        if textField == formOneTextField {
            resultLabelOne.text = "폼 #1 = \(textField.text ?? "")"
        } else {
            resultLabelTwo.text = "폼 #2 = \(textField.text ?? "")"
        }
    }
    
}

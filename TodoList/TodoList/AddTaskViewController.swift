//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Jungman Bae on 5/24/24.
//

import UIKit

let TODAY_BUTTON_TAG = 1001
let TOMORROW_BUTTON_TAG = 1002
let NODUE_BUTTON_TAG = 1003
let DATEPICKER_TAG = 1004

enum DueDateType {
    case today
    case tomorrow
    case none
    case someday(date: Date)
    
    func getDate() -> Date? {
        switch self {
        case .today:
            return Date()
        case .tomorrow:
            return Calendar.current.date(byAdding: .day, value: 1, to: Date())
        case .none:
            return nil
        case .someday(let date):
            return date
        }
    }
    
    func isSelected(tag: Int) -> Bool {
        switch self {
        case .today:
            return tag == TODAY_BUTTON_TAG
        case .tomorrow:
            return tag == TOMORROW_BUTTON_TAG
        case .none:
            return tag == NODUE_BUTTON_TAG
        case .someday(_):
            return tag == DATEPICKER_TAG
        }
    }
}

class AddTaskViewController: UIViewController {
    var dueDate: DueDateType = .none {
        didSet {
            updateDueButtons()
        }
    }
    
    var completionHandler: (() -> Void)?
        
    private var taskTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        textField.placeholder = "할 일을 입력하세요."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dueDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.tag = DATEPICKER_TAG
        datePicker.addAction(UIAction { [weak self] action in
            if let picker = action.sender as? UIDatePicker{
                print("date: \(picker.date.ISO8601Format())")
                self?.dueDate = .someday(date: picker.date)
                self?.dismiss(animated: false)
            }
        }, for: .valueChanged)
        
        return datePicker
    }()
    
    private lazy var dueDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIButton.Configuration.bordered()
        
        let todayButton = UIButton(type: .custom)
        todayButton.setTitle("오늘", for: .normal)
        todayButton.tag = TODAY_BUTTON_TAG
        todayButton.configuration = config
        todayButton.addAction(UIAction { [weak self] _ in self?.dueDate = .today },
                              for: .touchUpInside)
        
        let tomorrowButton = UIButton(type: .custom)
        tomorrowButton.setTitle("내일", for: .normal)
        tomorrowButton.tag = TOMORROW_BUTTON_TAG
        tomorrowButton.configuration = config
        tomorrowButton.addAction(UIAction { [weak self] _ in self?.dueDate = .tomorrow },
                              for: .touchUpInside)

        let noDueButton = UIButton(type: .custom)
        noDueButton.setTitle("미지정", for: .normal)
        noDueButton.tag = NODUE_BUTTON_TAG
        noDueButton.configuration = config
        noDueButton.addAction(UIAction { [weak self] _ in self?.dueDate = .none },
                              for: .touchUpInside)

        stackView.addArrangedSubview(todayButton)
        stackView.addArrangedSubview(tomorrowButton)
        stackView.addArrangedSubview(noDueButton)
        stackView.addArrangedSubview(dueDatePicker)
        
        return stackView
    }()
    
    private var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 22, weight: .bold)
            return outgoing
        }

        button.configuration = config
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Add Task"
        
        submitButton.addAction(UIAction { [weak self] _ in
            self?.saveTodo()
        }, for: .touchUpInside)
        
        view.addSubview(taskTextField)
        view.addSubview(dueDateStackView)
        view.addSubview(submitButton)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(cancleAddTask))
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            taskTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            taskTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            taskTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            
            dueDateStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            dueDateStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            dueDateStackView.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            
            submitButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            submitButton.topAnchor.constraint(equalTo: dueDateStackView.bottomAnchor, constant: 20)
            
        ])
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        updateDueButtons()
    }
    
    // MARK: - Methods
    private func updateDueButtons() {
        dueDateStackView.subviews.forEach { element in
            if let button = element as? UIButton {
                button.isSelected = dueDate.isSelected(tag: element.tag)
            } else {
                print("데이트 피커")
            }
        }
    }
    
    private func saveTodo() {
        if let taskText = self.taskTextField.text, !taskText.isEmpty {
            TodoStore.shared.addTodo(todo: Todo(id: UUID(),
                                                task: taskText,
                                                date: dueDate.getDate(),
                                                isDone: false))
            print(TodoStore.shared.getList())
            dismiss(animated: true, completion: completionHandler)
        } else {
            let alert = UIAlertController(title: "할 일을 입력하세요", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
        }
    }
 
    @objc func cancleAddTask(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

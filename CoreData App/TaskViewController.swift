//
//  TaskViewController.swift
//  CoreData App
//
//  Created by Илья Нечаев on 20.03.2022.
//

import UIKit
import CoreData

class TaskViewController: UIViewController {
    public var delegate: TaskViewControllerDelegate?

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    private lazy var newTaskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private lazy var saveButton = CustomButton(
        color: UIColor(
        red: 21/255,
        green: 101/255,
        blue: 192/255,
        alpha: 194/255),
        titleString: "Save Task",
        action: #selector(save),
        target: self
    )
    
    private lazy var cancelButton = CustomButton(
        color: .systemRed,
        titleString: "Cancel",
        action: #selector(cancel),
        target: self
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(newTaskTextField, saveButton, cancelButton)
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newTaskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            newTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            newTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    @objc private func save() {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        guard let task = NSManagedObject(entity: entityDescription, insertInto: context) as? Task else { return }
        if newTaskTextField.text != "" {
            task.title = newTaskTextField.text
            delegate?.reloadData()
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

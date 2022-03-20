//
//  CustomButton.swift
//  CoreData App
//
//  Created by Илья Нечаев on 20.03.2022.
//

import UIKit

class CustomButton: UIButton {
    var color: UIColor
    var titleString: String
    var action: Selector
    var target: AnyObject
    
    init(color: UIColor, titleString: String, action: Selector, target: AnyObject) {
        self.color = color
        self.titleString = titleString
        self.action = action
        self.target = target
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.backgroundColor = color
        self.setTitle(titleString, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 5
        self.addTarget(target, action: action, for: .touchUpInside)
    }
}

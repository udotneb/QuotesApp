//
//  TestView.swift
//  Affirm
//
//  Created by Benjamin Ulrich on 10/11/19.
//  Copyright © 2019 Benjamin Ulrich. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {
    private var quoteMessage: UILabel?
    private var quoteAuthor: UILabel?
    
    var quote: Quote? {
        didSet {
            quoteMessage?.text = quote?.message
            quoteAuthor?.text = quote?.author
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        quoteMessage = UILabel()
        quoteAuthor = UILabel()
        
        guard let messageUnwrapped = quoteMessage else {
            print("error in label")
            return
        }
        messageUnwrapped.textAlignment = .left
        messageUnwrapped.text = "I'm a test label"
        messageUnwrapped.numberOfLines = 0
        
        guard let authorUnwrapped = quoteAuthor else {
            print("error in label")
            return
        }
        authorUnwrapped.textAlignment = .left
        authorUnwrapped.text = "I'm a test label"
        authorUnwrapped.numberOfLines = 0
        
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("New", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [messageUnwrapped, authorUnwrapped, button])
        stack.axis  = NSLayoutConstraint.Axis.vertical
        addSubview(stack)
        stack.bindStackToSuperviewBounds()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init coder")
    }
    
    @objc func buttonAction(sender: UIButton!) {
        NotificationCenter.default.post(name: NSNotification.Name("buttonPressed"), object: nil)
    }
}


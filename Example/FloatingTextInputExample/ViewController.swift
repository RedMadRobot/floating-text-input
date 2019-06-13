//
//  ViewController.swift
//  FloatingTextInputExample
//
//  Created by Alexander Ignatev on 13/06/2019.
//  Copyright © 2019 Redmadrobot. All rights reserved.
//

import UIKit
import FloatingTextInput

class ViewController: UIViewController {

    @IBOutlet var titleTextField: TextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.title = "Title"
    }


}


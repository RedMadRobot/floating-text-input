//
//  TextFieldTests.swift
//  FloatingTextInputTests
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import FloatingTextInput
import XCTest

final class TextFieldTests: XCTestCase {

    private var textField: TextField!

    override func setUp() {
        textField = TextField()
    }

    func testEditingDidBegin() {
        textField.sendActions(for: .editingDidBegin)
    }

    func testEditingChanged() {
        //
    }

    func testEditingDidEnd() {
        //
    }
}

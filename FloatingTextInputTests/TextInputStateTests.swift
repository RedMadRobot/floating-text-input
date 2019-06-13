//
//  TextInputStateTests.swift
//  FloatingTextInputTests
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import FloatingTextInput
import XCTest

final class TextInputStateTests: XCTestCase {

    func testEmpty() {
        XCTAssertEqual(TextInputState(hasText: false, firstResponder: false), .empty)
    }

    func testText() {
        XCTAssertEqual(TextInputState(hasText: true, firstResponder: false), .text)
    }

    func testPlaceholder() {
        XCTAssertEqual(TextInputState(hasText: false, firstResponder: true), .placeholder)
    }

    func testTextInput() {
        XCTAssertEqual(TextInputState(hasText: true, firstResponder: true), .textInput)
    }
}

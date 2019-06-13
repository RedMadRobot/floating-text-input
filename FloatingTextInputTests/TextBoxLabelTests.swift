//
//  TextBoxLabelTests.swift
//  FloatingTextInputTests
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

@testable import FloatingTextInput
import XCTest

final class TextBoxLabelTests: XCTestCase {

    func testInitWithFontSize() {
        let label = TextBoxLabel(fontSize: UIFont.buttonFontSize)
        XCTAssertEqual(label.font, UIFont.systemFont(ofSize: UIFont.buttonFontSize))
    }

    func testIntrinsicContentSize() {
        let label = TextBoxLabel()
        XCTAssertEqual(label.intrinsicContentSize, CGSize(width: 0, height: label.font.lineHeight))
    }
}

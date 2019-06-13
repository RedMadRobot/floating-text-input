//
//  TextBoxLabel.swift
//  FloatingTextInput
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import UIKit

internal final class TextBoxLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        adjustsFontForContentSizeCategory = true
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        // Даже без текста сохраняет высоту.
        return CGSize(width: size.width, height: font.lineHeight)
    }
}

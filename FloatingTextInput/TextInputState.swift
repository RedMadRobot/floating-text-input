//
//  TextInputState.swift
//  FloatingTextInput
//
//  Created by Alexander Ignatev on 19/11/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import Foundation

/// Состояние текстового поля.
///
/// - empty: Нет текста.
/// - text: Содержит текст.
/// - placeholder: Поле в фокусе, но еще нет текста.
/// - textInput: Ввод текста.
public enum TextInputState {
    case empty
    case text
    case placeholder
    case textInput

    public init(hasText: Bool, firstResponder: Bool) {
        switch (hasText, firstResponder) {
        case (false, false):
            self = .empty
        case (true, false):
            self = .text
        case (false, true):
            self = .placeholder
        case (true, true):
            self = .textInput
        }
    }
}

//
//  TextView.swift
//  FloatingTextInput
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import UIKit

open class TextView: UITextView {

    /// Контейнер с дополнительными лейблами.
    private let textBox = TextBox()

    var notificationCenter: NotificationCenter { return .default }

    // MARK: - Init

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    /// Первичная настройка после `init`.
    open func commonInit() {
        textContainer.lineFragmentPadding = 0
        addSubview(textBox)
        observerNotifications()
        updateState(animated: false)
        textBox.isHidden = true
    }

    // MARK: - UITextView

    open override var text: String! {
        didSet { updateState(animated: false) }
    }

    // MARK: - Private

    /// Начать наблюдение за уведомлениями.
    private func observerNotifications() {
        observe(UITextView.textDidBeginEditingNotification, #selector(textDidEditing))
        observe(UITextView.textDidChangeNotification, #selector(textDidEditing))
        observe(UITextView.textDidEndEditingNotification, #selector(textDidEditing))
    }

    private func observe(_ name: NSNotification.Name, _ selector: Selector) {
        notificationCenter.addObserver(self, selector: selector, name: name, object: self)
    }

    @objc private func textDidEditing() {
        updateState(animated: true)
    }

    private func updateState(animated: Bool) {
        let state = TextInputState(hasText: hasText, firstResponder: isFirstResponder)
        textBox.setState(state, animated: animated)
    }
}

//
//  TextBox.swift
//  FloatingTextInput
//
//  Created by Alexander Ignatev on 23/10/2018.
//  Copyright © 2018 Redmadrobot OOO. All rights reserved.
//

import UIKit

internal final class TextBox: UIView {

    private(set) var state = TextInputState.placeholder

    var title: String? {
        didSet {
            titleLabel.text = title
            titlePlaceholderLabel.text = title
        }
    }

    var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
            titlePlaceholderLabel.textColor = titleColor
        }
    }

    var placeholderFont: UIFont? {
        didSet {
            titlePlaceholderLabel.font = placeholderFont
            placeholderLabel.font = placeholderFont
        }
    }
    
    var separatorHeight: CGFloat = 1 {
        didSet {
            separatorHeightConstraint?.constant = separatorHeight
        }
    }

    let titleLabel: UILabel = TextBoxLabel(fontSize: UIFont.smallSystemFontSize)
    let titlePlaceholderLabel: UILabel = TextBoxLabel()
    let placeholderLabel: UILabel = TextBoxLabel()
    let detailTextLabel: UILabel = TextBoxLabel(fontSize: UIFont.smallSystemFontSize)
    let separatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()

    private let titleBottomSpace: CGFloat = 2
    private let separatorTopSpace: CGFloat = 6
    private let detailTextTopSpace: CGFloat = 2
    
    private var separatorHeightConstraint: NSLayoutConstraint?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Internal

    /// Отсутпы до фрейма, в котором можно редактировать текст.
    var editingTextInsets: UIEdgeInsets {
        let bottom = detailTextLabel.font.lineHeight + separatorView.frame.height
            + detailTextTopSpace + separatorTopSpace

        return UIEdgeInsets(
            top: titleLabel.font.lineHeight + titleBottomSpace,
            left: layoutMargins.left,
            bottom: bottom,
            right: layoutMargins.right)
    }

    func setState(_ newState: TextInputState, animated: Bool) {
        guard newState != self.state else {
            return
        }
        let oldSate = state
        state = newState
        let isAnimated = animated && window != nil && frame != .zero

        switch (oldSate, newState, isAnimated) {
        case (_, .empty, true):
            moveTitleDown()
        case (.empty, .placeholder, true):
            moveTitleUp()
        default:
            stateDidUpdate()
        }
    }

    // MARK: - Private

    private func commonInit() {
        isUserInteractionEnabled = false
        let subviews = [
            titleLabel,
            titlePlaceholderLabel,
            placeholderLabel,
            detailTextLabel,
            separatorView
        ]
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
            subview.isUserInteractionEnabled = false
            addSubview(subview)
        }
        setupConstraints()
       // debug()
    }

    private func setupConstraints() {
        layoutMargins = .zero
        
        let separatorHeight = separatorView.heightAnchor.constraint(equalToConstant: self.separatorHeight)
        separatorHeightConstraint = separatorHeight
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),

            titlePlaceholderLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: titleBottomSpace),
            titlePlaceholderLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titlePlaceholderLabel.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),

            placeholderLabel.topAnchor.constraint(equalTo: titlePlaceholderLabel.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            separatorView.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 0),
            separatorHeight,
            separatorView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            detailTextLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: detailTextTopSpace),
            detailTextLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            detailTextLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }

    private func debug() {
        title = "Title"
        placeholderLabel.text = "Placeholder"
        detailTextLabel.text = "Detail text"

        titleLabel.backgroundColor = UIColor.red
        placeholderLabel.backgroundColor = UIColor.yellow
        detailTextLabel.backgroundColor = UIColor.green
        separatorView.backgroundColor = UIColor.purple
        
        titleLabel.accessibilityLabel = "titleLabel"
        titlePlaceholderLabel.accessibilityLabel = "titlePlaceholderLabel"
        placeholderLabel.accessibilityLabel = "placeholderLabel"
        separatorView.accessibilityLabel = "separatorView"
        detailTextLabel.accessibilityLabel = "detailTextLabel"
    }

    private func stateDidUpdate() {
        updateTitle()
        updatePlaceholder()
    }

    private func updateTitle() {
        switch state {
        case .empty:
            titleLabel.isHidden = true
            titlePlaceholderLabel.isHidden = false
        case .text, .placeholder, .textInput:
            titleLabel.isHidden = false
            titlePlaceholderLabel.isHidden = true
        }
    }

    private func updatePlaceholder() {
        placeholderLabel.alpha = (state == .placeholder) ? 1 : 0
    }

    private func moveTitleDown() {
        titlePlaceholderLabel.transform = transform(
            from: titleLabel.frame,
            to: titlePlaceholderLabel.frame
        )
        animateTitles()
    }

    private func moveTitleUp() {
        titleLabel.transform = transform(
            from: titlePlaceholderLabel.frame,
            to: titleLabel.frame
        )
        animateTitles()
    }

    private func animateTitles() {
        updateTitle()
        UIView.animate(withDuration: 0.25) {
            self.titleLabel.transform = .identity
            self.titlePlaceholderLabel.transform = .identity
            self.updatePlaceholder()
        }
    }

    private func transform(from source: CGRect, to destination: CGRect) -> CGAffineTransform {
        let scaleX = source.width / destination.width
        let scaleY = source.height / destination.height

        let translationX = source.origin.x - destination.origin.x - (destination.width * (1.0 - scaleX) / 2)
        let translationY = source.origin.y - destination.origin.y - (destination.height * (1.0 - scaleY) / 2)

        return CGAffineTransform(translationX: translationX, y: translationY).scaledBy(x: scaleX, y: scaleY)
    }
}

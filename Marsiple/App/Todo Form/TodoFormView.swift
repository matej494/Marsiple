//
//  TodoFormView.swift
//  Marsiple
//
//  Created by Matej Korman on 31/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoFormView: UIView {
    var title: String {
        get { return textView.text == placeholder ? "" : textView.text }
        set { isPlaceholderActive(newValue.isEmpty, text: newValue) }
    }
    
    private let textView = UITextView.autolayoutView()
    private let keyboardSizedView = UIView.autolayoutView()
    private let placeholder = LocalizationKey.TodoForm.titlePlaceholder.localized()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupObservers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TodoFormView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        isPlaceholderActive(false, text: textView.text == placeholder ? nil : textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        isPlaceholderActive(textView.text.isEmpty, text: textView.text)
    }
}

private extension TodoFormView {
    func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        let keyboardHeight = endFrame.size.height
        keyboardSizedView.snp.updateConstraints { $0.height.equalTo(keyboardHeight) }
        layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardSizedView.snp.updateConstraints { $0.height.equalTo(0) }
        layoutIfNeeded()
    }
}

private extension TodoFormView {
    func setupViews() {
        setupTextView()
        setupKeyboardSizedView()
    }
    
    func setupTextView() {
        isPlaceholderActive(true)
        textView.font = .systemFont(ofSize: 20)
        textView.delegate = self
        addSubview(textView)
        textView.snp.makeConstraints { $0.leading.top.trailing.equalToSuperview() }
    }
    
    func setupKeyboardSizedView() {
        addSubview(keyboardSizedView)
        keyboardSizedView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(textView.snp.bottom)
            $0.height.equalTo(0)
        }
    }
    
    func isPlaceholderActive(_ isActive: Bool, text: String? = nil) {
        if isActive {
            textView.text = placeholder
            textView.textColor = .lightGray
        } else {
            textView.text = text
            textView.textColor = .black
        }
    }
}

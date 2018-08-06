//
//  TodoFormView.swift
//  Marsiple
//
//  Created by Matej Korman on 31/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class TodoFormView: UIView {
    var placeholder = LocalizationKey.TodoForm.titlePlaceholder.localized() {
        didSet {
            if placeholder.isEmpty {
                textView.text = LocalizationKey.TodoForm.titlePlaceholder.localized()
                textView.textColor = .lightGray
            } else {
                textView.textColor = .black
                textView.text = placeholder
            }
        }
    }
    
    var text: String { return textView.text }
    private let textView = UITextView.autolayoutView()
    private let keyboardSizedView = UIView.autolayoutView()
    
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
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            placeholder = ""
        }
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
        placeholder = ""
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
}

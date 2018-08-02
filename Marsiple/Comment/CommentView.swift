//
//  CommentView.swift
//  Marsiple
//
//  Created by Matej Korman on 23/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import SnapKit

class CommentView: UIView {
    public var text: String {
        return textView.text
    }
    
    private let maxCharacterCount = 200
    private let textView = UITextView.autolayoutView()
    private let keyboardSizedView = UIView.autolayoutView()
    private let characterCountLabel = UILabel.autolayoutView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChangeFrame),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private extension CommentView {
    @objc func keyboardWillChangeFrame(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        let keyboardHeight = endFrame.size.height
        let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
        keyboardSizedView.snp.updateConstraints {
            $0.height.equalTo(keyboardHeight)
        }
        UIView.animate(withDuration: duration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { self.layoutIfNeeded() },
                       completion: nil)        
    }
}

extension CommentView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let count = textView.text.count + text.count - range.length
        if count <= maxCharacterCount { characterCountLabel.text = "\(count) / \(maxCharacterCount)" }
        return count <= maxCharacterCount
    }
}

private extension CommentView {
    func setupViews() {
        backgroundColor = .martianLightGrey
        setupTextView()
        setupCharacterCountLabel()
        setupKeyboardSizedView()
    }
    
    func setupTextView() {
        textView.delegate = self
        addSubview(textView)
        textView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    func setupCharacterCountLabel() {
        characterCountLabel.text = "0 / \(maxCharacterCount)"
        characterCountLabel.textAlignment = .right
        characterCountLabel.textColor = .black
        characterCountLabel.backgroundColor = .martianLightGrey
        addSubview(characterCountLabel)
        characterCountLabel.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setupKeyboardSizedView() {
        keyboardSizedView.backgroundColor = .white
        addSubview(keyboardSizedView)
        keyboardSizedView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(characterCountLabel.snp.bottom)
            $0.height.equalTo(0)
        }
    }
}

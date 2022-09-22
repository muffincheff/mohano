//
//  UnderlineTextField.swift
//  mohasem
//
//  Created by orca on 2022/09/11.
//

import UIKit
import SnapKit

class UnderlineTextField: UIView {

    var field = UITextField()
    var text: String {
        get { field.text ?? "" }
        set { field.text = newValue }
    }
    
    var placeholder: String {
        get { field.placeholder ?? "" }
        set { field.placeholder = newValue }
    }
    
    var font: UIFont? {
        get { field.font }
        set { field.font = newValue }
    }
    
    var borderStyle: UITextField.BorderStyle {
        get { field.borderStyle }
        set { field.borderStyle = newValue }
    }
    
    init(frame: CGRect = CGRect.zero, lineColor: UIColor = UIColor.systemGray3, inset: UIEdgeInsets = UIEdgeInsets.zero, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        
        super.init(frame: frame)
        
        self.addSubview(field)
        field.borderStyle = .none
        field.font = font
        field.autocorrectionType = .no
        field.smartDashesType = .no
        field.smartQuotesType = .no
        field.smartInsertDeleteType = .no
        field.spellCheckingType = .no
        field.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(inset.left)
            make.top.equalToSuperview().offset(inset.top)
            make.trailing.equalToSuperview().inset(inset.right)
            make.bottom.equalToSuperview().inset(inset.bottom)
        }
        
        let underline = UIView()
        self.addSubview(underline)
        underline.backgroundColor = lineColor
        underline.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(inset.left)
            make.top.equalTo(field.snp.bottom).offset(-4)
            make.trailing.equalToSuperview().inset(inset.right)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

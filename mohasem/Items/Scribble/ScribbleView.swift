//
//  CategoryView.swift
//  mohasem
//
//  Created by orca on 2022/09/07.
//

import UIKit

class ScribbleView: UIView {
    
    var name = UILabel()
    var content = UITextView()
    var img: UIImageView!
    
    init(frame: CGRect = CGRect.zero, scribble: Scribble) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        
        // img
        if false == scribble.img.isEmpty {
            img = UIImageView()
            self.addSubview(img)
            img.layer.masksToBounds = true
            img.loadImage(url: URL(string: scribble.img))
            img.contentMode = .scaleAspectFill
            img.snp.makeConstraints { make in
                make.leading.top.trailing.equalToSuperview()
                make.height.equalTo(70)
            }
        }
        
        // name
        self.addSubview(name)
        name.text = scribble.name
        name.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        name.numberOfLines = 2
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
            if img == nil { make.top.equalToSuperview().offset(8)}
            else { make.top.equalTo(img.snp.bottom).offset(8) }
            make.height.equalTo(18)
        }
        
        // line
        let line = UIView()
        self.addSubview(line)
        line.backgroundColor = .systemGray5
        line.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
            make.top.equalTo(name.snp.bottom).offset(4)
            make.height.equalTo(1)
        }
        
        // content
        self.addSubview(content)
        content.font = UIFont.systemFont(ofSize: 12)
        content.textColor = .systemGray
        content.textAlignment = .left
        content.isScrollEnabled = false
        content.backgroundColor = .clear
        content.text = scribble.content
        content.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
            make.top.equalTo(line.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

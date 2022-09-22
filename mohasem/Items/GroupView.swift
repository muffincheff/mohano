//
//  GroupView.swift
//  mohasem
//
//  Created by orca on 2022/09/07.
//

import UIKit

class GroupView: UIView {

    init(frame: CGRect = CGRect.zero, item: UIView, itemCount: Int, leadingTrailing: CGFloat = 0) {
        super.init(frame: frame)
        
        var itemCount = itemCount
        if itemCount < 1 { itemCount = 1 }
        let offset: CGFloat = 6
        let itemBottomOffset: CGFloat = offset * (CGFloat(itemCount) - 1)
        var views: [UIView] = []
        DispatchQueue.main.async {
            for i in 0 ..< itemCount {
                if i == 0 {
                    self.addSubview(item)
                    item.snp.makeConstraints { make in
                        make.leading.equalToSuperview().offset(leadingTrailing)
                        make.trailing.equalToSuperview().inset(leadingTrailing)
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview().inset(itemBottomOffset)
                    }
                    views.append(item)
                } else {
                    let temp = UIView()
                    self.addSubview(temp)
                    temp.backgroundColor = item.backgroundColor?.withAlphaComponent(1 - (CGFloat(i) * 0.3))
                    temp.layer.cornerRadius = item.layer.cornerRadius
                    temp.layer.borderColor = item.layer.borderColor
                    temp.layer.borderWidth = item.layer.borderWidth
                    let sumLeadingTrailing = CGFloat(i) * offset
                    temp.snp.makeConstraints { make in
                        make.leading.top.equalToSuperview().offset(leadingTrailing + sumLeadingTrailing)
                        make.trailing.top.equalToSuperview().inset(leadingTrailing + sumLeadingTrailing)
                        make.bottom.equalToSuperview().inset(itemBottomOffset - sumLeadingTrailing)
                    }
                    views.append(temp)
                }
                
            }
            
            views.forEach({ self.sendSubviewToBack($0) })
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

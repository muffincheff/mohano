//
//  CategoryBoard.swift
//  mohasem
//
//  Created by orca on 2022/09/07.
//

import UIKit

class ScribbleBoard: UIView {
    
    var title = UILabel()
    var scrollview = UIScrollView()
    var stackview = UIStackView()
    
    init(frame: CGRect = CGRect.zero, scribbles: [Scribble]) {
        super.init(frame: frame)
        
        // title
        self.addSubview(title)
        title.text = "낙서:"
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // scroll view
        self.addSubview(scrollview)
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        var scrollviewContentInset = scrollview.contentInset
        scrollviewContentInset.left += 20
        scrollviewContentInset.right += 20
        scrollview.contentInset = scrollviewContentInset
        scrollview.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(10)
        }

        // stack view
        scrollview.addSubview(stackview)
        stackview.spacing = 12
        stackview.axis = .horizontal
        stackview.snp.makeConstraints { make in
            make.edges.equalTo(scrollview.contentLayoutGuide)
            make.height.equalTo(scrollview.frameLayoutGuide)
        }
        
        for scribble in scribbles {
            let scribbleView = ScribbleView(scribble: scribble)
            stackview.addArrangedSubview(scribbleView)
            scribbleView.snp.makeConstraints { make in
                make.width.equalTo(150)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

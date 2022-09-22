//
//  PostBoard.swift
//  mohasem
//
//  Created by orca on 2022/09/07.
//

import UIKit

class PostBoard: UIView {
    
    var title = UILabel()

    init(frame: CGRect = CGRect.zero, posts: [PostView]) {
        super.init(frame: frame)
        setBoard(posts: posts)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBoard(posts: [PostView]) {
            
        // create empty post
        var posts = posts
        if posts.isEmpty {
            let post = Post(id: "no-schedule", start: Date(), name: "등록된 스케쥴이 없습니다.", alert: false, memo: "지금 새 스케쥴을 등록해보세요!", img: "https://cdn.dribbble.com/users/1787323/screenshots/14593609/media/f821646219ea968da9b16a7dae6f37a1.png?compress=1&resize=400x300")
            let postview = PostView(post: post)
            posts.append(postview)
        }
        
        // next schedule
        if title.isDescendant(of: self) == false {
            self.addSubview(title)
            title.text = "다음 스케쥴:"
            title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            title.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().inset(20)
                make.top.equalToSuperview()
                make.height.equalTo(30)
            }
        }
        
        
        // group view
        let groupTag: Int = 10
        self.viewWithTag(groupTag)?.removeFromSuperview()
        
        let postgroup = GroupView(item: posts[0], itemCount: 3/*posts.count*/)
        postgroup.tag = groupTag
        self.addSubview(postgroup)
        postgroup.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(title.snp.bottom).offset(10)
//            make.height.equalTo(152)
            make.bottom.equalToSuperview()
        }
    }
    
}

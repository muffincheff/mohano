//
//  PostView.swift
//  mohasem
//
//  Created by orca on 2022/09/05.
//

import UIKit

class PostView: UIView {
    var name = UILabel()
    var memo = UILabel()
    var img = UIImageView()
    
    var alertBoard = UIView()
    var alertClock = UIImageView()
    
    var alertBell = UIImageView()
    var alertBellText = UILabel()
    var alertText = UILabel()
    
    init(frame: CGRect = CGRect.zero, post: Post) {
        super.init(frame: frame)
        self.layer.cornerRadius = 18
        self.backgroundColor = UIColor(red: 140/255, green: 121/255, blue: 249/255, alpha: 1)
        
        // img
        self.addSubview(img)
        img.loadImage(url: URL(string: post.img))
        let imgHeight: CGFloat = 80
        img.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(imgHeight)
        }
        
        // name
        self.addSubview(name)
        name.text = post.name
        name.textColor = .white
        name.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        let nameHeight: CGFloat = 20
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(img.snp.trailing).offset(8)
            make.height.equalTo(nameHeight)
            make.trailing.equalToSuperview().offset(10)
        }
        
        // memo
        self.addSubview(memo)
        memo.text = post.memo
        memo.textColor = .white
        memo.font = UIFont.systemFont(ofSize: 12)
        memo.numberOfLines = 0
        let memoHeight: CGFloat = imgHeight - nameHeight
        memo.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom)
            make.leading.equalTo(img.snp.trailing).offset(8)
            make.height.equalTo(memoHeight)
            make.trailing.equalToSuperview().inset(10)
        }
        
        // alert board
        self.addSubview(alertBoard)
        alertBoard.layer.cornerRadius = 12
        alertBoard.backgroundColor = .white.withAlphaComponent(0.5)
        alertBoard.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().inset(10)
            make.top.equalTo(img.snp.bottom).offset(10)
        }
        
        // alert clock
        alertBoard.addSubview(alertClock)
        alertClock.image = UIImage.init(systemName: "clock.fill")
        alertClock.tintColor = .white
        let alertClockWidth: CGFloat = 22
        alertClock.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(alertClockWidth)
        }
        
        // alert bell
        alertBoard.addSubview(alertBell)
        let alertBellWidth: CGFloat = 40
        let alertBellConfig = UIImage.SymbolConfiguration(pointSize: alertBellWidth - 14, weight: .regular, scale: .medium)
        let alertBellImgName = post.alert ? "bell.fill" : "bell.slash.fill"
        alertBell.image = UIImage.init(systemName: alertBellImgName, withConfiguration: alertBellConfig)
        alertBell.contentMode = .center
        alertBell.tintColor = post.alert ? .systemYellow : .white
        alertBell.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.width.height.equalTo(alertBellWidth)
        }
        
        // alert text
        var alertString = post.start.toString()
        if let endDate = post.end { alertString += " ~\n\(endDate.toString())"}
        alertBoard.addSubview(alertText)
        alertText.text = alertString
        alertText.numberOfLines = 0
        alertText.textColor = .white
        alertText.font = UIFont.systemFont(ofSize: 14)
        alertText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().inset(5)
            make.leading.equalTo(alertClock.snp.trailing).offset(8)
            make.trailing.equalTo(alertBell.snp.leading).offset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

































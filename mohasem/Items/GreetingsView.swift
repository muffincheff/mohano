//
//  GreetingsView.swift
//  mohano
//
//  Created by orca on 2022/09/03.
//

import UIKit
import SnapKit

class GreetingsView: UIView {

    private var greetings = UILabel()
    private var after = UILabel()
    private var profileImg = UIImageView()
    private var weatherImg = UIImageView()
    
    init(frame: CGRect = CGRect.zero, profileUrl: String, weather: Weather) {
        super.init(frame: frame)
        
        self.addSubview(profileImg)
        profileImg.loadImage(url: URL(string: profileUrl))
        profileImg.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
            self.profileImg.layer.cornerRadius = self.profileImg.frame.width / 2
            self.profileImg.clipsToBounds = true
        }
        
        self.addSubview(weatherImg)
        let weatherWidth: CGFloat = 40
        let imgConfig = UIImage.SymbolConfiguration(pointSize: weatherWidth - 10, weight: .regular, scale: .medium)
        weatherImg.image = UIImage(systemName: weather.imgName, withConfiguration: imgConfig)
        weatherImg.contentMode = .center
//        weatherImg.backgroundColor = .systemGray6
        weatherImg.tintColor = UIColor.systemTeal.withAlphaComponent(0.7) //UIColor(red: 1, green: 230/255, blue: 0, alpha: 1)
        weatherImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(weatherWidth)
        }
        
//        DispatchQueue.main.async {
//            self.weatherImg.layer.masksToBounds = true
//            self.weatherImg.layer.cornerRadius = weatherWidth / 2
//            self.weatherImg.layer.borderColor = UIColor.systemTeal.withAlphaComponent(0.5).cgColor//UIColor.systemGray6.cgColor
//            self.weatherImg.layer.borderWidth = 1
//        }
        
        self.addSubview(greetings)
        greetings.text = "안녕하세요, 권회정님"
        greetings.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalTo(weatherImg.snp.leading)
            make.leading.equalTo(profileImg.snp.trailing).offset(10)
            make.height.equalTo(28)
        }
        
        self.addSubview(after)
        after.text = "좋은하루 되세요!"
        after.textColor = UIColor.systemGray
        after.font = UIFont.systemFont(ofSize: 12)
        after.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalTo(weatherImg.snp.leading)
            make.top.equalTo(greetings.snp.bottom)
            make.leading.equalTo(profileImg.snp.trailing).offset(10)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

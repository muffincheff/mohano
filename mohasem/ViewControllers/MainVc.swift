//
//  MainVcViewController.swift
//  mohano
//
//  Created by orca on 2022/09/02.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

class MainVc: UIViewController, View {

    var disposeBag = DisposeBag()
    
    var tabbar = UITabBar()
    var home: HomeVc! = nil

    init(reactor: MainReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
        
        let icon1 = UITabBarItem(title: "home", image: UIImage.init(systemName: "house"), selectedImage: UIImage.init(systemName: "house.fill"))
//        icon1.tag = Scenes.table.rawValue
//        tableVc.tabBarItem = icon1
        
        let icon2 = UITabBarItem(title: "schedule", image: UIImage.init(systemName: "list.bullet.rectangle.portrait"), selectedImage: UIImage.init(systemName: "list.bullet.rectangle.portrait.fill"))
//        icon2.tag = Scenes.collection.rawValue
        
        let icon3 = UITabBarItem(title: "profile", image: UIImage.init(systemName: "person"), selectedImage: UIImage.init(systemName: "person.fill"))

        tabbar.setItems([icon1, icon2, icon3], animated: true)
        tabbar.tintColor = .systemIndigo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MainReactor) {
        // action

        
        // state
        reactor.state
            .map { $0.currentScene }
            .distinctUntilChanged()
            .subscribe { [weak self] scene in
                self?.goScene(scene: scene)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        // tab bar
        self.view.addSubview(tabbar)
        tabbar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
    }
    
    func goScene(scene: Scenes) {
        switch scene {
        case .home: goHome()
        case .shcedule: break
        case .profile: break
        }
    }
    
    func goHome() {
        if home == nil {
            home = HomeVc(reactor: HomeReactor())
            self.addChild(home)
            self.view.addSubview(home.view)
            home.view.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(self.view.safeAreaLayoutGuide)
                make.bottom.equalTo(tabbar.snp.top)
            }
            
        } else {
            home.view.isHidden = false
        }
    }
    
}

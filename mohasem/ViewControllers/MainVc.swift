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
    
//    override func viewDidAppear(_ animated: Bool) {
//        // test!
//        _scene
//    }
    
    func setViews() {
        // tab bar
        let icon1 = UITabBarItem(title: "home", image: UIImage.init(systemName: "house"), selectedImage: UIImage.init(systemName: "house.fill"))
//        icon1.tag = Scenes.table.rawValue
//        tableVc.tabBarItem = icon1
        
        let icon2 = UITabBarItem(title: "calendar", image: UIImage.init(systemName: "doc.append.rtl"), selectedImage: UIImage.init(systemName: "doc.append.rtl.fill"))
//        icon2.tag = Scenes.collection.rawValue
        
        let icon3 = UITabBarItem(title: "profile", image: UIImage.init(systemName: "person"), selectedImage: UIImage.init(systemName: "person.fill"))

        tabbar.setItems([icon1, icon2, icon3], animated: true)
        tabbar.tintColor = .systemIndigo
        
        self.view.addSubview(tabbar)
        if let firstItem = tabbar.items?.first { tabbar.selectedItem = firstItem }
        tabbar.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
    }
    
    func goScene(scene: Scenes) {
        switch scene {
        case .home: goHome()
        case .calendar: break
        case .profile: break
        case .signin: break
        case .main: break
        case .posts: break
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

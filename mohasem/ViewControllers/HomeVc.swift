//
//  HomeVc.swift
//  mohano
//
//  Created by orca on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit

class HomeVc: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    var scrollview = UIScrollView()
    var stackview = UIStackView()
    
    init(reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: HomeReactor) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        // scroll view
        self.view.addSubview(scrollview)
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        var scrollviewContentInset = scrollview.contentInset
        scrollviewContentInset.top += 10
        scrollview.contentInset = scrollviewContentInset
        scrollview.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        // stack view
        scrollview.addSubview(stackview)
        stackview.spacing = 18
        stackview.axis = .vertical
        stackview.snp.makeConstraints { make in
            make.edges.equalTo(scrollview.contentLayoutGuide)
            make.width.equalTo(scrollview.frameLayoutGuide)
        }
        
        // greetings view
        let greetings = GreetingsView(profileUrl: "https://post-phinf.pstatic.net/MjAyMTEyMDdfOTUg/MDAxNjM4ODM5NTYyNDk0.80zklzfS0zHsaWAruNsZbs0UThC2S7XsbCZn3rFwKjIg.B6jCK90imdoXIyVisJ5SwEiQCl0FxLJtfTnYPcFdvqYg.JPEG/0.jpg?type=w1200", weather: Weather.rainy)
        stackview.addArrangedSubview(greetings)
        greetings.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

}

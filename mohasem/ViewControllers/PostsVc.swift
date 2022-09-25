//
//  PostsVc.swift
//  mohasem
//
//  Created by orca on 2022/09/20.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class PostsVc: UIViewController, View {
    var disposeBag = DisposeBag()
    
    let close = UIButton()              // '닫기' 버튼
    let more = UIButton()               // '더보기' 버튼
    let add = UIButton(type: .system)   // '추가' 버튼
    let board = UIView()                // 스케쥴들이 표시될 UI
    let scrollview = UIScrollView()
    let stackview = UIStackView()

    init(reactor: PostsReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    func bind(reactor: PostsReactor) {
        // action
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        close.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.view.backgroundColor = .clear
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        more.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.more.isHidden = true
            })
            .disposed(by: disposeBag)
        
        // bottom 여부에 따라 '더보기' 버튼 hidden 설정
        scrollview.rx.reachedBottom()
            .subscribe(onNext: { [weak self] isReached in
                print("isReached: \(isReached)")
                self?.more.isHidden = !isReached
            })
            .disposed(by: disposeBag)
        
        // state
        reactor.state
            .map { $0.posts }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] posts in
                // 스케쥴 표시
                self?.stackview.arrangedSubviews.forEach({ $0.removeFromSuperview() })
                
                posts.forEach({
                    let postview = PostView(post: $0)
                    self?.stackview.addArrangedSubview(postview)
                    postview.snp.makeConstraints { $0.height.equalTo(150) }
                })
                
            })
            .disposed(by: disposeBag)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.85)
        
        // board
        self.view.addSubview(board)
        board.backgroundColor = .white
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        board.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(screenHeight)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // board animation
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(120)) {
            self.board.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(150)
            }
            
            UIView.animate(withDuration: 0.34, delay: 0, options: [.curveEaseOut], animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
            })
            
            self.board.roundCorners(corners: [.topLeft], radius: 30)
        }
        
        // title
        let vcTitle = UILabel()
        self.view.addSubview(vcTitle)
        vcTitle.text = "다음 스케쥴"
        vcTitle.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        vcTitle.textColor = .white
        vcTitle.snp.makeConstraints { make in
            make.bottom.equalTo(board.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        // close
        self.view.addSubview(close)
        let closeImgConfig = UIImage.SymbolConfiguration(pointSize: 20)
        close.setImage(UIImage(systemName: "xmark", withConfiguration: closeImgConfig), for: .normal)
        close.tintColor = UIColor.white
        close.snp.makeConstraints { make in
            make.bottom.equalTo(board.snp.top)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(50)
        }
       
        // scroll view
        board.addSubview(scrollview)
        scrollview.layer.cornerRadius = 20
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.showsVerticalScrollIndicator = false
        var scrollviewContentInset = scrollview.contentInset
        scrollviewContentInset.bottom += 40
        scrollview.contentInset = scrollviewContentInset
        scrollview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(26)
        }
        
        // stack view
        scrollview.addSubview(stackview)
        stackview.spacing = 12
        stackview.axis = .vertical
        stackview.snp.makeConstraints { make in
            make.edges.equalTo(scrollview.contentLayoutGuide)
            make.width.equalTo(scrollview.frameLayoutGuide)
        }
        
        // more
        board.addSubview(more)
        var moreConfig = UIButton.Configuration.plain()
        var titleAttr = AttributedString.init("더보기")
        titleAttr.font = .systemFont(ofSize: 12, weight: .regular)
        moreConfig.attributedTitle = titleAttr
        moreConfig.imagePlacement = .bottom
        moreConfig.imagePadding = -4
        moreConfig.image = UIImage(systemName: "chevron.compact.down")
        moreConfig.baseForegroundColor = .systemGray3
        more.configuration = moreConfig
        more.backgroundColor = .clear
        more.layer.backgroundColor = UIColor.clear.cgColor
        more.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(26)
            make.height.equalTo(40)
        }
        more.isHidden = true
        
        // add
        board.addSubview(add)
        add.tintColor = .white
        add.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)), for: .normal)
        add.backgroundColor = UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 1).withAlphaComponent(0.8)
        let addWidth: CGFloat = 50
        add.layer.cornerRadius = addWidth / 2
        add.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(20)
            make.height.width.equalTo(addWidth)
        }
    }
    


}

//
//  HomeVc.swift
//  mohano
//
//  Created by orca on 2022/09/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import ReactorKit
import SnapKit
import RxGesture

class HomeVc: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    var scrollview = UIScrollView()
    var stackview = UIStackView()
    let postboard = PostBoard(posts: [])
    
    init(reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: HomeReactor) {
        // action
        self.rx.viewDidLoad
            .map { Reactor.Action.refresh }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        postboard.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                print("\n[TAP POST BOARD]\n")
                _scene.transition(scene: .posts, style: .modal(.overFullScreen), animated: false)
            })
            .disposed(by: disposeBag)
        
        // state
        reactor.state
            .map { $0.posts }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (posts) -> Void in
                var postviews: [PostView] = []
                posts.forEach({
                    postviews.append(PostView(post: $0))
                })
                self?.postboard.setBoard(posts: postviews)
            })
            .disposed(by: disposeBag)
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
        scrollviewContentInset.top += 18
        scrollview.contentInset = scrollviewContentInset
        scrollview.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        // stack view
        scrollview.addSubview(stackview)
        stackview.spacing = 30
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
        
        // post view
        var postviews: [PostView] = []
        if let posts = self.reactor?.initialState.posts {
            posts.forEach({
                let tempPostView = PostView(post: $0)
                postviews.append(tempPostView)
            })
        }
        
        // post board
        stackview.addArrangedSubview(postboard)
        postboard.snp.makeConstraints { make in
            make.height.equalTo(210)
        }
        
        // scribbles
        let scribbles = [
            Scribble(name: "Lion Heart", content: """
                     Ooh, 너와 나 첨 만났을 때
                     Ooh, 마치 사자처럼 맴돌다
                     기회를 노려 내 맘 뺏은 너
                     Ah, 넌 달라진 게 없어 여전해
                     난 애가 타고 또 타
                     사냥감 찾아 한 눈 파는 너
                     수백 번 밀어내야 했는데
                     수천 번 널 떠나야 했는데
                     Tell me why
                     왜 맘이, 맘이 자꾸 흔들리니?
                     난 여기, 여기 네 옆에 있잖니
                     정신 차려 lion heart
                     """,
                     img: "https://img3.yna.co.kr/etc/inner/KR/2022/05/17/AKR20220517059000005_01_i_P4.jpg"),
            
            Scribble(name: "도깨비불", content: """
                     Look at you, 빨라지는 걸음걸이
                     Look at me, 호기심을 자극하지
                     Look at them, 알아챌 수 없는 거리
                     Baby, don't panic, 한밤의 party
                     차올라 달이 딱 좋은 timing
                     이건 비밀이야, 쉿, 우리만의
                     한밤의 party, 널 끌어당김
                     어쩌니? 내게 뺏겨버린 환심
                     몽롱한 기분이 좋은 tonight
                     색다른 세계로 이끄는 light (i-i-i-i-illusion)
                     """,
                     img: "https://play-lh.googleusercontent.com/_y_SedWLtzKcha63aEp9nSGOuJtEMsg5my0lcJLiTb0GczWEIbvHlteYlrT0iQui-RAU"),
            
            Scribble(name: "Dolphin", content: """
                                               Oh, my god 타이밍이 참 얄미워
                                               오늘 같은 날 마주쳐 이게 뭐야
                                               머리는 엉망인 데다 상태가 말이 아니야
                                               모른 척 지나가 줘
                                               내 맘이 방심할 때마다 불쑥 나타난 뒤
                                               헤엄치듯 멀어지는 너
                                               또 물보라를 일으켜
                                               Da-da-da-da, da-da-da-da-da-da
                                               Da-da-da-da 또 물보라를 일으켜
                                               Da-da-da-da, da-da-da-da-da-da
                                               Da-da-da-da 또 물보라를 일으켜
                                               """, img: "https://image.koreatimes.com/article/2021/05/10/20210510094734601.jpg")
        ]
        // https://cdn.dribbble.com/users/1787323/screenshots/14593609/media/f821646219ea968da9b16a7dae6f37a1.png?compress=1&resize=400x300     // 샘플 이미지 1
        // https://cdn.dribbble.com/users/1787323/screenshots/12028973/media/e9c516b80edd160238dbac482e39a2fd.png?compress=1&resize=400x300     // 샘플 이미지 2
        
        // scribble board
        let scribbleBoard = ScribbleBoard(scribbles: scribbles)
        stackview.addArrangedSubview(scribbleBoard)
        scribbleBoard.snp.makeConstraints { make in
            make.height.equalTo(280)
        }
    }

}






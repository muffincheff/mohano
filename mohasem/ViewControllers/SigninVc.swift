//
//  SigninVc.swift
//  mohasem
//
//  Created by orca on 2022/09/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import ReactorKit
import SnapKit

class SigninVc: UIViewController, View {
    var disposeBag = DisposeBag()
    
    let vcTitle = UILabel()
    let stack = UIStackView()
    let apple = UIImageView(image: UIImage(named: "icon-apple"))
    let kakao = UIImageView(image: UIImage(named: "icon-kakao"))
    
    init(reactor: SigninReactor) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: SigninReactor) {
        // action
        kakao.rx.tapGesture()
            .filter({ _ in return reactor.currentState.isAuthenticating == false })
            .when(.recognized)
            .asDriver(onErrorJustReturn: .init())
            .map { _ in Reactor.Action.tapKakao }
            .drive(reactor.action)
            .disposed(by: disposeBag)
        
        // state
        reactor.state
            .map { $0.signedSocial }
            .distinctUntilChanged()
            .subscribe(onNext: { social in
                
                switch social {
                case .none(let err):
                    let alert = UIAlertController(title: "로그인 실패", message: err, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    self.present(alert, animated: true)
                default:
                    _scene.transition(scene: .main, style: .modal(.fullScreen))
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title
//        let title = UILabel()
        self.view.addSubview(vcTitle)
        vcTitle.font = UIFont(name: "KOTRA-HOPE", size: 60)
        vcTitle.text = "모하셈"
        vcTitle.numberOfLines = 0
        vcTitle.textColor = UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 1)
        vcTitle.sizeToFit()
        let titleHeight = vcTitle.frame.height
        vcTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-titleHeight / 2)
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(vcTitle.frame.width)
            make.height.equalTo(titleHeight)
        }
        
        // logo
        let logo = UIImageView(image: UIImage(named: "icon-note"))
        self.view.addSubview(logo)
        logo.contentMode = .scaleAspectFit
        logo.snp.makeConstraints { make in
            make.leading.equalTo(vcTitle.snp.trailing).offset(14)
            make.centerY.equalTo(vcTitle.snp.centerY)
            make.width.equalTo(titleHeight - 20)
            make.height.equalTo(titleHeight - 20)
        }
        
        let topCircle1 = UIView()
        let topCircle1Width: CGFloat = 390
        
        let topCircle2 = UIView()
        let topCircle2Width: CGFloat = 480
        
        let bottomCircle = UIView()
        let bottomCircleWidth: CGFloat = 800
        
        
        // draw ui
        DispatchQueue.main.async {
            // top circle
            self.view.addSubview(topCircle1)
            topCircle1.backgroundColor = UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 0.1)
            
            topCircle1.layer.cornerRadius = topCircle1Width / 2
            topCircle1.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(-topCircle1Width / 2 + 30)
                make.leading.equalTo(self.view.frame.width / 2 - 50)
                make.width.height.equalTo(topCircle1Width)
            }
            
            // top circle 2
            self.view.addSubview(topCircle2)
            topCircle2.backgroundColor = UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 0.2)
            
            topCircle2.layer.cornerRadius = topCircle2Width / 2
            topCircle2.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(-topCircle2Width / 2 + 60)
                make.leading.equalTo(self.view.frame.width / 2 - 10)
                make.width.height.equalTo(topCircle2Width)
            }
            
            
            // bottom circle
            self.view.addSubview(bottomCircle)
            bottomCircle.backgroundColor = UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 0.3)
            
            bottomCircle.layer.cornerRadius = bottomCircleWidth / 2
            bottomCircle.snp.makeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).offset(-bottomCircleWidth / 2 + 20)
                make.leading.equalTo(-self.view.frame.width / 1.05)
                make.width.height.equalTo(bottomCircleWidth)
            }
            
            // stack view of socials
            self.stack.isHidden = true
            self.view.addSubview(self.stack)
            self.stack.axis = .horizontal
            self.stack.spacing = 16
            let iconWidth: CGFloat = 50
            self.stack.snp.makeConstraints { make in
                make.top.equalTo(self.vcTitle.snp.bottom).offset(30)
                make.centerX.equalToSuperview()
                make.height.equalTo(iconWidth)
            }
            
            // apple
            self.stack.addArrangedSubview(self.apple)
            self.apple.snp.makeConstraints { make in
                make.width.equalTo(iconWidth)
            }
            
            // separator
            self.addSeparator()
            
            // kakao
            self.stack.addArrangedSubview(self.kakao)
            self.kakao.clipsToBounds = true
            self.kakao.layer.cornerRadius = 8
            self.kakao.snp.makeConstraints { make in
                make.width.equalTo(iconWidth)
            }
        }
        
        // animation
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.vcTitle.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-110)
            }
            
            topCircle1.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(-topCircle1Width / 2)
                make.leading.equalTo(self.view.frame.width / 2 - 90)
            }
            
            topCircle2.snp.updateConstraints { make in
                make.top.equalToSuperview().offset(-topCircle2Width / 2 + 20)
                make.leading.equalTo(self.view.frame.width / 2 + 30)
            }
            
            bottomCircle.snp.updateConstraints { make in
                make.top.equalTo(self.view.snp.bottom).offset(-bottomCircleWidth / 2 + 70)
                make.leading.equalTo(-self.view.frame.width / 0.95)
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                self.stack.isHidden = false
            })
        
        }
    }
    
    func addSeparator() {
        let sepContainer = UIView()
        self.stack.addArrangedSubview(sepContainer)
        sepContainer.backgroundColor = .clear
        sepContainer.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
        
        let sep = UIView()
        sepContainer.addSubview(sep)
        sep.backgroundColor = .systemGray4//UIColor(red: 0, green: 207/255, blue: 208/255, alpha: 0.3)
        sep.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(20)
        }
    }
    
}

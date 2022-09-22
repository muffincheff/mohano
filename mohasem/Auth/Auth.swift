//
//  Auth.swift
//  mohasem
//
//  Created by orca on 2022/09/15.
//

import Foundation
import RxKakaoSDKUser
import KakaoSDKUser
import KakaoSDKAuth
import RxSwift

var _auth: Auth = {
    return Auth.shared
}()

enum Socials: Equatable {
    case kakao
    case apple
    case none(String)
}

class Auth {
    static let shared = Auth()
    
    let disposeBag = DisposeBag()
    var social: Socials = .none("")
    var id: String = ""
    
    private init() { }
    
    func signinWithKakao(_ completion: @escaping ((Bool, String) -> Void)) -> Disposable {
        
        // recieve token
        func receiveToken(oauthToken: OAuthToken) {
            print("\n[KAKAO SIGN-IN SUCCESS]\n auth token: \(oauthToken)")

            self.social = .kakao
            self.getUserInfo { (success, msg) in
                completion(success, "")
            }
        }
        
        // request sign-in
        if UserApi.isKakaoTalkLoginAvailable() {
            return UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: receiveToken(oauthToken:))
        } else {
            return UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext: receiveToken(oauthToken:), onError: {error in
//                    print(error)
                    completion(false, error.localizedDescription)
                })
        }
    }
    
    func getUserInfo(_ completion: @escaping ((Bool, String) -> Void)) {
        //사용자 관리 api 호출
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print("get kakao user info ---> failed.. (\(error))")
                completion(false, error.localizedDescription)
            }
            else {
//                let nickname = user?.kakaoAccount?.profile?.nickname
//                let email = user?.kakaoAccount?.email
                
                guard let userid = user?.id else {
                    completion(false, "kakao user id is empty")
                    return
                }
                
                self.id = String(userid)
                completion(true, "")
                
//                print("get kakao user info success! ---> nickName: \(nickname ?? "")")
//                print("get kakao user info success! ---> email: \(email ?? "")")
//                print("get kakao user info success! ---> id: \(userid ?? 0)")
            }
        }
    }
}

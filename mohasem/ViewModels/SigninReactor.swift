//
//  SigninReactor.swift
//  mohasem
//
//  Created by orca on 2022/09/11.
//

import Foundation
import ReactorKit

class SigninReactor: Reactor {
    
    enum Action {
        case tapKakao
        case tapApple
    }
    
    enum Mutation {
        case authKakao
        case authApple
        case authFailed(String)
        case isAuthenticating(Bool)
    }
    
    struct State {
        var signedSocial: Socials = .none("")
        var isAuthenticating: Bool = false
    }
    
    var initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapKakao:
            let signinKakaoObservable = Observable<Mutation>.create({ (observer) -> Disposable in

                #if targetEnvironment(simulator)

                observer.onNext(.authKakao)
                observer.onCompleted()
                return Disposables.create()
                
                #else
                
                return _auth.signinWithKakao { (success, msg) in
                    if success {
                        observer.onNext(.authKakao)
                    }
                    else {
                        observer.onNext(.authFailed(msg))
                    }
                    observer.onCompleted()
                }
                
                #endif
                
            })
            
            return Observable.concat([
                Observable.just(Mutation.isAuthenticating(true)),
                signinKakaoObservable,
                Observable.just(Mutation.isAuthenticating(false))
            ])
            
            
            
        case .tapApple:
            return Observable.just(.authApple)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .authKakao:
            state.isAuthenticating = false
            state.signedSocial = .kakao
        case .authApple:
            state.isAuthenticating = false
            state.signedSocial = .apple
        case .authFailed(let msg):
            state.isAuthenticating = false
            state.signedSocial = .none(msg)
        case .isAuthenticating(let authenticating):
            state.isAuthenticating = authenticating
        }
        
        return state
    }
}


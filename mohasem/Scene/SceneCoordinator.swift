//
//  SceneCoordinator.swift
//  mohasem
//
//  Created by orca on 2022/09/16.
//

import Foundation
import UIKit

var _scene: SceneCoordinator = {
    return SceneCoordinator.shared
}()

class SceneCoordinator {
    static let shared = SceneCoordinator()
    
    var currentVc: UIViewController!
    
    private init() {
        initCurrentVc()
    }
    
    func initCurrentVc() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        guard let firstWindow = firstScene.windows.first else {
            return
        }

        let vc = firstWindow.rootViewController
        currentVc = vc
    }
    
    func transition(scene: Scenes, style: TransitionStyle, animated: Bool = true) {
        if currentVc == nil { initCurrentVc() }
        
        switch style {
//        case .root:
//            currentVc = target.sceneViewController
        case .push:
            guard let nav = currentVc.navigationController else {
                print("[SCENE COORDINATOR]\n push failed.. (navigationController not exist)")
                break
            }
            
            guard let targetVc = getVc(scene: scene) else {
                print("[SCENE COORDINATOR]\n push failed.. (target view controller is nil)")
                return
            }
            
            nav.pushViewController(targetVc, animated: animated)
            currentVc = targetVc.sceneViewController
            
        case .modal(let presentationStyle):
            guard let targetVc = getVc(scene: scene) else {
                print("[SCENE COORDINATOR]\n push failed.. (target view controller is nil)")
                return
            }
            
            targetVc.modalPresentationStyle = presentationStyle
            currentVc.present(targetVc, animated: animated)
        }
    }
    
    private func getVc(scene: Scenes) -> UIViewController? {
        switch scene {
        case .signin:
            return SigninVc(reactor: SigninReactor())
        case .main:
            return MainVc(reactor: MainReactor())
        case .home:
            return nil //HomeVc(reactor: HomeReactor())
        case .calendar:
            return nil
        case .profile:
            return nil
        case .posts:
            return PostsVc(reactor: PostsReactor())
        }
    }
}

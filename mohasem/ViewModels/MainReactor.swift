//
//  MainReactor.swift
//  mohano
//
//  Created by orca on 2022/09/02.
//

import ReactorKit
import RxSwift

class MainReactor: Reactor {
    
    enum Action {
        case tapItem(UITabBarItem)
    }
    
    enum Mutation {
        case goHome
        case goSchedule
        case goProfile
        case none
    }
    
    struct State {
        var currentScene = Scenes.home
    }
    
    var initialState = State()
}

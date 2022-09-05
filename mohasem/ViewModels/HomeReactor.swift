//
//  HomeReactor.swift
//  mohano
//
//  Created by orca on 2022/09/05.
//

import ReactorKit

class HomeReactor: Reactor {
    enum Action {
        case tapUser
        case tapSchedule
        case tapCategory
        case tapAllCategories
    }
    
    enum Mutation {
        case tapUser
        case tapSchedule
        case tapCategory
        case tapAllCategories
    }
    
    struct State {
        var isLoding: Bool = false
    }
    
    var initialState = State()
}

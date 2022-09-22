//
//  HomeReactor.swift
//  mohano
//
//  Created by orca on 2022/09/05.
//

import ReactorKit

class HomeReactor: Reactor {
    enum Action {
        case refresh
        case tapUser
        case tapSchedule
        case tapCategory
        case tapAllCategories
    }
    
    enum Mutation {
        case setPosts([Post])
        case tapUser
        case tapSchedule
        case tapCategory
        case tapAllCategories
        case none
    }
    
    struct State {
        var isLoding: Bool
        var posts: [Post]
    }
    
    var initialState: State
    
    init() {
        initialState = State(isLoding: true, posts: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let postsObservable = Observable<Mutation>.create({ (observer) -> Disposable in

                DispatchQueue.main.async {
                    var posts: [Post] = []
                    posts.append(Post(id: "test-schedule-1", start: Date(), name: "test schedule 1", memo: "스케쥴......스케쥴......스케쥴......스케쥴......스케쥴......스케쥴......스케쥴......스케쥴......스케쥴......", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    observer.onNext(.setPosts(posts))
                    observer.onCompleted()
                }
                
                return Disposables.create()
            })
            
            return postsObservable
            
        default:
            return Observable.just(.none)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .setPosts(let posts):
            state.posts = posts
            
        default: break
        }
        
        
        return state
    }
}

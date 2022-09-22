//
//  PostsReactor.swift
//  mohasem
//
//  Created by orca on 2022/09/20.
//

import Foundation
import ReactorKit
import RxSwift

class PostsReactor: Reactor {
    
    enum Action {
        case refresh
        case tapClose
        case tapMore
    }
    
    enum Mutation {
        case setPosts([Post])
        case close
        case more
    }
    
    struct State {
        var posts: [Post]
    }
    
    var initialState: State
    
    init() {
        initialState = State(posts: [])
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let postsObservable = Observable<Mutation>.create({ (observer) -> Disposable in

                DispatchQueue.main.async {
                    var posts: [Post] = []
                    posts.append(Post(id: "test-schedule-1", start: Date(), name: "test schedule 1", memo: "스케쥴 1", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    posts.append(Post(id: "test-schedule-2", start: Date(), name: "test schedule 2", memo: "스케쥴 2", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    posts.append(Post(id: "test-schedule-3", start: Date(), name: "test schedule 3", memo: "스케쥴 3", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    posts.append(Post(id: "test-schedule-4", start: Date(), name: "test schedule 4", memo: "스케쥴 4", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    posts.append(Post(id: "test-schedule-5", start: Date(), name: "test schedule 5", memo: "스케쥴 5", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    posts.append(Post(id: "test-schedule-6", start: Date(), name: "test schedule 6", memo: "스케쥴 6", img: "https://www.pngmart.com/files/6/Rocket-PNG-Clipart.png"))
                    observer.onNext(.setPosts(posts))
                    observer.onCompleted()
                }
                
                return Disposables.create()
            })
            
            return postsObservable
            
        case .tapClose:
            return Observable.just(.close)
            
        case .tapMore:
            return Observable.just(.more)
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

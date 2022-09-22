//
//  ScribbleVc.swift
//  mohasem
//
//  Created by orca on 2022/09/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ScribbleVc: UIViewController, View {
    var disposeBag = DisposeBag()
    
    init(reactor: ScribbleReactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: ScribbleReactor) {
        
    }
}

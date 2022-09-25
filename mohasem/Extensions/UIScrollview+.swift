//
//  UIScrollview+.swift
//  mohasem
//
//  Created by orca on 2022/09/25.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIScrollView {
    /**
     💬 reachedBottom
     .. scroll의 bottom 도달 여부를 알려준다
     
     ✔️ RxCocoa의 UIScrollView.contentOffset을 통해 UIScrollView의 현재 스크롤 위치를 비동기 이벤트로 받아올 수 있다.
     
     ✔️ 이렇게 받아온 스크롤 위치를 현재 UIScrollView의 ContentSize와 비교하여 스크롤이 아래에 닿았는지 확인한다.
     
     ✔️ visibleHeight
       .. 현재 UIScrollView에서 표시되고 있는 높이
       .. UIScrollView의 크기(frame)에서 상하 여백(Inset)을 빼서 구한다.
     
     ✔️ y
       .. 현재 UIScrollView에서 표시되고 있는 좌측 상단 꼭짓점의 y좌표이다.
     
     ✔️ threshold
       .. UIScrollView가 표시할 전체 Content의 높이 (self.base.contentSize.height)에서 현재 UIScrollView에서 표시되고 있는 높이(visibleHeight)를 빼면 사용자가 UIScrollView를 끝까지 내렸을 때 표시되는 화면의 좌측 상단 꼭짓점의 y좌표를 구할 수 있다.
       .. UIScrollView를 끝까지 내리기 전에, 일정 거리만큼 남았을 때 ControlEvent를 내려보내고 싶다면, space 매개변수를 통해 임계점을 더 위쪽에 만들 수 있다.
     
     ✔️ return y >= threshold
       .. View의 좌표는 화면 아래로 내려갈수록 증가하므로, y 변수가 threshold보다 커진다는 말은, 임계점보다 아래로 스크롤이 되었다는 뜻이다.
       .. 이때 방출되는 이벤트는 filter{ $0 }를 통과하여 ControlEvent가 끝까지 내려간다.
     
     ✔️ 마지막 map은 binding 할 때의 편의를 위한 코드이다.
       .. 저 map이 없다면 매번 scrollView.reachedBottom().map{ _ in ~ }과 같이 map 안에서 _ in을 써줘야 하기 때문이다.
     
     */
    
    func reachedBottom(offset: CGFloat = 0.0) -> ControlEvent<Bool> {
        let source = contentOffset.map { contentOffset -> Bool in
//            print("content offset: \(contentOffset.debugDescription)")
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
//        .filter { $0 }
        .map { return $0 }
        return ControlEvent(events: source)
    }
}

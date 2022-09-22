//
//  Post.swift
//  mohasem
//
//  Created by orca on 2022/09/05.
//
import Foundation
import UIKit

struct Post {
    
    var id: String
    var start: Date
    var end: Date? = nil
    var name: String
    var alert: Bool
    var memo: String
    var category: (name: String, color: UIColor)
    var img: String
    
    init(id: String, start: Date, name: String, end: Date? = nil, alert: Bool = true, memo: String = "", category: (String, UIColor) = ("", .clear), img: String = "") {
        self.id = id
        self.start = start
        self.end = end
        self.name = name
        self.alert = alert
        self.memo = memo
        self.category = category
        self.img = img
    }
}

extension Post: Equatable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}


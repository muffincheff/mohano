//
//  UIImageView+.swift
//  Pods
//
//  Created by orca on 2022/09/03.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(_ urlString: String) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                if let data = try? Data(contentsOf: URL(string: urlString)!) {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

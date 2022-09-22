//
//  UIImageView+.swift
//  Pods
//
//  Created by orca on 2022/09/03.
//

import Foundation
import UIKit

extension UIImageView {
    /*
    func loadImage(_ urlString: String) {
        if urlString.isEmpty { return }
        
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                guard let url = URL(string: urlString) else {
                    fatalError("failed to create URL\n - url string: '\(urlString)'")
                    return
                }
                if let data = try? Data(contentsOf: url) {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
     */
    
    func loadImage(url: URL?, completion: (() -> Void)? = nil) {
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
            completion?()
        }.resume()
    }
}

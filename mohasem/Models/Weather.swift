//
//  Weather.swift
//  mohano
//
//  Created by orca on 2022/09/03.
//

import UIKit

enum Weather {
    case sunny
    case cloudy
    case rainy
    case foggy
    case windy
    
    var imgName: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .cloudy: return "cloud.fill"
        case .rainy: return "cloud.rain.fill"
        case .foggy: return "cloud.fog.fill"
        case .windy: return "wind"
        }
    }
}

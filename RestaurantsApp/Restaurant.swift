//
//  Restaurant.swift
//  RestaurantsApp
//
//  Created by Yuki Tsukada on 2021/02/07.
//

import Foundation
import UIKit

struct Restaurant: Hashable {
    enum CuisineType: String {
        case Japanese = "Japanese"
        case Korean = "Korean"
        case French = "French"
        case Italian = "Italian"
        case American = "American"
        case Spanish = "Spanish"
        case Indian = "Indian"
        case Chinese = "Chinese"
        case Turkish = "Turkish"
        case Russian = "Russian"
    }
    
    enum MealTime: String {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
    }
    
    enum PriceRange: String {
        case low = "$"
        case medium = "$$"
        case high = "$$$"
    }
    
    var name: String
    var image: UIImage?
    var type: CuisineType
    var mealTime: [MealTime]
    var cost: PriceRange
}

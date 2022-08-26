//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Andrey on 26.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import Foundation


struct Place {
    let name: String
    let location: String
    let type: String
    let image: String
    
   static let restaurantNames = [
           "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
           "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
           "Speak Easy", "Morris Pub", "Вкусные истории",
           "Классик", "Love&Life", "Шок", "Бочка"
       ]
   static func getPlaces() -> [Place]{
        var places = [Place]()
        
        for place in restaurantNames {
            places.append(Place(name: place, location: "Ufa", type: "Restauran", image: place))
        }
        
         return places
    }
   
}

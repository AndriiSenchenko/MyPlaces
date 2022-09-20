//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Andrey on 26.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import RealmSwift

class Place: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String? = nil
    @objc dynamic var type: String? = nil
    @objc dynamic var imageData: Data? = nil
    
    let restaurantNames = [
           "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
           "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
           "Speak Easy", "Morris Pub", "Вкусные истории",
           "Классик", "Love&Life", "Шок", "Бочка"
       ]
    func savePlace() {
        
        for place in restaurantNames {
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "yzgorod"
            newPlace.type = "restoraunt"
            newPlace.imageData = UIImage(named: place)?.pngData()
            
            StorageManager.saveObject(newPlace)
            
        }
    
         
    }
    
    convenience init(name: String, location: String?, type: String?, image: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = image
        
    }
   
}

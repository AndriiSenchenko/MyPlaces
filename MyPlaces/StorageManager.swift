//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Andrey on 09.09.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager{
    static func saveObject(_ place: Place){
        try! realm.write{
            realm.add(place)
        }
    }
    static func deleteObject(_ place: Place){
        try! realm.write{
            realm.delete(place)
        }
    }
    
    // MARK: - Seeding data
    static func seedData() {
        let places = realm.objects(Place.self)
        guard places.count == 0 else { return }
        let restaurantNames = [
                  "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
                  "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
                  "Speak Easy", "Morris Pub", "Вкусные истории",
                  "Классик", "Love&Life", "Шок", "Бочка"
              ]
        for place in restaurantNames {
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "yzgorod"
            newPlace.type = "restoraunt"
            newPlace.imageData = UIImage(named: place)?.pngData()
            StorageManager.saveObject(newPlace)
        }
    }
}

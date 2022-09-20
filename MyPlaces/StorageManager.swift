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
}

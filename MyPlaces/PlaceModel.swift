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
    @objc dynamic var date = Date()
    
    convenience init(name: String, location: String?, type: String?, image: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = image
    }
}

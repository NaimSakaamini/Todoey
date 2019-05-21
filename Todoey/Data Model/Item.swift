//
//  Item.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-21.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title :  String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    
    //inverse relationship to Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

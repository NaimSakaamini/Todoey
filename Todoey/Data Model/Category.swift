//
//  Category.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-21.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name :  String = ""
    //forward relationship
    let items = List<Item>()
    
    @objc dynamic var bgColor :  String = ""
}

//
//  Item.swift
//  Todoey
//
//  Created by Ron on 15/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}



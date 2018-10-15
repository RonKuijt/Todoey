//
//  Category.swift
//  Todoey
//
//  Created by Ron on 15/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}

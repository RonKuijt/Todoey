//
//  Data.swift
//  Todoey
//
//  Created by Ron on 15/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

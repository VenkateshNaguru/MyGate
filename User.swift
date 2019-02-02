//
//  User.swift
//  MyGate
//
//  Created by Venkatesh Naguru on 02/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class User : Object {
    @objc dynamic var username : String = ""
    @objc dynamic var passcode : Int = 0
    @objc dynamic var imageData : Data?
}

//
//  User.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct User {
    var userName: String
}

struct Name {
    var firstName: String
    var lastName: String
}

struct Stats {
    var age: String
    var height: Double // Simply save in inches then do a calculation to feet later
    var weight: Double
}

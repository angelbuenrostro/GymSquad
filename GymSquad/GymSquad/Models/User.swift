//
//  User.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct User {
    var userName: String
    let creationDate: Date
    
    var dictionary: [String:Any] {
        return[
            "userName":userName,
            "creationDate":creationDate
        ]
    }
}

extension User: DocumentSerializable {
    init?(dictionary: [String:Any]) {
        guard let userName = dictionary["userName"] as? String,
            let creationDate = dictionary["creationDate"] as? Date else { return nil }
        
        self.init(userName: userName, creationDate: creationDate)
    }
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

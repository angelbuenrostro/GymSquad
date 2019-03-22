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

struct Workout {
    var name: String
    var exercises: [Exercise]
    
    var dictionary: [String:Any] {
        return [
            "name": name,
            "exercises": exercises
        ]
    }
}

extension Workout: DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let name = dictionary["name"] as? String,
            let exercises = dictionary["exercises"] as? [Exercise] else { return nil }
        
        self.init(name: name, exercises: exercises)
        
    }
}

struct Exercise {
    var name: String
    var sets: [Int:Reps]
    var setCount: Int
    var restDuration: Int
    
    var dictionary: [String:Any] {
        return [
            "name": name,
            "sets": sets,
            "setCount": setCount,
            "restDuration": restDuration
        ]
    }
}

extension Exercise: DocumentSerializable {
    init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String,
        let sets = dictionary["sets"] as? [Int:Reps],
        let setCount = dictionary["setCount"] as? Int,
            let restDuration = dictionary["restDuration"] as? Int else { return nil }
        
        self.init(name:name, sets:sets, setCount:setCount, restDuration:restDuration)
    }
}

struct Reps {
    var count: Int
    var warmupSet: Bool
    var dropSet: Bool
    
    var dictionary: [String:Any] {
        return [
            "count": count,
            "warmupSet": warmupSet,
            "dropSet": dropSet
        ]
    }
}

extension Reps: DocumentSerializable {
    init?(dictionary: [String:Any]){
        guard let count = dictionary["count"] as? Int,
            let warmupSet = dictionary["warmupSet"] as? Bool,
            let dropSet = dictionary["dropSet"] as? Bool else { return nil }
        
        self.init(count:count, warmupSet:warmupSet, dropSet:dropSet)
    }
}

//struct Name {
//    var firstName: String
//    var lastName: String
//
//}

//struct Stats {
//    var age: String
//    var height: Double // Simply save in inches then do a calculation to feet later
//    var weight: Double
//}

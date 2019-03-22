//
//  Exercise.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore


struct Exercise {
    var name: String
    var sets: Int
    var reps: Int
    var restDuration: Int
    
    var dictionary: [String:Any] {
        return [
            "name": name,
            "sets": sets,
            "reps": reps,
            "restDuration": restDuration
        ]
    }
}

extension Exercise: DocumentSerializable {
    init?(dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String,
            let sets = dictionary["sets"] as? Int,
            let reps = dictionary["reps"] as? Int,
            let restDuration = dictionary["restDuration"] as? Int else { return nil }
        
        self.init(name:name, sets:sets, reps: reps, restDuration:restDuration)
    }
}

//struct Reps {
//    var count: Int
//    var warmupSet: Bool
//    var dropSet: Bool
//
//    var dictionary: [String:Any] {
//        return [
//            "count": count,
//            "warmupSet": warmupSet,
//            "dropSet": dropSet
//        ]
//    }
//}
//
//extension Reps: DocumentSerializable {
//    init?(dictionary: [String:Any]){
//        guard let count = dictionary["count"] as? Int,
//            let warmupSet = dictionary["warmupSet"] as? Bool,
//            let dropSet = dictionary["dropSet"] as? Bool else { return nil }
//        
//        self.init(count:count, warmupSet:warmupSet, dropSet:dropSet)
//    }
//}

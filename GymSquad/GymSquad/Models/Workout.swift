//
//  Workout.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//


import Foundation
import UIKit
import FirebaseFirestore


struct Workout {
    var name: String
    var exercises:[String: Any] // Going to be the name of the saved exercises
    
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
        let exercises = dictionary["exercises"] as? [String:Any] else { return nil }
        
        self.init(name: name, exercises: exercises)
        
    }
}


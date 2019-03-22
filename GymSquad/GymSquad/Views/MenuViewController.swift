//
//  MenuViewController.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add the background gradient
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "showMainScreen", sender: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

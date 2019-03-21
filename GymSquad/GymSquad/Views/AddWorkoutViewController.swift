//
//  AddWorkoutViewController.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddWorkoutViewController: UIViewController {
    
    var db: Firestore!
    var userArray: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var userNameTextField: UITextField!
    @IBAction func signInTapped(_ sender: Any) {
        if let phoneNumber = userNameTextField.text  {
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                
                // Create alert to have user enter in verification code
                let verificationAlert = UIAlertController(title: "Verify Phone Number", message: "Enter Verification Code", preferredStyle: .alert)
                
                verificationAlert.addTextField{ (textField) in
                    textField.placeholder = "Enter SMS code here"
                }
                
                verificationAlert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
                    // Receive verification code + ID
                    guard let verificationCode = verificationAlert.textFields![0].text else { return }
                    let credential = PhoneAuthProvider.provider().credential(
                        withVerificationID: verificationID!,
                        verificationCode: verificationCode)
                    
                    Auth.auth().signInAndRetrieveData(with: credential, completion: { (authResult, error) in
                        if let error = error {
                            print("error signing in:\(error.localizedDescription)")
                            return
                        }
                        
                        print("You have successfully signed in!")
                    })
                }))
                self.present(verificationAlert, animated: true)
            }
        }
    }
}

//
//  AddWorkoutTableViewController.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/22/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddWorkoutTableViewController: UITableViewController {
    
    var db: Firestore!
    var exercises: [Exercise] = []
    var exerciseNames: [String] = []
    var workoutName: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
//        tableView.backgroundView?.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        cell.textLabel!.text = exercises[indexPath.row].name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! MainCollectionViewController
        
        if segue.identifier == "workoutSavedSegue"{
            destinationVC.workoutName = workoutName
        }
    }
    
    
    func updateViews(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    func clearTextFields(){
        exerciseNameTextField.text = nil
        setsCountTextField.text = nil
        repsCountTextField.text = nil
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var setsCountTextField: UITextField!
    @IBOutlet weak var repsCountTextField: UITextField!
    @IBAction func addExerciseTapped(_ sender: Any) {
        
        guard let exerciseName = exerciseNameTextField.text,
            let setsCountString = setsCountTextField.text,
            let repsCountString = repsCountTextField.text else { return }
        let setsCount = Int(setsCountString)
        let repsCount = Int(repsCountString)
        
        let newExercise = Exercise(name: exerciseName,sets:setsCount!,reps:repsCount!,restDuration:60)
        
        exercises.append(newExercise)
        exerciseNames.append(newExercise.name)
        updateViews()
        clearTextFields()
        
    }
    @IBAction func saveWorkoutTapped(_ sender: Any) {
        guard let workoutName = workoutNameTextField.text else { return }
        var exerciseData: [String:Any] = [:]
        for exercise in exercises {
            exerciseData[exercise.name] = exercise.dictionary
        }
        let newWorkout = Workout(name: workoutName, exercises: exerciseData)
        let docData: [String: Any] = newWorkout.dictionary
        db.collection("workouts").document(workoutName).setData(docData) { error in
            if let error = error {
                print("Error saving workout:\(error.localizedDescription)")
            } else {
                print("Workout saved!")
                self.workoutName = workoutName
//                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "workoutSavedSegue", sender: self)
            }
        }
    }
    
}

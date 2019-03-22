//
//  MainCollectionViewController.swift
//  GymSquad
//
//  Created by Angel Buenrostro on 3/20/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit
import FirebaseFirestore

private let reuseIdentifier = "WorkoutCell"

class MainCollectionViewController: UICollectionViewController {
    
    var db: Firestore!
    var user: User?
    var exercises: [Exercise] = []
    var exerciseNames: [String]?
    var userArray: [User] = []
    var workoutName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundView?.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        
        workoutButton.isEnabled = false
        db = Firestore.firestore()
        if let workoutName = workoutName{
            workoutButton.setTitle(workoutName, for: .normal)
            workoutButton.isEnabled = true
            let workoutRef = self.db.collection("workouts").document(workoutName)
        
        workoutRef.getDocument { (document, error) in
            if let workout = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Workout(dictionary: data)
                })
            }) {
                let exerciseArray = workout.exercises
                for entry in exerciseArray{
                if let exercise = exerciseArray[entry.key] as? [String: Any] {
                    self.exercises.append(Exercise(dictionary: exercise)!)
                }
                }
                print("Exercise array: \(self.exercises)")
//                exerciseDictionary.flatMap({
//                    var newExercise = Exercise(dictionary: [$0.key:$0.value])
//                    self.exercises.append(newExercise!)
//                    print(newExercise)
//                })
                print("Workout: \(workout)")
            } else {
                print("Document does not exist!")
            }
        }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "showWorkoutTimer"{
            let destinationVC = segue.destination as! TimerViewController
            destinationVC.workoutName = self.workoutName
            destinationVC.exercises = self.exercises
        }
    }
  

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let kWhateverHeightYouWant = 150
        return CGSize(width: collectionView.bounds.size.width, height: CGFloat(kWhateverHeightYouWant))
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    @IBOutlet weak var workoutButton: RoundedWhiteButton!
    @IBAction func workoutButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "showWorkoutTimer", sender: self)
    }
}

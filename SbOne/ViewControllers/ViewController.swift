//
//  ViewController.swift
//  SbOne
//
//  Created by Burkay Atar on 13.02.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {

    private var db: Firestore!
    private var workout: WorkoutTypes?
    private var legWorkouts: WorkoutLeg?
    private var fetchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        db = Firestore.firestore()
        createFetchButton()
        
    }
    
    private func getWorkoutTypes(documentId: String) {
      let docRef = db.collection("Workout").document(documentId)
      
      docRef.getDocument(as: WorkoutTypes.self) { result in
        switch result {
        case .success(let workout):
          // A Book value was successfully initialized from the DocumentSnapshot.
          self.workout = workout
        case .failure(let error):
          // A Book value could not be initialized from the DocumentSnapshot.
          print( "Error decoding document: \(error.localizedDescription)")
        }
      }
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        getLegWorkoutInfo(documentId: "Workouts")
    }
    
    private func getLegWorkoutInfo(documentId: String) {
        let docRef = db.collection("Workout").document(documentId)
        
        docRef.getDocument(as: WorkoutLeg.self) { result in
            switch result {
            case .success(let legWorkouts):
                self.legWorkouts = legWorkouts
            case .failure(let error):
                print("Decoding error: \(error)")
            }
        }
    }
    
    private func createFetchButton() {
        fetchButton = UIButton(type: .system)
        view.addSubview(fetchButton)
        fetchButton.setTitle("Fetch Data", for: .normal)
        fetchButton.backgroundColor = .systemBlue
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.layer.cornerRadius = 10
        fetchButton.setTitleColor(.systemPink, for: .normal)
        fetchButton.setTitleColor(.systemBrown, for: .highlighted)
        fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fetchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        fetchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        fetchButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

}


//
//  HomeViewController.swift
//  SbOne
//
//  Created by Burkay Atar on 25.02.2024.
//

import UIKit

class HomeViewController: UIViewController {

    private var profileRowView: ProfileRowView = ProfileRowView()
    private var dailyActivityView: DailyActivityView = DailyActivityView()
    private var progressRingView = ProgressRingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        dailyActivityView.dailyActivityButtonDelegate = self
        profileRowView = ProfileRowView(profileImage: nil, userName: "Burkay Atar")
        configureViewController()
        HealthKitManager.shared.requestAuthorization { result in
            switch result {
            case .success(let bool):
                print("\(bool)")
            case .failure(let error):
                print(error)
            }
        }
        
        HealthKitManager.shared.retrieveDailyStepCount { data in
            if let customError = data.error {
                print("\(customError.errorDescription)")
            } else if data.stepCount == 0 {
                print("Data equals to 0")
            } else {
                print("Step count: \(data.stepCount)")
            }
        }
        
        HealthKitManager.shared.retrieveActivitySummary { double in
            print("summary: \(double)")
        }
        
    }
    
    private func configureViewController() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileRowView)
        view.addSubview(dailyActivityView)
        
        NSLayoutConstraint.activate([
            profileRowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profileRowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileRowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileRowView.heightAnchor.constraint(equalToConstant: 80),
            
            dailyActivityView.topAnchor.constraint(equalTo: profileRowView.bottomAnchor, constant: 20),
            dailyActivityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dailyActivityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dailyActivityView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
    }

}

extension HomeViewController: DailyActivityButtonDelegate {
    func dailyActivityButtonTapped() {
        let alertController = UIAlertController(title: "Info",
                                                message: "If one or more values in Daily Activity list is 0 please check if you give app the permisson to read your health data or if you have any available data for today.",
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

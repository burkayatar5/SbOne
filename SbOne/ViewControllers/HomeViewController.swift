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
        profileRowView = ProfileRowView(profileImage: nil, userName: "Burkay Atar")
        configureViewController()
        
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

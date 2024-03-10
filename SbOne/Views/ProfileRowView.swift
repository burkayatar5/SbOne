//
//  ProfileRowView.swift
//  SbOne
//
//  Created by Burkay Atar on 25.02.2024.
//

import UIKit

class ProfileRowView: UIView {

    private let profileImageView: UIImageView = UIImageView()
    private var userNameLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(profileImage: UIImage?, userName: String) {
        self.init(frame: .zero)
        configureProfileImageView(profileImage: profileImage)
        configureUserNameLabel(userName: userName)
        configureRowView()
    }
    
    private func configureProfileImageView(profileImage: UIImage?) {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        if let profileImage = profileImage {
            profileImageView.image = profileImage
        }
        
    }
    
    private func configureUserNameLabel(userName: String) {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userNameLabel)
        userNameLabel.textAlignment = .left
        userNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        userNameLabel.textColor = .systemYellow
        userNameLabel.text = userName
        userNameLabel.adjustsFontSizeToFitWidth = true
        userNameLabel.minimumScaleFactor = 0.9
        userNameLabel.lineBreakMode = .byTruncatingTail
    }
    
    private func configureRowView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemGroupedBackground
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            
            userNameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            userNameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

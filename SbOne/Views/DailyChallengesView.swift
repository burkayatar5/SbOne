//
//  DailyChallengesView.swift
//  SbOne
//
//  Created by Burkay Atar on 23.03.2024.
//

import UIKit

class DailyChallengesView: UIView {

    private var headerLabel: UILabel = UILabel()
    private var seeAllButton: UIButton = UIButton()
    private var contentView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainView()
        configureHeaderLabel()
        configureSeeAllButton()
        configureContentView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMainView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.backgroundColor = .clear
        headerLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        headerLabel.textAlignment = .left
        headerLabel.text = "Daily Challenges"
        
        addSubview(headerLabel)
    }
    
    private func configureSeeAllButton() {
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.setTitle("Title", for: .normal)
        addSubview(seeAllButton)
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 10
        addSubview(contentView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            seeAllButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 5),
            seeAllButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            contentView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    

}

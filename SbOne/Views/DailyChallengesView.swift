//
//  DailyChallengesView.swift
//  SbOne
//
//  Created by Burkay Atar on 23.03.2024.
//

import UIKit

class DailyChallengesView: DailyView {

    private var label: UILabel = UILabel()
    
    init(headerLabel: String, buttonType: InformationButtonType, buttonName: String, buttonTag: Int, labelText: String) {
        super.init(headerLabel: headerLabel, buttonType: buttonType, buttonName: buttonName, buttonTag: buttonTag)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = .cyan
        contentView.addSubview(label)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    

}

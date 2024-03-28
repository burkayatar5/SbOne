//
//  DailyView.swift
//  SbOne
//
//  Created by Burkay Atar on 25.03.2024.
//

import UIKit

//button tapped protocol
protocol DailyViewDelegate: AnyObject {
    func dailyViewButtonTapped(tag: Int)
}

class DailyView: UIView {

    var headerLabel: UILabel = UILabel()
    var informationButton = InformationButton()
    var contentView: UIView = UIView()
    
    weak var dailyViewDelegate: DailyViewDelegate?
    
    //MARK: - Initializers
    init(headerLabel: String, buttonType: InformationButtonType, buttonName: String, buttonTag: Int) {
        super.init(frame: .zero)
        configureMainView()
        configureHeaderLabel(headerText: headerLabel)
        configureInformationButton(buttonType: buttonType, buttonName: buttonName, buttonTag: buttonTag)
        configureContentView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    
    private func configureMainView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureHeaderLabel(headerText: String) {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        headerLabel.textAlignment = .left
        headerLabel.text = headerText
        
        addSubview(headerLabel)
    }
    
    private func configureInformationButton(buttonType: InformationButtonType, buttonName: String, buttonTag: Int) {
        informationButton = InformationButton(buttonType: buttonType, buttonName: buttonName, buttonTag: buttonTag)
        informationButton.informationButtonDelegate = self
        addSubview(informationButton)
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
            
            informationButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 5),
            informationButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            contentView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension DailyView: InformationButtonDelegate {
    func informativeButtonTapped(tag: Int) {
        dailyViewDelegate?.dailyViewButtonTapped(tag: informationButton.tag)
    }
}

//
//  DailyActivityView.swift
//  SbOne
//
//  Created by Burkay Atar on 25.02.2024.
//

import UIKit

class DailyActivityView: UIView {

    private var headerLabel: UILabel = UILabel()
    private var contentView: UIView = UIView()
    
    private var stackView: UIStackView = UIStackView()
    private var dailyCaloriesLabel: LabelWithDotView = LabelWithDotView(color: .systemGreen)
    private var dailyWorkoutLabel: LabelWithDotView = LabelWithDotView(color: .systemOrange)
    private var dailyStepsLabel: LabelWithDotView = LabelWithDotView(color: .systemRed)
    
    private var dailyActivityRing: ProgressRingView = ProgressRingView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainView()
        configureHeaderLabel()
        configureContentView()
        configureStackView()
        configureActivityRing()
        configureConstraints()
    }
    
    //dot rengi ile activityRing rengi uyuşmalı init'te bir renk al ve ikisine de ver
    //renkler için bir enum oluştur ve renkleri oraya ver oradan uygulama geneli kullanabilinsin dark mode uyumluluğu içinde kullanışlı
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMainView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.systemFont(ofSize: 21, weight: .heavy)
        headerLabel.textAlignment = .left
        headerLabel.text = "Daily Activities"
        
        addSubview(headerLabel)
    }
    
    private func configureContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 10
        
        addSubview(contentView)
    }
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .clear
        
        dailyCaloriesLabel.setExplanationLabelNameValue(explanationName: "Calories:", explanationValue: "100/600")
        dailyWorkoutLabel.setExplanationLabelNameValue(explanationName: "Workout:", explanationValue: "10/30")
        dailyStepsLabel.setExplanationLabelNameValue(explanationName: "Steps:", explanationValue: "1000/10000")
        
        dailyCaloriesLabel.backgroundColor = .clear
        dailyWorkoutLabel.backgroundColor = .clear
        dailyStepsLabel.backgroundColor = .clear
        
        stackView.addArrangedSubview(dailyCaloriesLabel)
        stackView.addArrangedSubview(dailyWorkoutLabel)
        stackView.addArrangedSubview(dailyStepsLabel)
        
        contentView.addSubview(stackView)
    }
    
    private func configureActivityRing() {
        dailyActivityRing.translatesAutoresizingMaskIntoConstraints = false
        dailyActivityRing.backgroundColor = .clear
        dailyActivityRing.setProgress(outerProgress: 0.25, middleProgress: 0.5, innerProgress: 0.75, animated: true)
        
        contentView.addSubview(dailyActivityRing)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            
            contentView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            dailyActivityRing.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dailyActivityRing.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            dailyActivityRing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dailyActivityRing.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        dailyCaloriesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: -10).isActive = true
        dailyWorkoutLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: -10).isActive = true
        dailyStepsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: -10).isActive = true
        
        dailyCaloriesLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        dailyWorkoutLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        dailyStepsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
}

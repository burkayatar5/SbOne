//
//  DailyActivityView.swift
//  SbOne
//
//  Created by Burkay Atar on 25.02.2024.
//

import UIKit

class DailyActivityView: DailyView {
    private var stackView: UIStackView = UIStackView()
    private var dailyCaloriesLabel: LabelWithDotView
    private var dailyWorkoutLabel: LabelWithDotView
    private var dailyStepsLabel: LabelWithDotView
    
    private var dailyActivityRing: ProgressRingView
    
    init(headerLabel: String, buttonType: InformationButtonType, buttonName: String, buttonTag: Int, caloriesColor: UIColor, workoutColor: UIColor, stepsColor: UIColor) {
        
        dailyCaloriesLabel = LabelWithDotView(color: caloriesColor)
        dailyWorkoutLabel = LabelWithDotView(color: workoutColor)
        dailyStepsLabel = LabelWithDotView(color: stepsColor)
        dailyActivityRing = ProgressRingView(outerRingColor: caloriesColor, middleRingColor: workoutColor, innerRingColor: stepsColor)
        
        super.init(headerLabel: headerLabel, buttonType: buttonType, buttonName: buttonName, buttonTag: buttonTag)
        
        configureStackView()
        configureActivityRing()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            dailyActivityRing.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dailyActivityRing.leadingAnchor.constraint(equalTo: stackView.trailingAnchor),
            dailyActivityRing.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dailyActivityRing.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            dailyCaloriesLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            dailyCaloriesLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            dailyWorkoutLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            dailyWorkoutLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            dailyStepsLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            dailyStepsLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
        
        dailyCaloriesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: 0).isActive = true
        dailyWorkoutLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: 0).isActive = true
        dailyStepsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: 0).isActive = true
        
        dailyCaloriesLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        dailyWorkoutLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        dailyStepsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3).isActive = true
        
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
    }
}

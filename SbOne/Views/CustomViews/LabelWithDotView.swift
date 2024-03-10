//
//  LabelWithDotView.swift
//  SbOne
//
//  Created by Burkay Atar on 5.03.2024.
//

import UIKit

class LabelWithDotView: UIView {

    private var dotLabel: UILabel = UILabel()
    private var explanationLabel: UILabel = UILabel()
    private var valueLabel: UILabel = UILabel()
    
    private let dotWidth: CGFloat = 10.0
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureDotLabel()
        configureExplanationLabel()
        configureValueLabel()
        configureConstraints()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        setColors(color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Configuration Methods
    
    private func configureView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        addSubview(dotLabel)
        addSubview(explanationLabel)
        addSubview(valueLabel)
    }
    
    private func configureDotLabel() {
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        //since label have intrinsic size just giving constraints and making it circle should work?
        dotLabel.layer.masksToBounds = true
        dotLabel.layer.cornerRadius = dotWidth / 2
    }
    
    private func configureExplanationLabel() {
        explanationLabel.translatesAutoresizingMaskIntoConstraints = false
        explanationLabel.backgroundColor = .clear
        explanationLabel.textAlignment = .left
        explanationLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        explanationLabel.textColor = .label
    }
    
    private func configureValueLabel() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.backgroundColor = .clear
        valueLabel.textAlignment = .left
        valueLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    private func configureConstraints() {
        explanationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            dotLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            dotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dotLabel.widthAnchor.constraint(equalToConstant: dotWidth),
            dotLabel.heightAnchor.constraint(equalTo: dotLabel.widthAnchor),
            
            explanationLabel.centerYAnchor.constraint(equalTo: dotLabel.centerYAnchor),
            explanationLabel.leadingAnchor.constraint(equalTo: dotLabel.trailingAnchor, constant: 3),
            
            valueLabel.centerYAnchor.constraint(equalTo: dotLabel.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: explanationLabel.trailingAnchor, constant: 3),
        ])
    }
    
    private func setColors(color: UIColor) {
        dotLabel.backgroundColor = color
        valueLabel.textColor = color
    }
    
    //MARK: - Public Methods
    
    public func setExplanationLabelNameValue(explanationName name: String, explanationValue value: String) {
        explanationLabel.text = name
        valueLabel.text = value
    }
    
}

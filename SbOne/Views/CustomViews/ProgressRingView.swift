//
//  ProgressRingView.swift
//  SbOne
//
//  Created by Burkay Atar on 29.02.2024.
//

import UIKit

// TODO: - Create a custom color enum for rings back and foreground colors and make it lighter and darker versions of same color

class ProgressRingView: UIView {

    private var outerRingView: RingView = RingView()
    private var middleRingView: RingView = RingView()
    private var innerRingView: RingView = RingView()
    
    private var outerRingColor: UIColor
    private var middleRingColor: UIColor
    private var innerRingColor: UIColor
    
    init(outerRingColor: UIColor, middleRingColor: UIColor, innerRingColor: UIColor) {
        self.outerRingColor = outerRingColor
        self.middleRingColor = middleRingColor
        self.innerRingColor = innerRingColor
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupRings(outerRingColor: self.outerRingColor, middleRingColor: self.middleRingColor, innerRingColor: self.innerRingColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRings(outerRingColor: self.outerRingColor, middleRingColor: self.middleRingColor, innerRingColor: self.innerRingColor)
    }
    
    private func setupRings(outerRingColor: UIColor, middleRingColor: UIColor, innerRingColor: UIColor) {
        let outerRingRadius = min(bounds.width, bounds.height) / 2.0
        let middleRingRadius = outerRingRadius * 0.75
        let innerRingRadius = outerRingRadius / 2.0
        
        // Outer Ring
        outerRingView.translatesAutoresizingMaskIntoConstraints = false
        outerRingView.frame = bounds
        outerRingView.radius = outerRingRadius
        outerRingView.backgroundRingColor = .systemGray2
        outerRingView.foregroundRingColor = outerRingColor
        outerRingView.ringWidth = 10.0
        addSubview(outerRingView)
        
        // Middle Ring
        middleRingView.translatesAutoresizingMaskIntoConstraints = false
        middleRingView.frame = bounds
        middleRingView.radius = middleRingRadius
        middleRingView.backgroundRingColor = .systemGray2
        middleRingView.foregroundRingColor = middleRingColor
        middleRingView.ringWidth = 10.0
        addSubview(middleRingView)
        
        // Inner Ring
        innerRingView.translatesAutoresizingMaskIntoConstraints = false
        innerRingView.frame = bounds
        innerRingView.radius = innerRingRadius
        innerRingView.backgroundRingColor = .systemGray2
        innerRingView.foregroundRingColor = innerRingColor
        innerRingView.ringWidth = 10.0
        addSubview(innerRingView)
    }
    
    func setProgress(outerProgress: CGFloat, middleProgress: CGFloat, innerProgress: CGFloat, animated: Bool) {
        outerRingView.setProgress(outerProgress, animated: animated)
        middleRingView.setProgress(middleProgress, animated: animated)
        innerRingView.setProgress(innerProgress, animated: animated)
    }
    
}

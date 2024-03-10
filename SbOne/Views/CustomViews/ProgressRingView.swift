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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupRings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRings()
    }
    
    private func setupRings() {
        let outerRingRadius = min(bounds.width, bounds.height) / 2.0
        let middleRingRadius = outerRingRadius * 0.75
        let innerRingRadius = outerRingRadius / 2.0
        
        // Outer Ring
        outerRingView.translatesAutoresizingMaskIntoConstraints = false
        outerRingView.frame = bounds
        outerRingView.radius = outerRingRadius
        outerRingView.backgroundRingColor = .systemGray2
        outerRingView.foregroundRingColor = .systemGreen
        outerRingView.ringWidth = 10.0
        addSubview(outerRingView)
        
        // Middle Ring
        middleRingView.translatesAutoresizingMaskIntoConstraints = false
        middleRingView.frame = bounds
        middleRingView.radius = middleRingRadius
        middleRingView.backgroundRingColor = .systemGray2
        middleRingView.foregroundRingColor = .systemBlue
        middleRingView.ringWidth = 10.0
        addSubview(middleRingView)
        
        // Inner Ring
        innerRingView.translatesAutoresizingMaskIntoConstraints = false
        innerRingView.frame = bounds
        innerRingView.radius = innerRingRadius
        innerRingView.backgroundRingColor = .systemGray2
        innerRingView.foregroundRingColor = .systemRed
        innerRingView.ringWidth = 10.0
        addSubview(innerRingView)
    }
    
    func setProgress(outerProgress: CGFloat, middleProgress: CGFloat, innerProgress: CGFloat, animated: Bool) {
        outerRingView.setProgress(outerProgress, animated: animated)
        middleRingView.setProgress(middleProgress, animated: animated)
        innerRingView.setProgress(innerProgress, animated: animated)
    }
    
}

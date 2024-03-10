//
//  RingView.swift
//  SbOne
//
//  Created by Burkay Atar on 27.02.2024.
//

import UIKit

class RingView: UIView {
    
    private var backgroundRingLayer: CAShapeLayer!
    private var foregroundRingLayer: CAShapeLayer!
    
    var backgroundRingColor: UIColor = .systemGray2 {
        didSet {
            backgroundRingLayer.strokeColor = backgroundRingColor.cgColor
        }
    }
    
    var foregroundRingColor: UIColor = .systemGreen {
        didSet {
            foregroundRingLayer.strokeColor = foregroundRingColor.cgColor
        }
    }
    
    var ringWidth: CGFloat = 10.0 {
        didSet {
            backgroundRingLayer.lineWidth = ringWidth
            foregroundRingLayer.lineWidth = ringWidth
        }
    }
    
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var radius: CGFloat = 100 {
        didSet {
            setNeedsLayout()
        }
    }
    
    let startAngle: CGFloat = -.pi / 2
    let fullCircleAngle: CGFloat = 2 * .pi
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupRingView()
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, backgroundRingColor: UIColor, foregroundRingColor: UIColor) {
        super.init(frame: frame)
        self.backgroundRingColor = backgroundRingColor
        self.foregroundRingColor = foregroundRingColor
        backgroundColor = .clear
        setupRingView()
        setupLayers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        // Background Ring Path
        let backgroundRingPath = UIBezierPath(arcCenter: center,
                                              radius: radius,
                                              startAngle: startAngle,
                                              endAngle: fullCircleAngle,
                                              clockwise: true)
        backgroundRingLayer.path = backgroundRingPath.cgPath
        
        // Foreground Ring Path
        let endAngle = startAngle + fullCircleAngle * progress
        let foregroundRingPath = UIBezierPath(arcCenter: center,
                                              radius: radius,
                                              startAngle: startAngle,
                                              endAngle: endAngle ,
                                              clockwise: true)
        foregroundRingLayer.path = foregroundRingPath.cgPath
    }
    
    private func setupRingView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayers() {
        // Background Ring Layer
        backgroundRingLayer = createRingLayer(color: UIColor.lightGray)
        layer.addSublayer(backgroundRingLayer)
        
        //Foreground Ring Layer
        foregroundRingLayer = createRingLayer(color: UIColor.green)
        layer.addSublayer(foregroundRingLayer)
    }
    
    private func createRingLayer(color: UIColor) -> CAShapeLayer {
        let ringLayer = CAShapeLayer()
        ringLayer.fillColor = UIColor.clear.cgColor
        ringLayer.strokeColor = color.cgColor
        ringLayer.lineWidth = ringWidth
        ringLayer.lineCap = .round
        return ringLayer
    }
    
    /// Fill the foreground ring layer according to new progress value
    /// - Parameters:
    ///   - newProgress: percentege value for ring to fill
    ///   - animated: determine if filling process will be animated
    func setProgress(_ newProgress: CGFloat, animated: Bool) {
        guard newProgress >= 0.0 && newProgress <= 1.0 else {
            return
        }
        
        if animated {
            // Animate the progress change
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progress
            animation.toValue = newProgress
            animation.duration = 1.0 // You can adjust the animation duration
            foregroundRingLayer.add(animation, forKey: "animateProgress")
        }
        
        progress = newProgress
        setNeedsLayout()
    }
}

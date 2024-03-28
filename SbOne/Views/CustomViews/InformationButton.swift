//
//  InformationButton.swift
//  SbOne
//
//  Created by Burkay Atar on 18.03.2024.
//

import UIKit

enum InformationButtonType {
    case image
    case words
}

protocol InformationButtonDelegate {
    func informativeButtonTapped(tag: Int)
}

class InformationButton: UIButton {
    
    var informationButtonDelegate: InformationButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(buttonType: InformationButtonType, buttonName: String, buttonTag: Int) {
        self.init(frame: .zero)
        configureButton(buttonType: buttonType, buttonName: buttonName, buttonTag: buttonTag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(buttonType: InformationButtonType, buttonName: String, buttonTag: Int) {
        translatesAutoresizingMaskIntoConstraints = false
        //Button Config
        var config = UIButton.Configuration.plain()
        if buttonType == .image {
            config.image = UIImage(systemName: buttonName) //"info.circle"
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .large)
        } else if buttonType == .words {
            
        }
        config.contentInsets = .zero
        self.configuration = config
        
        
        self.configurationUpdateHandler = { [weak self] _ in
            guard let self = self else { return }
            
            var config = self.configuration
            config?.imageColorTransformer = UIConfigurationColorTransformer { _ in
                switch self.state {
                case .highlighted:
                    return UIColor.systemGray3
                default:
                    return UIColor.systemOrange
                }
            }
            self.configuration = config
        }
        self.tag = buttonTag
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        informationButtonDelegate?.informativeButtonTapped(tag: self.tag)
    }
}

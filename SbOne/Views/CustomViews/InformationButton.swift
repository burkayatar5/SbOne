//
//  InformationButton.swift
//  SbOne
//
//  Created by Burkay Atar on 18.03.2024.
//

import UIKit

protocol InformationButtonDelegate {
    func informativeButtonTapped()
}

class InformationButton: UIButton {
    
    var informationButtonDelegate: InformationButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        //Button Config
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "info.circle")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium, scale: .large)
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
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        informationButtonDelegate?.informativeButtonTapped()
    }
}

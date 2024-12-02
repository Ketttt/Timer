//
//  CongratsView.swift
//  Timer
//
//  Created by Katerina Dev on 21.11.24.
//

import UIKit

final class CongratsView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(resource: .сonfetti)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    private let congratsTitle: UILabel = {
        let label = UILabel()
        label.text = "CONGRATS!"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .titleColor
        return label
    }()
    
    private let imageView = TrophyView(
        frame: .zero,
        cornerRadius: 25.0,
        imageSize: CGSize.init(width: 35, height: 35))
    
    private let text: UILabel = {
        let label = UILabel()
        label.text = "You have done a great job. Keep it up!"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .textColor
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
        self.frame = backgroundImageView.bounds
    }
    
    private func setup() {
        self.backgroundColor = #colorLiteral(red: 0.2217641175, green: 0.2519164979, blue: 0.2728238702, alpha: 1)
        self.addSubview(backgroundImageView)
        self.addSubview(imageView)
        self.addSubview(congratsTitle)
        self.addSubview(text)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        congratsTitle.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 98),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            congratsTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            congratsTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.topAnchor.constraint(equalTo: congratsTitle.bottomAnchor, constant: 10),
            
            text.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            text.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            text.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            text.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

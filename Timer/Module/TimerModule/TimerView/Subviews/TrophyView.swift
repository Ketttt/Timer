//
//  TrophyView.swift
//  Timer
//
//  Created by Katerina Dev on 21.11.24.
//

import UIKit

final class TrophyView: UIView {
    
    let imageView = UIImageView(image: .trophy)
    let backgroundColorView = UIView()
    
    init(frame: CGRect, cornerRadius: CGFloat, imageSize: CGSize) {
        super.init(frame: frame)
        setup(cornerRadius: cornerRadius, imageSize: imageSize)
    }
    
    private func setup(cornerRadius: CGFloat, imageSize: CGSize) {
        self.addSubview(backgroundColorView)
        self.addSubview(imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColorView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColorView.backgroundColor = .secondColor
        backgroundColorView.layer.cornerRadius = cornerRadius
        imageView.frame = backgroundColorView.bounds
        
        NSLayoutConstraint.activate([
            backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: backgroundColorView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backgroundColorView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

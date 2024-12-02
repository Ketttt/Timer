//
//  RewardCollectionViewCell.swift
//  Timer
//
//  Created by Katerina Dev on 20.11.24.
//

import UIKit

final class RewardCollectionViewCell: UICollectionViewCell {
    
    private let trophyView = TrophyView(
        frame: .zero,
        cornerRadius: 50.0,
        imageSize: CGSize.init(width: 50, height: 50))
    
    func setRewards(rewards: UIImage) {
//        self.awardView.//image = rewards
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        self.trophyView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(trophyView)
        
        NSLayoutConstraint.activate([
            trophyView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            trophyView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            trophyView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            trophyView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("RewardCollectionViewCell has not been implemented")
    }
}

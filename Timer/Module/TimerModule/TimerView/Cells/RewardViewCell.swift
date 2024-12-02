//
//  RewardViewCell.swift
//  Timer
//
//  Created by Katerina Dev on 20.11.24.
//

import UIKit

protocol RewardViewCellDelegate: AnyObject {
    func scrollToLastItem()
}

final class RewardViewCell: UITableViewCell, RewardViewCellDelegate {
    
    var rewards: [UIImage]? {
        didSet {
            rewardsCollectionView.reloadData()
        }
    }
    
    lazy var rewardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RewardCollectionViewCell.self, forCellWithReuseIdentifier: "RewardCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        return collectionView
        
    }()
    
    private let collectionTitle: UILabel = {
        let label = UILabel()
        label.text = "Your Rewards"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .titleColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func scrollToLastItem() {
        guard let rewards = rewards, !rewards.isEmpty else { return }
        let lastIndex = IndexPath(item: rewards.count - 1, section: 0)
        rewardsCollectionView.scrollToItem(at: lastIndex, at: .right, animated: true)
        self.rewardsCollectionView.reloadData()
    }
    
    func setRewards(_ rewards: [UIImage]) {
        self.rewards = rewards
        guard !rewards.isEmpty else { return }
        self.rewardsCollectionView.reloadData()
    }
    
    private func setup() {
        self.backgroundColor = .baseBg
        contentView.addSubview(rewardsCollectionView)
        contentView.addSubview(collectionTitle)
        rewardsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionTitle.translatesAutoresizingMaskIntoConstraints = false
        rewardsCollectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 30),
            collectionTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            collectionTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            
            rewardsCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            rewardsCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            rewardsCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            rewardsCollectionView.heightAnchor.constraint(equalToConstant: 100),
            rewardsCollectionView.topAnchor.constraint(equalTo: collectionTitle.bottomAnchor, constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("RewardViewCell has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource
extension RewardViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rewardsCount = rewards?.count else { return 0 }
        return rewardsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardCollectionViewCell", for: indexPath) as? RewardCollectionViewCell else { return UICollectionViewCell() }
        guard let reward = rewards?[indexPath.row] else { return cell }
        cell.setRewards(rewards: reward)
        return cell
    }
}

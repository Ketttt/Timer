//
//  ExerciseTableViewCell.swift
//  Timer
//
//  Created by Katerina Dev on 2.11.24.
//

import UIKit

final class ExerciseTableViewCell: UITableViewCell {
    
    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .titleColor
        label.text = "Plank"
        return label
    }()
    
    private var timing: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .textColor
        label.text = "(1 minute)"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .textColor
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.text = "Planks work to strengthen your core, meaning you'll see improvements with your posture as well as being able to see improvement with back pain if you have it."
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .baseBg
        self.backgroundColor = .green
        setUp()
        
        setupRoundedCorners()
    }
    
    private func setupRoundedCorners() {
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 20
        contentView.layer.zPosition = 1
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setUp() {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
        title.translatesAutoresizingMaskIntoConstraints = false
        timing.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(title)
        self.contentView.addSubview(timing)
        self.contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            
            timing.centerYAnchor.constraint(equalTo: title.centerYAnchor, constant: 2),
            timing.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 25),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 50),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ViewController.swift
//  Timer
//
//  Created by Katerina Dev on 2.11.24.
//

import UIKit

final class TimerViewController: UIViewController {
    weak var delegate: RewardViewCellDelegate?
    private var tableView = UITableView()
    private let headerImageView = UIImageView()
    private let headerHeight: CGFloat = 300
    private var rewardView = CongratsView()
    private var rewards: [UIImage] = [.trophy, .trophy]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeader()
        self.view.backgroundColor = .baseBg
    }
    
    private var dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func showItem() {
        // Добавляем затемнение
        dimmingView.frame = view.bounds
        view.addSubview(dimmingView)
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }

        // Добавляем rewardView
        let rewardView = self.rewardView
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rewardView)
        
        // Начальные размеры и позиция
        let initialSize: CGFloat = 100
        let finalSize: CGFloat = 200

        var topConstraint: NSLayoutConstraint!
        var leadingConstraint: NSLayoutConstraint!
        var sizeConstraint: NSLayoutConstraint!
        
        // Установка начальных ограничений
        topConstraint = rewardView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        leadingConstraint = rewardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        sizeConstraint = rewardView.widthAnchor.constraint(equalToConstant: initialSize)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            sizeConstraint,
            rewardView.heightAnchor.constraint(equalTo: rewardView.widthAnchor)
        ])
        
        // Анимация
        UIView.animate(withDuration: 1.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [], animations: {
            // Отключаем начальные ограничения
            NSLayoutConstraint.deactivate([topConstraint, leadingConstraint])
            
            // Устанавливаем новые ограничения
            NSLayoutConstraint.activate([
                rewardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                rewardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
            // Обновляем размеры
            sizeConstraint.constant = finalSize
            rewardView.layer.cornerRadius = 24

            self.view.layoutIfNeeded()
        }, completion: { _ in
            // Убираем rewardView и затемнение
            UIView.animate(withDuration: 1.0, animations: {
                self.rewardView.removeFromSuperview()
                self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            }, completion: { _ in
                self.dimmingView.removeFromSuperview()
            })

            // Добавляем награду в таблицу
            self.rewards.append(.trophy)
            self.tableView.reloadData()
            self.tableView.scrollToBottom()
            self.delegate?.scrollToLastItem()
        })
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "ExerciseTableViewCell")
        tableView.register(TimerViewCell.self, forCellReuseIdentifier: "TimerViewCell")
        tableView.register(RewardViewCell.self, forCellReuseIdentifier: "RewardViewCell")
        view.addSubview(tableView)
        tableView.backgroundColor = .baseBg
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
    }
    
    private func setupHeader() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: headerHeight))
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.clipsToBounds = true
        headerImageView.frame = headerView.bounds
        headerImageView.image = UIImage(resource: .plank)
        headerView.addSubview(headerImageView)
        tableView.tableHeaderView = headerView
        tableView.tableHeaderView?.layer.masksToBounds = false
        tableView.tableHeaderView?.layer.zPosition = -1
    }
}

// MARK: - UITableViewDataSource
extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerViewCell", for: indexPath) as? TimerViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RewardViewCell", for: indexPath) as? RewardViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setRewards(rewards)
            self.delegate = cell
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension TimerViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let _ = tableView.tableHeaderView else { return }
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            headerImageView.frame = CGRect(x: offsetY / 2,
                                           y: offsetY,
                                           width: view.frame.width - offsetY,
                                           height: headerHeight - offsetY)
        }
    }
}

//MARK: - TimerViewCellDelegate
extension TimerViewController: TimerViewCellDelegate {
    func timerDidFinish() {
        showItem()
    }
}


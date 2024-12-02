//
//  TimerViewCell.swift
//  Timer
//
//  Created by Katerina Dev on 2.11.24.
//

import UIKit

protocol TimerViewCellDelegate: AnyObject {
    func timerDidFinish()
}

final class TimerViewCell: UITableViewCell {
    
    weak var delegate: TimerViewCellDelegate?
    var timer: Timer?
    let shapeLayer = CAShapeLayer()
    var durationTimer = 3
    var isTimerRunning = false
    var pausedTime: CFTimeInterval = 0
    
    private var circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .circle)
        return imageView
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.titleColor, for: .normal)
        button.buttonStyle()
        return button
    }()
    
    private var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("RESET", for: .normal)
        button.setTitleColor(.titleColor, for: .normal)
        button.buttonStyle()
        return button
    }()
    
    private var timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = .titleColor
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .baseBg
        setUp()
        timerLabel.text = timeString(time: durationTimer)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
        animationCircular()
    }
    
    @objc func startButtonTapped() {
        animateButton(button: startButton)
        if isTimerRunning {
            timer?.invalidate()
            pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
            shapeLayer.speed = 0
            shapeLayer.timeOffset = pausedTime
            isTimerRunning = false
            startButton.setTitle("RESUME", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
        } else {
            if pausedTime == 0 {
                basicAnimation()
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            } else {
                let pausedDuration = CACurrentMediaTime() - pausedTime
                shapeLayer.speed = 1
                shapeLayer.timeOffset = 0
                shapeLayer.beginTime = pausedDuration
                pausedTime = 0
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            isTimerRunning = true
            startButton.setTitle("STOP", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
            RunLoop.main.add(timer ?? Timer(), forMode: .common)
        }
    }
    
    @objc func resetButtonTapped() {
        animateButton(button: resetButton)
        timer?.invalidate()
        durationTimer = 3
        timerLabel.text = timeString(time: durationTimer)
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.beginTime = 0
        shapeLayer.removeAllAnimations()
        pausedTime = 0
        isTimerRunning = false
        startButton.setTitle("START", for: .normal)
    }
    
    func animateButton(button: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
            button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.1) {
                button.transform = CGAffineTransform.identity
            }
        })
    }
    
    @objc func timerAction() {
        durationTimer -= 1
        timerLabel.text = timeString(time: durationTimer)
        
        if durationTimer == 0 {
            timer?.invalidate()
            durationTimer = 3
            timerLabel.text = timeString(time: durationTimer)
            startButton.setTitle("START", for: .normal)
            isTimerRunning = false
            delegate?.timerDidFinish()
        }
    }
    
    func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = true
        DispatchQueue.main.async { [weak self] in
            self?.shapeLayer.add(basicAnimation, forKey: "basicAnimation")
        }
    }
    
    func timeString(time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func animationCircular() {
        let center = CGPoint(x: circleImageView.frame.width / 2, y: circleImageView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let circularPath = UIBezierPath(arcCenter: center, radius: 89.4, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        shapeLayer.path  = circularPath.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.secondColor.cgColor
        circleImageView.layer.addSublayer(shapeLayer)
    }
    
    //MARK: - Constraints
    func setUp() {
        
        circleImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(circleImageView)
        self.contentView.addSubview(startButton)
        self.contentView.addSubview(resetButton)
        self.contentView.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            circleImageView.heightAnchor.constraint(equalToConstant: 188),
            circleImageView.widthAnchor.constraint(equalToConstant: 188),
            circleImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            circleImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            timerLabel.centerYAnchor.constraint(equalTo: circleImageView.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: circleImageView.centerXAnchor),
            
            resetButton.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 18),
            resetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            
            startButton.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 18),
            startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

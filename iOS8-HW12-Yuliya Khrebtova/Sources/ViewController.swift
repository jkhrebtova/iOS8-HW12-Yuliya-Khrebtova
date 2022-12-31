//
//  ViewController.swift
//  iOS8-HW12-Yuliya Khrebtova
//
//  Created by Julia on 24.12.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    private var timer: Timer = Timer()
    private var count = 0.0
    private var isStarted = false
    private var isWorkTime = true
    private var isStartButtonPressed = false
    private let workTime = 25.0
    private let restTime = 10.0
    private let progressBarSize = 300.0

    // MARK: - Outlets
    private let backgroundLayer = CAShapeLayer()
    private let shapeLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)

    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Pomodoro timer"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "play.fill", withConfiguration: configSymbol)
        button.setImage(image, for: .normal)
        button.tintColor = .systemMint
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = workTime.minuteSecondMS
        timeLabel.textAlignment = .center
        timeLabel.textColor = .systemMint
        timeLabel.font = .systemFont(ofSize: 40, weight: .regular)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()

    private lazy var progressBarView: UIView = {
        let progressBarView = UIView()
        progressBarView.translatesAutoresizingMaskIntoConstraints = false
        return progressBarView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setupHierarchy()
        setupLayout()

        countWorkingTime()
    }

    // MARK: - Setup
    private func setBackgroundColor() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(progressBarView)
        view.addSubview(button)
        view.addSubview(timeLabel)
        backgroundCircular()
        animationCircular(startGradientColor: .systemMint, endGradientColor: .cyan)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),

            progressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBarView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressBarView.heightAnchor.constraint(equalToConstant: progressBarSize),
            progressBarView.widthAnchor.constraint(equalToConstant: progressBarSize),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 50),

            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func countWorkingTime() {
        count = workTime
    }

    // MARK: - Actions

    @objc private func pressedButton() {
        let playImage = UIImage(systemName: "play.fill", withConfiguration: configSymbol)
        let pauseImage = UIImage(systemName: "pause.fill", withConfiguration: configSymbol)

        isStartButtonPressed = !isStartButtonPressed
        if isStartButtonPressed {
            timer.invalidate()

            if !isStarted {
                progressBarAnimation()
                isStarted = true
            }

            shapeLayer.resumeAnimation()
            button.setImage(pauseImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.001,
                                         target: self,
                                         selector: #selector(timerAction),
                                         userInfo: nil,
                                         repeats: true)
        } else {
            timer.invalidate()
            shapeLayer.pauseAnimation()
            button.setImage(playImage, for: .normal)
            }
    }

    func runningTime() {
        if isWorkTime {
            count -= timer.timeInterval
        } else if !isWorkTime {
            count -= timer.timeInterval
        }
    }

    @objc func timerAction(timer: Timer) {
        let pauseImage = UIImage(systemName: "pause.fill", withConfiguration: configSymbol)

        let timeString = count.minuteSecondMS
        timeLabel.text = timeString

        runningTime()

        if count <= 0 && isWorkTime {
            timer.invalidate()
            isStartButtonPressed = false
            isWorkTime = false
            isStarted = false
            count = restTime
            timeLabel.text = count.minuteSecondMS
            timeLabel.textColor = .yellow
            button.tintColor = .yellow
            animationCircular(startGradientColor: .yellow, endGradientColor: .orange)
            button.setImage(pauseImage, for: .normal)
        } else if count <= 0 && !isWorkTime {
            timer.invalidate()
            isStartButtonPressed = false
            isWorkTime = true
            isStarted = false
            count = workTime
            timeLabel.text = count.minuteSecondMS
            timeLabel.textColor = .systemMint
            button.tintColor = .systemMint
            animationCircular(startGradientColor: .systemMint, endGradientColor: .cyan)
            button.setImage(pauseImage, for: .normal)
        }
    }

    func animationCircular(startGradientColor: UIColor, endGradientColor: UIColor) {
        let width = progressBarSize
        let height = progressBarSize

        let lineWidth = 0.05 * min(width, height)

        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round

        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: progressBarSize, height: progressBarSize)
        gradientLayer.mask = shapeLayer

        progressBarView.layer.addSublayer(gradientLayer)
    }

    func backgroundCircular() {
        let width = progressBarSize
        let height = progressBarSize

        let lineWidth = 0.05 * min(width, height)

        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)

        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.strokeEnd = 1
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        progressBarView.layer.addSublayer(backgroundLayer)
    }

    func progressBarAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeStart")
        circularProgressAnimation.duration = CFTimeInterval(count)
        circularProgressAnimation.toValue = 1
        circularProgressAnimation.fillMode = CAMediaTimingFillMode.forwards
        circularProgressAnimation.isRemovedOnCompletion = true
        shapeLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }
}



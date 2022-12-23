//
//  ViewController.swift
//  iOS8-HW12-Yuliya Khrebtova
//
//  Created by Julia on 24.12.2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

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
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.setImage(UIImage(named: "pause"), for: .highlighted)
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        setupHierarchy()
        setupLayout()
    }

    // MARK: - Setup

    private func setBackgroundColor() {
        view.backgroundColor = .black
    }

    private func setupHierarchy() {
        view.addSubview(label)
        view.addSubview(button)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 50)
        ])

    }

    // MARK: - Actions

    @objc private func pressedButton() {

    }
}

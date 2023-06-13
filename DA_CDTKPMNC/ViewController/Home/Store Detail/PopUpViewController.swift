//
//  PopUpViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/25/23.
//

import UIKit

class PopUpViewController: UIViewController {
    
    enum Game {
        case gameLuckyWhell
        case gameDicee
    }
    
    let typeGame: Game
    
    init(typeGame: Game) {
        self.typeGame = typeGame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dismissActionHandler: (() -> Void)? = nil
    
    var playGameActionHandler: (() -> Void)? = nil
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitle("Play", for: .normal)
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.addTarget(self, action: #selector(playGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dismissButton, playButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addShadow()
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        view.addSubview(containerView)
        
        containerView.addSubview(gameImageView)
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        gameImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(270)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(gameImageView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        switch typeGame {
            
        case .gameDicee:
            gameImageView.image = UIImage(named: "game1")
            
        case .gameLuckyWhell:
            gameImageView.image = UIImage(named: "game2")
        }
    }
    
    @objc private func dismissButtonTapped() {
        dismissActionHandler?()
    }
    
    @objc private func playGameButtonTapped() {
        playGameActionHandler?()
    }
}

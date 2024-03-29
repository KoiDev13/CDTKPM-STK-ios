//
//  DiceeGameViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import UIKit

class DiceeGameViewController: UIViewController {
    
    let diceArray = [
        UIImage(named: "DiceOne"),
        UIImage(named: "DiceTwo"),
        UIImage(named: "DiceThree"),
        UIImage(named: "DiceFour"),
        UIImage(named: "DiceFive"),
        UIImage(named: "DiceSix")
    ]
    
    enum DiceeGameType {
        
        case tai
        case xiu
        case _none
    }
    
    var campaignID = ""
    
    var selectedDiceeGame: DiceeGameType = ._none
    
    var timer: Timer?
    
    private lazy var buttonTai: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Tài", for: .normal)
        button.addTarget(self, action: #selector(buttonTaiTapped), for: .touchUpInside)
        button.setTitleColor(.systemPink, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var buttonXiu: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Xỉu", for: .normal)
        button.setTitleColor(.systemPink, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonXiuTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background_game_dicee")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var product1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var product2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var product3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [product1ImageView, product2ImageView, product3ImageView])
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var signupButton: SecondaryButton = {
        let button = SecondaryButton()
        button.configure("Lắc",
                         backgroundColor: .systemPink,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: .clear,
                         titleColor: .white)
        button.addTarget(self,
                         action: #selector(onClickToLoginButton),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        view.addSubview(backgroundImageView)
        
        view.addSubview(stackView)
        
//        backgroundImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(80)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        view.addSubview(buttonTai)
        buttonTai.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.bottom.equalTo(signupButton.snp.top).offset(-18)
        }
        
        view.addSubview(buttonXiu)
        buttonXiu.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.bottom.equalTo(signupButton.snp.top).offset(-18)
        }
        
        let random1 = Int.random(in: 0...5)
        product1ImageView.image = diceArray[random1]
        
        let random2 = Int.random(in: 0...5)
        product2ImageView.image = diceArray[random2]
        
        
        let random3 = Int.random(in: 0...5)
        product3ImageView.image = diceArray[random3]
    }
    
    @objc func buttonTaiTapped() {
        // Đặt màu nền của nút "Tài" khi được chọn
        buttonTai.backgroundColor = UIColor.systemPink
        buttonTai.setTitleColor(.white, for: .normal)
        selectedDiceeGame = .tai
        
        // Đặt màu nền mặc định cho nút "Xỉu"
        buttonXiu.backgroundColor = UIColor.white
        buttonXiu.setTitleColor(.systemPink, for: .normal)
    }
    
    @objc func buttonXiuTapped() {
        // Đặt màu nền của nút "Xỉu" khi được chọn
        selectedDiceeGame = .xiu
        buttonXiu.backgroundColor = UIColor.systemPink
        buttonXiu.setTitleColor(.white, for: .normal)
        
        // Đặt màu nền mặc định cho nút "Tài"
        buttonTai.backgroundColor = UIColor.white
        buttonTai.setTitleColor(.systemPink, for: .normal)
    }
    
    private func getDiceeGame(isTai: Bool) {
        
        NetworkManager.shared.getGameOverUnder(userIsOver: isTai, campaignID: campaignID) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
//            self.timer?.invalidate()
            
            switch result {
                
            case .success(let response):
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.timer?.invalidate()
                    let isTai = response.data?.gameData?.gameIsOver ?? false
                    
                    if isTai {
                        self.buttonTai.layer.borderWidth = 1
                        self.buttonTai.layer.borderColor = UIColor.green.cgColor
                    } else {
                        
                        self.buttonXiu.layer.borderWidth = 1
                        self.buttonXiu.layer.borderColor = UIColor.green.cgColor
                    }
                    
                
                    self.product1ImageView.image = self.diceArray[(response.data?.gameData?.dices?.dice1 ?? 0) - 1]
                    self.product2ImageView.image = self.diceArray[(response.data?.gameData?.dices?.dice2 ?? 0) - 1]
                    self.product3ImageView.image = self.diceArray[(response.data?.gameData?.dices?.dice3 ?? 0) - 1]
                    
                    let isWin = response.data?.isWinner ?? false
                    
                    if isWin {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showMessage(response.data?.voucher?.voucherName ?? "", title: "Thông báo") {
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }
                        
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showMessage("Chúc bạn may mắn lần sau", title: "Thông báo") {
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }

                    }
                }
                
                
                
            case .failure(let error):
                self.timer?.invalidate()
                self.showAlert(error.localizedDescription)
            }
            
        }
    }
    
    
    
    @objc private func onClickToLoginButton() {
        
        
        
        switch selectedDiceeGame {
            
        case .tai:
            getDiceeGame(isTai: true)
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                DispatchQueue.main.async {

                    let random1 = Int.random(in: 0...5)
                    self.product1ImageView.image = self.diceArray[random1]

                    let random2 = Int.random(in: 0...5)
                    self.product2ImageView.image = self.diceArray[random2]


                    let random3 = Int.random(in: 0...5)
                    self.product3ImageView.image = self.diceArray[random3]
                }
            }
            
        case .xiu:
            getDiceeGame(isTai: false)
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                DispatchQueue.main.async {

                    let random1 = Int.random(in: 0...5)
                    self.product1ImageView.image = self.diceArray[random1]

                    let random2 = Int.random(in: 0...5)
                    self.product2ImageView.image = self.diceArray[random2]


                    let random3 = Int.random(in: 0...5)
                    self.product3ImageView.image = self.diceArray[random3]
                }
            }
            
        case ._none:
            showMessage("Hãy đặt cược", title: "Thông báo")
        }
        
        
        
        
    }
}

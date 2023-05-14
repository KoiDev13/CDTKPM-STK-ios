//
//  DiceeGameViewController.swift
//  DA_CDTKPMNC
//
//  Created by Hoang Son Vo Phuoc on 5/14/23.
//

import UIKit

class DiceeGameViewController: UIViewController {
    
    let diceArray = [UIImage(named: "DiceOne"), UIImage(named: "DiceTwo"), UIImage(named: "DiceThree"), UIImage(named: "DiceFour"), UIImage(named: "DiceFive"), UIImage(named: "DiceSix")]
    
    
    private lazy var product1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var product2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private lazy var product3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
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
        button.configure("Roll",
                         backgroundColor: .clear,
                         font: UIFont.systemFont(ofSize: 16),
                         borderColor: UIColor.App.secondaryOnDarkBlue,
                         titleColor: UIColor.App.primaryOnDarkBlue)
        button.addTarget(self,
                         action: #selector(onClickToLoginButton),
                         for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(60)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(signupButton)
        signupButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(18)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        let random1 = Int.random(in: 0...5)
        product1ImageView.image = diceArray[random1]
        
        let random2 = Int.random(in: 0...5)
        product2ImageView.image = diceArray[random2]
        
        
        let random3 = Int.random(in: 0...5)
        product3ImageView.image = diceArray[random3]
    }
    
    
    @objc private func onClickToLoginButton() {

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                DispatchQueue.main.async {
                    
                    let random1 = Int.random(in: 0...5)
                    self.product1ImageView.image = self.diceArray[random1]
                    
                    let random2 = Int.random(in: 0...5)
                    self.product2ImageView.image = self.diceArray[random2]
                    
                    
                    let random3 = Int.random(in: 0...5)
                    self.product3ImageView.image = self.diceArray[random3]
                }
            }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

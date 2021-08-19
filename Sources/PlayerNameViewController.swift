import Foundation
import UIKit

public class PlayerNameViewController: UIViewController {
    var companionName:String?
    var playerNameString:String?
    let companionMessage = UILabel()
    let playerNameInput = UITextField()
    let companionImage = UIImageView(frame: CGRect(x: 20, y: 30, width: 100, height: 100))
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        playerName()
    }
    
    func playerName() {
        companionImage.image = UIImage(named: "Image/\(companionName!) - Speaking")
        self.view.addSubview(companionImage)
        
        companionMessage.text = "\"Hey! I'm \(companionName!), what is your name?\""
        companionMessage.frame = CGRect(x: 120, y: 30, width: 500, height: 80)
        companionMessage.textColor = .white
        companionMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25.0)
        companionMessage.numberOfLines = 0
        self.view.addSubview(companionMessage)
        
        playerNameInput.borderStyle = .roundedRect
        let playerNameWidthConstraint = NSLayoutConstraint(item: playerNameInput, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        playerNameInput.addConstraint(playerNameWidthConstraint)
        playerNameInput.textAlignment = .center
        playerNameInput.placeholder = "Enter Your Name"
        
        let toNextVCButton = UIButton(type: .system)
        toNextVCButton.setTitle("Next >", for: .normal)
        toNextVCButton.setTitleColor(.systemTeal, for: .normal)
        toNextVCButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        toNextVCButton.addTarget(self, action: #selector(toNextVC), for: .touchUpInside)
        
        let toPreviousVCButton = UIButton(type: .system)
        toPreviousVCButton.setTitle("< Back", for: .normal)
        toPreviousVCButton.setTitleColor(.systemTeal, for: .normal)
        toPreviousVCButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        toPreviousVCButton.addTarget(self, action: #selector(toPreviousVC), for: .touchUpInside)
        
        let buttonStack = UIStackView(arrangedSubviews: [toPreviousVCButton, toNextVCButton])
        buttonStack.distribution = .fillEqually
        
        let backToHomeButton = UIButton(type: .system)
        backToHomeButton.setTitle("Home", for: .normal)
        backToHomeButton.setTitleColor(.systemTeal, for: .normal)
        backToHomeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        backToHomeButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        
        let overallStack = UIStackView(arrangedSubviews: [playerNameInput, buttonStack, backToHomeButton])
        self.view.addSubview(overallStack)
        overallStack.translatesAutoresizingMaskIntoConstraints = false
        overallStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        overallStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        overallStack.axis = .vertical
        
        overallStack.setCustomSpacing(50, after: playerNameInput)
    }
    
    @objc func backToHome() {
        let alertHome = UIAlertController(title: "Back to Homepage", message: "Are you sure you want to go back to homepage?", preferredStyle: .alert)
        
        alertHome.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alertHome.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alertHome, animated: true)
    }
    
    @objc func toPreviousVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func toNextVC() {
        if playerNameInput.text?.count == 0 {
            companionImage.image = UIImage(named: "Image/\(companionName!) - Far")
            companionMessage.text = "\"...Can you at least give me your nickname?\""
        } else if playerNameInput.text!.count > 12 {
            companionImage.image = UIImage(named: "Image/\(companionName!) - Far")
            companionMessage.text = "\"I'm sorry, but can we stick to your nickname instead?\""
        } else {
            playerNameString = playerNameInput.text!
            let chooseDifficultyVC = ChooseModeViewController()
            chooseDifficultyVC.companionName = companionName
            chooseDifficultyVC.playerName = playerNameString
            self.navigationController?.pushViewController(chooseDifficultyVC, animated: true)
        }
    }
}


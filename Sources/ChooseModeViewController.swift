import Foundation
import UIKit
import PlaygroundSupport

public class ChooseModeViewController: UIViewController {
    var companionName:String?
    var playerName:String?
    let companionImage = UIImageView(frame: CGRect(x: 20, y: 30, width: 100, height: 100))
    let companionMessage = UILabel()
    let normalStack = UIStackView()
    let timeTrialStack = UIStackView()
    var timeTrialClicked = false
    let toNextVCButton = UIButton(type: .system)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        chooseDifficulty()
    }
    
    func chooseDifficulty() {
        companionImage.image = UIImage(named: "Image/\(companionName!) - Speaking")
        self.view.addSubview(companionImage)
        
        companionMessage.text = "\"Hello \(playerName!), what mode do you want?\""
        companionMessage.frame = CGRect(x: 120, y: 30, width: 500, height: 80)
        companionMessage.textColor = .white
        companionMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25.0)
        companionMessage.numberOfLines = 0
        self.view.addSubview(companionMessage)
        
        let timeTrialImage = UIImageView()
        timeTrialImage.image = UIImage(named: "Image/Time Trial")
        let timeTrialImageWidthConstraint = NSLayoutConstraint(item: timeTrialImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let timeTrialImageHeightConstraint = NSLayoutConstraint(item: timeTrialImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        timeTrialImage.addConstraint(timeTrialImageWidthConstraint)
        timeTrialImage.addConstraint(timeTrialImageHeightConstraint)
        
        let timeTrialTitleLabel = UILabel()
        timeTrialTitleLabel.text = "Time Trial"
        timeTrialTitleLabel.textAlignment = .left
        timeTrialTitleLabel.textColor = .white
        timeTrialTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        
        let timeTrialSubtitleLabel = UILabel()
        timeTrialSubtitleLabel.text = "Get as high streak as you can within time limit!"
        timeTrialSubtitleLabel.textAlignment = .left
        timeTrialSubtitleLabel.textColor = .white
        timeTrialSubtitleLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)
        
        let timeTrialLabelStack = UIStackView(arrangedSubviews: [timeTrialTitleLabel, timeTrialSubtitleLabel])
        timeTrialLabelStack.axis = .vertical
        timeTrialLabelStack.distribution = .fillEqually
        
        timeTrialStack.addArrangedSubview(timeTrialImage)
        timeTrialStack.addArrangedSubview(timeTrialLabelStack)
        timeTrialStack.setCustomSpacing(30, after: timeTrialImage)
        timeTrialStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(timeTrialModeClicked)))
        
        let normalImage = UIImageView()
        normalImage.image = UIImage(named: "Image/Normal")
        let normalImageWidthConstraint = NSLayoutConstraint(item: normalImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        let normalImageHeightConstraint = NSLayoutConstraint(item: normalImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        normalImage.addConstraint(normalImageWidthConstraint)
        normalImage.addConstraint(normalImageHeightConstraint)
        
        let normalTitleLabel = UILabel()
        normalTitleLabel.text = "Normal"
        normalTitleLabel.textAlignment = .left
        normalTitleLabel.textColor = .white
        normalTitleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        
        let normalSubtitleLabel = UILabel()
        normalSubtitleLabel.text = "Play with your own pace!"
        normalSubtitleLabel.textAlignment = .left
        normalSubtitleLabel.textColor = .white
        normalSubtitleLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 20)
        
        let normalLabelStack = UIStackView(arrangedSubviews: [normalTitleLabel, normalSubtitleLabel])
        normalLabelStack.axis = .vertical
        normalLabelStack.distribution = .fillEqually
        
        normalStack.addArrangedSubview(normalImage)
        normalStack.addArrangedSubview(normalLabelStack)
        normalStack.setCustomSpacing(30, after: normalImage)
        normalStack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(normalModeClicked)))
        
        toNextVCButton.setTitle("Next >", for: .normal)
        toNextVCButton.setTitleColor(.systemTeal, for: .normal)
        toNextVCButton.setTitleColor(.gray, for: .disabled)
        toNextVCButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        toNextVCButton.addTarget(self, action: #selector(toNextVC), for: .touchUpInside)
        toNextVCButton.isEnabled = false
        
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
        
        let overallStackView = UIStackView(arrangedSubviews: [normalStack, timeTrialStack, buttonStack, backToHomeButton])
        self.view.addSubview(overallStackView)
        overallStackView.setCustomSpacing(30, after: normalStack)
        overallStackView.setCustomSpacing(50, after: timeTrialStack)
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        overallStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc func timeTrialModeClicked() {
        timeTrialClicked = true
        timeTrialStack.backgroundColor = .gray
        normalStack.backgroundColor = .clear
        toNextVCButton.isEnabled = true
    }
    
    @objc func normalModeClicked() {
        timeTrialClicked = false
        timeTrialStack.backgroundColor = .clear
        normalStack.backgroundColor = .gray
        toNextVCButton.isEnabled = true
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
        let gameplayVC = GameplayViewController()
        gameplayVC.companionName = companionName
        gameplayVC.playerName = playerName
        if timeTrialClicked {
            gameplayVC.isTimerMode = true
        } else {
            gameplayVC.isTimerMode = false
        }
        self.navigationController?.pushViewController(gameplayVC, animated: true)
    }
}

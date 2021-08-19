import Foundation
import UIKit
import PlaygroundSupport

public class CompanionViewController:UIViewController {
    
    let companion:[String] = ["Ayu - Choose", "Bayu - Choose"]
    let stackCompanionBayu = UIStackView()
    let stackCompanionAyu = UIStackView()
    var bayuClicked = false
    var ayuClicked = false
    let toNextVCButton = UIButton(type: .system)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        chooseCompanion()
    }
    
    func chooseCompanion() {
        
        // set up choose label
        let chooseCard = UILabel()
        chooseCard.text = "Choose Your Companion"
        chooseCard.textAlignment = .center
        chooseCard.textColor = .white
        chooseCard.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 50.0)
        
        // set up image view for Bayu
        let singleTapBayu = UITapGestureRecognizer(target: self, action: #selector(companionBayuClicked))
        
        let companionBayuImage = UIImageView()
        companionBayuImage.isUserInteractionEnabled = true
        companionBayuImage.image = UIImage(named: "Image/\(companion[1])")
        companionBayuImage.addGestureRecognizer(singleTapBayu)
        let imageBayuWidthConstraint = NSLayoutConstraint(item: companionBayuImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        let imageBayuHeightConstraint = NSLayoutConstraint(item: companionBayuImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        companionBayuImage.addConstraint(imageBayuWidthConstraint)
        companionBayuImage.addConstraint(imageBayuHeightConstraint)
        
        let companionBayuLabel = UILabel()
        companionBayuLabel.text = "Bayu"
        companionBayuLabel.textAlignment = .center
        companionBayuLabel.textColor = .white
        companionBayuLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30.0)
        
        stackCompanionBayu.addArrangedSubview(companionBayuImage)
        stackCompanionBayu.addArrangedSubview(companionBayuLabel)
        stackCompanionBayu.axis = .vertical
        
        // set up image view for Ayu
        let singleTapAyu = UITapGestureRecognizer(target: self, action: #selector(companionAyuClicked))
        
        let companionAyuImage = UIImageView()
        companionAyuImage.isUserInteractionEnabled = true
        companionAyuImage.image = UIImage(named: "Image/\(companion[0])")
        companionAyuImage.addGestureRecognizer(singleTapAyu)
        let imageAyuWidthConstraint = NSLayoutConstraint(item: companionAyuImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        let imageAyuHeightConstraint = NSLayoutConstraint(item: companionAyuImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        companionAyuImage.addConstraint(imageAyuWidthConstraint)
        companionAyuImage.addConstraint(imageAyuHeightConstraint)
        
        let companionAyuLabel = UILabel()
        companionAyuLabel.text = "Ayu"
        companionAyuLabel.textAlignment = .center
        companionAyuLabel.textColor = .white
        companionAyuLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30.0)
        
        stackCompanionAyu.addArrangedSubview(companionAyuImage)
        stackCompanionAyu.addArrangedSubview(companionAyuLabel)
        stackCompanionAyu.axis = .vertical
        
        let companionStackView = UIStackView(arrangedSubviews: [stackCompanionBayu, stackCompanionAyu])
        
        toNextVCButton.setTitle("Next >", for: .normal)
        toNextVCButton.setTitleColor(.systemTeal, for: .normal)
        toNextVCButton.setTitleColor(.gray, for: .disabled)
        toNextVCButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        toNextVCButton.addTarget(self, action: #selector(toNextVC), for: .touchUpInside)
        toNextVCButton.isEnabled = false
        
        let backToHomeButton = UIButton(type: .system)
        backToHomeButton.setTitle("Home", for: .normal)
        backToHomeButton.setTitleColor(.systemTeal, for: .normal)
        backToHomeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        backToHomeButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        
        let overallStackView = UIStackView(arrangedSubviews: [chooseCard, companionStackView, toNextVCButton, backToHomeButton])
        overallStackView.axis = .vertical
        self.view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        overallStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        overallStackView.setCustomSpacing(100, after: companionStackView)
    }
    
    @objc func backToHome() {
        let alertHome = UIAlertController(title: "Back to Homepage", message: "Are you sure you want to go back to homepage?", preferredStyle: .alert)
        
        alertHome.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alertHome.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alertHome, animated: true)
    }
    
    @objc func toNextVC() {
        let playerNameVC = PlayerNameViewController()
        if bayuClicked {
            playerNameVC.companionName = "Bayu"
        } else {
            playerNameVC.companionName = "Ayu"
        }
        self.navigationController?.pushViewController(playerNameVC, animated: true)
    }
    
    @objc func companionBayuClicked() {
        bayuClicked = true
        ayuClicked = false
        stackCompanionBayu.backgroundColor = .gray
        stackCompanionAyu.backgroundColor = .clear
        toNextVCButton.isEnabled = true
    }
    
    @objc func companionAyuClicked() {
        bayuClicked = false
        ayuClicked = true
        stackCompanionAyu.backgroundColor = .gray
        stackCompanionBayu.backgroundColor = .clear
        toNextVCButton.isEnabled = true
    }
}

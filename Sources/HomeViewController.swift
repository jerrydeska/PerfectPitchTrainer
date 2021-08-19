import Foundation
import UIKit
import PlaygroundSupport

public class HomeViewController:UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        home()
    }
    
    func home() {
        // set up the title card
        let titleCard = UILabel()
        titleCard.text = "Perfect Pitch Trainer"
        titleCard.textAlignment = .center
        titleCard.textColor = .white
        titleCard.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 70.0)
        
        // set up the subtitle card
        let subtitleCard = UILabel()
        subtitleCard.text = "Train yourself so you can have Perfect Pitch!"
        subtitleCard.textAlignment = .center
        subtitleCard.textColor = .white
        subtitleCard.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 30.0)
        subtitleCard.numberOfLines = 0
        
        // set up the start button
        let startButton = UIButton(type: .system)
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(.systemTeal, for: .normal)
        startButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        startButton.addTarget(self, action: #selector(toCompanionViewController), for: .touchUpInside)
        
        // set up a stack view
        let homeStackView = UIStackView(arrangedSubviews: [titleCard, subtitleCard, startButton])
        
        // change the stack view to vertical instead of horizontal
        homeStackView.axis = .vertical
        
        // adding the stackview to subview so it will appear on the screen
        self.view.addSubview(homeStackView)
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        homeStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        homeStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        //set custom spacing
        homeStackView.setCustomSpacing(100, after: subtitleCard)
    }
    
    @objc func toCompanionViewController() {
        let companionVC = CompanionViewController()
        navigationController?.pushViewController(companionVC, animated: true)
    }
}


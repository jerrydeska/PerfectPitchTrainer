import Foundation
import UIKit
import AVFoundation

public class GameplayViewController: UIViewController {
    
    var companionName:String?
    let companionImage = UIImageView(frame: CGRect(x: 20, y: 30, width: 100, height: 100))
    let companionMessage = UILabel()
    let playStopButton = UIImageView()
    let listOfNotes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    var listOfNotesButton = [UIButton]()
    var notePlayed:String?
    var audioPlayer:AVAudioPlayer?
    let correctOrWrongMessage = UILabel()
    let notesGuessedLabel = UILabel()
    var isPlaying:Bool = false
    let currentStreakLabel = UILabel()
    let highestStreakLabel = UILabel()
    var currentStreak = 0
    var highestStreak = 0
    var numberOfNotesGuessed = 0
    var noteName:String?
    var playerName:String?
    var companionMessageClose = [String]()
    var companionMessageFar = [String]()
    var companionMessageCorrect = [String]()
    var companionMessageStart = [String]()
    var isTimerMode:Bool = false
    var timerLabel = UILabel()
    var timerComponentsFormatter = DateComponentsFormatter()
    var timerInt:Int = 90
    var timerString:String?
    var timer = Timer()
    var isStarting = false
    var isTutorial = true
    let timesUpAlert = CustomAlert()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        gameplay()
    }
    
    func gameplay() {
        notePlayed = "Audio/\(listOfNotes.randomElement()!)"
        
        companionMessageClose = [
            "\"I think you're pretty close\"",
            "\"You're definitely on the right track...\"",
            "\"Getting warmer!\"",
            "\"Ooh just a little bit more...\""
        ]
        companionMessageFar = [
            "\"Definitely not that...\"",
            "\"Getting colder...\"",
            "\"You're probably thinking of a different note\"",
            "\"I don't think that is even near the answer...\""
        ]
        companionMessageCorrect = [
            "\"Nice! You got it!\"",
            "\"Good job \(playerName!)!\"",
            "\"Wow! I didn't think the answer will be that\"",
            "\"Nice job \(playerName!)!\""
        ]
        companionMessageStart = [
            "\"Let's do this \(playerName!)!\"",
            "\"I can feel it... You will get it on the first try!\"",
            "\"Let's go \(playerName!)!\"",
            "\"Ready?\""
        ]
        
        if isTimerMode {
            timerComponentsFormatter.allowedUnits = [.minute, .second]
            timerComponentsFormatter.unitsStyle = .positional
            timerString = timerComponentsFormatter.string(from: TimeInterval(timerInt))!
            
            timerLabel.text = "⏰ \(timerString!)"
            timerLabel.frame = CGRect(x: self.view.frame.size.width - 120, y: 30, width: 120, height: 80)
            timerLabel.textColor = .white
            timerLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 30.0)
            self.view.addSubview(timerLabel)
        }
        
        companionImage.image = UIImage(named: "Image/\(companionName!) - Speaking")
        self.view.addSubview(companionImage)
        
        companionMessage.text = companionMessageStart.randomElement()
        companionMessage.frame = CGRect(x: 120, y: 30, width: 500, height: 80)
        companionMessage.textColor = .white
        companionMessage.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25.0)
        companionMessage.numberOfLines = 0
        self.view.addSubview(companionMessage)
        
        playStopButton.isUserInteractionEnabled = true
        playStopButton.image = UIImage(named: "Image/PlayButton")
        let playButtonWidthConstraint = NSLayoutConstraint(item: playStopButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let playButtonHeightConstraint = NSLayoutConstraint(item: playStopButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        playStopButton.addConstraint(playButtonWidthConstraint)
        playStopButton.addConstraint(playButtonHeightConstraint)
        let singleTapPlayStopButton = UITapGestureRecognizer(target: self, action: #selector(playStopButtonClicked))
        playStopButton.addGestureRecognizer(singleTapPlayStopButton)
        self.view.addSubview(playStopButton)
        
        currentStreakLabel.text = "Current Streak: \(currentStreak)"
        currentStreakLabel.textAlignment = .center
        currentStreakLabel.textColor = .white
        currentStreakLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25.0)
        
        highestStreakLabel.text = "Highest Streak: \(highestStreak)"
        highestStreakLabel.textAlignment = .center
        highestStreakLabel.textColor = .white
        highestStreakLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25.0)
        
        let streakAndPlayButtonStackView = UIStackView(arrangedSubviews: [currentStreakLabel, playStopButton, highestStreakLabel])
        streakAndPlayButtonStackView.spacing = 20
        
        correctOrWrongMessage.text = "Status: "
        correctOrWrongMessage.textAlignment = .center
        correctOrWrongMessage.textColor = .white
        correctOrWrongMessage.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30.0)
        
        notesGuessedLabel.text = "Notes Guessed: \(String(numberOfNotesGuessed))"
        notesGuessedLabel.textAlignment = .center
        notesGuessedLabel.textColor = .white
        notesGuessedLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25.0)
        
        let messageStackView = UIStackView(arrangedSubviews: [correctOrWrongMessage, streakAndPlayButtonStackView, notesGuessedLabel])
        messageStackView.axis = .vertical
        messageStackView.spacing = 20
        
        let firstRowStackView = UIStackView(arrangedSubviews: createNotesButton(rowNumber: 0))
        firstRowStackView.distribution = .fillEqually
        let secondRowStackView = UIStackView(arrangedSubviews: createNotesButton(rowNumber: 3))
        secondRowStackView.distribution = .fillEqually
        let thirdRowStackView = UIStackView(arrangedSubviews: createNotesButton(rowNumber: 6))
        thirdRowStackView.distribution = .fillEqually
        let fourthRowStackView = UIStackView(arrangedSubviews: createNotesButton(rowNumber: 9))
        fourthRowStackView.distribution = .fillEqually
        let notesStackView = UIStackView(arrangedSubviews: [firstRowStackView, secondRowStackView, thirdRowStackView, fourthRowStackView])
        notesStackView.spacing = 30
        notesStackView.axis = .vertical
        
        let backToHomeButton = UIButton(type: .system)
        backToHomeButton.setTitle("Home", for: .normal)
        backToHomeButton.setTitleColor(.systemTeal, for: .normal)
        backToHomeButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        backToHomeButton.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
        
        let toPreviousVCButton = UIButton(type: .system)
        toPreviousVCButton.setTitle("< Back", for: .normal)
        toPreviousVCButton.setTitleColor(.systemTeal, for: .normal)
        toPreviousVCButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 35.0)
        toPreviousVCButton.addTarget(self, action: #selector(toPreviousVC), for: .touchUpInside)

        let overallStackView = UIStackView(arrangedSubviews: [messageStackView, notesStackView, toPreviousVCButton, backToHomeButton])
        overallStackView.axis = .vertical
        self.view.addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        overallStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        overallStackView.setCustomSpacing(50, after: messageStackView)
        overallStackView.setCustomSpacing(50, after: notesStackView)
        
        if isTutorial {
            // create mutable attributed string as a base to append the image and string
            let tutorialMessage = NSMutableAttributedString(string: "\"You can start by pressing the ")
            
            // create text attachment
            let playButtonAttachment = NSTextAttachment()
            playButtonAttachment.image = UIImage(named: "Image/PlayButtonIcon")
            
            // wrap the attachment so it can be appended
            let playButtonString = NSAttributedString(attachment: playButtonAttachment)
            
            // append the image and add some extra text after the image
            tutorialMessage.append(playButtonString)
            tutorialMessage.append(NSAttributedString(string: "\""))
            
            companionMessage.attributedText = tutorialMessage
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reduceTime), userInfo: nil, repeats: true)
    }
    
    @objc func reduceTime() {
        timerInt -= 1
        timerString = timerComponentsFormatter.string(from: TimeInterval(timerInt))!
        timerLabel.text = "⏰ \(timerString!)"
        if timerInt <= 10 {
            timerLabel.textColor = .systemRed
        }

        if timerInt == 0 {
            timer.invalidate()
            if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
                playStopButton.image = UIImage(named: "Image/PlayButton")
                audioPlayer.stop()
            }
            
            timesUpAlert.showAlert(title: "Times Up!", message: "\"You guessed \(numberOfNotesGuessed) notes and your highest streak is \(highestStreak)\"", companionName: companionName!, ViewController: self, numberOfNotes: numberOfNotesGuessed, companionMessage: companionMessage, companionImage: companionImage)
            
           highestStreak = 0
           currentStreak = 0
           numberOfNotesGuessed = 0
           notesGuessedLabel.text = "Notes Guessed: \(String(numberOfNotesGuessed))"
           highestStreakLabel.text = "Highest Streak: \(highestStreak)"
           currentStreakLabel.text = "Current Streak: \(currentStreak)"

            for i in 0..<listOfNotesButton.count {
                if listOfNotesButton[i].isEnabled == true {
                    listOfNotesButton[i].isEnabled = false
                }
            }

            isPlaying = false
            isStarting = false

            correctOrWrongMessage.text = "Status: "
            companionImage.image = UIImage(named: "Image/\(companionName!) - Speaking")
            companionMessage.text = companionMessageStart.randomElement()

            timerInt = 90
            timerString = timerComponentsFormatter.string(from: TimeInterval(timerInt))!
            timerLabel.text = "⏰ \(timerString!)"
            timerLabel.textColor = .white
            
            notePlayed = "Audio/\(listOfNotes.randomElement()!)"
        }
    }
    
    @objc func playStopButtonClicked() {
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            // stop playback
            playStopButton.image = UIImage(named: "Image/PlayButton")
            audioPlayer.stop()
        } else {
            if !isPlaying {
                for i in 0..<listOfNotesButton.count {
                    listOfNotesButton[i].isEnabled = true
                }
                isPlaying = true
                correctOrWrongMessage.text = "Status: "
                
                if isTutorial {
                    companionImage.image = UIImage(named: "Image/\(companionName!) - Close")
                    companionMessage.text = "Now try to guess what note is this?"
                } else {
                    companionMessage.text = companionMessageStart.randomElement()
                }
                
                if !isStarting && isTimerMode {
                    isStarting = true
                    startTimer()
                }
            }
            
            // set up player and play
            playStopButton.image = UIImage(named: "Image/StopButton")
            let audioUrl = Bundle.main.path(forResource: notePlayed, ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let audioUrl = audioUrl else {
                    return
                }
                
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioUrl))
                
                guard let audioPlayer = audioPlayer else {
                     return
                }
                
                audioPlayer.play()
                audioPlayer.numberOfLoops = -1
                
            }
            catch {
                print("Something Went Wrong...")
            }
        }
    }
    
    func createNotesButton(rowNumber:Int) -> [UIButton] {
        var columnOfButton = [UIButton]()
        
        for i in rowNumber...(rowNumber + 2) {
            let noteButton = UIButton()
            noteButton.setTitle(listOfNotes[i], for: .normal)
            noteButton.setTitleColor(.systemTeal, for: .normal)
            noteButton.setTitleColor(.gray, for: .disabled)
            noteButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 30.0)
            noteButton.addTarget(self, action: #selector(noteButtonClicked(_:)), for: .touchUpInside)
            noteButton.isEnabled = false
            listOfNotesButton.append(noteButton)
            columnOfButton.append(noteButton)
        }
        return columnOfButton
    }
    
    @objc func noteButtonClicked (_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        noteName = notePlayed!
        noteName!.removeFirst(6)
        
        if buttonTitle == noteName {
            var firstTry:Bool = true
            
            if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
                playStopButton.image = UIImage(named: "Image/PlayButton")
                audioPlayer.stop()
            }
            
            for i in 0..<listOfNotesButton.count {
                if listOfNotesButton[i].isEnabled {
                    listOfNotesButton[i].isEnabled = false
                } else {
                    firstTry = false
                }
            }
            
            if firstTry {
                currentStreak += 1
                if currentStreak > highestStreak {
                    highestStreak = currentStreak
                    highestStreakLabel.text = "Highest Streak: \(highestStreak)"
                }
                currentStreakLabel.text = "Current Streak: \(currentStreak)"
            }
            
            numberOfNotesGuessed += 1
            notesGuessedLabel.text = "Notes Guessed: \(String(numberOfNotesGuessed))"
            isPlaying = false
            correctOrWrongMessage.text = "Status: \(noteName!) ✅"
            notePlayed = "Audio/\(listOfNotes.randomElement()!)"
            
            companionImage.image = UIImage(named: "Image/\(companionName!) - Correct")
            if isTutorial {
                companionMessage.text = "Nice! Now you can do it again to train your pitch. Good luck!"
                isTutorial = false
            } else {
                companionMessage.text = companionMessageCorrect.randomElement()
            }
            
        } else {
            correctOrWrongMessage.text = "Status: ❎"
            currentStreak = 0
            currentStreakLabel.text = "Current Streak: \(currentStreak)"
            sender.isEnabled = false
            
            let indexOfNoteChoice = listOfNotes.firstIndex(of: buttonTitle)!
            let indexOfNoteQuestion = listOfNotes.firstIndex(of: noteName!)!
            var indexDifference = indexOfNoteChoice - indexOfNoteQuestion
            indexDifference = abs(indexDifference)
            if indexDifference == 1 || indexDifference == 11 {
                companionImage.image = UIImage(named: "Image/\(companionName!) - Close")
                companionMessage.text = companionMessageClose.randomElement()
            } else {
                companionImage.image = UIImage(named: "Image/\(companionName!) - Far")
                companionMessage.text = companionMessageFar.randomElement()
            }
        }
    }
    
    @objc func toPreviousVC() {
        let alertBack = UIAlertController(title: "Back to Choosing Mode", message: "Are you sure you want to go back to choosing mode?", preferredStyle: .alert)
        
        alertBack.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            if let audioPlayer = self.audioPlayer, audioPlayer.isPlaying {
                // stop playback
                self.playStopButton.image = UIImage(named: "Image/PlayButton")
                audioPlayer.stop()
            }
            self.navigationController?.popViewController(animated: true)
        }))
        
        alertBack.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alertBack, animated: true)
    }
    
    @objc func backToHome() {
        let alertHome = UIAlertController(title: "Back to Homepage", message: "Are you sure you want to go back to homepage?", preferredStyle: .alert)
        
        alertHome.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            if let audioPlayer = self.audioPlayer, audioPlayer.isPlaying {
                self.playStopButton.image = UIImage(named: "Image/PlayButton")
                audioPlayer.stop()
            }
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        alertHome.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        present(alertHome, animated: true)
    }
    
    @objc func dismissAlert() {
        timesUpAlert.dismissAlert()
    }
}

class CustomAlert {
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .darkGray
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    var myTargetView: UIView?
    var returnValue: String = ""
    var myCompanionMessage = UILabel()
    var myCompanionImage = UIImageView()
    let titleLabel = UILabel()
    let companionImageAlert = UIImageView()
    let messageLabel = UILabel()
    let dismissButton = UIButton()
    
    func showAlert(title: String, message: String, companionName:String, ViewController: UIViewController, numberOfNotes: Int, companionMessage: UILabel, companionImage: UIImageView) {
        
        guard let targetView = ViewController.view else {
            return
        }
        myTargetView = targetView
        
        myCompanionImage = companionImage
        myCompanionImage.isHidden = true
        
        myCompanionMessage = companionMessage
        myCompanionMessage.isHidden = true
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: (targetView.frame.size.width / 2) - 150 , y: -300, width: 300, height: 300)
        targetView.addSubview(alertView)
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: alertView.frame.size.width , height: 80)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 25.0)
        titleLabel.textColor = .white
        alertView.addSubview(titleLabel)
        
        companionImageAlert.image = UIImage(named: (numberOfNotes == 0) ? "Image/\(companionName) - Far" : "Image/\(companionName) - Correct")
        companionImageAlert.frame = CGRect(x: (alertView.frame.size.width / 2) - 50, y: 60 , width: 100, height: 100)
        alertView.addSubview(companionImageAlert)
        
        messageLabel.frame = CGRect(x: 0, y: 160, width: alertView.frame.size.width , height: 90)
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20.0)
        messageLabel.textColor = .white
        alertView.addSubview(messageLabel)
        
        dismissButton.frame =  CGRect(x: 0, y: alertView.frame.size.height - 70, width: alertView.frame.size.width, height: 70)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        dismissButton.setTitleColor(.systemTeal, for: .normal)
        alertView.addSubview(dismissButton)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = 0.6
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = targetView.center
                }
            }
        })
    }
    
    @objc func dismissAlert() {
        guard let targetView = myTargetView else {
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: (targetView.frame.size.width / 2) - 150 , y: -300, width: 300, height: 300)
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done {
                        self.titleLabel.removeFromSuperview()
                        self.companionImageAlert.removeFromSuperview()
                        self.messageLabel.removeFromSuperview()
                        self.dismissButton.removeFromSuperview()
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                        self.myCompanionMessage.isHidden = false
                        self.myCompanionImage.isHidden = false
                    }
                })
            }
        })
    }
}

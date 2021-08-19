/*:
 # Welcome!
 Perfect pitch (or absolute pitch) is a rare ability (1 in 10,000 people) that make a person able to identify musical notes just from hearing it without needing any guiding notes.
 
 Some people believe that perfect pitch can only be acquired by being born with it, but a study in 2015 (https://bit.ly/2P0cOtW) from University of Chicago found out that people can train themself to have perfect pitch no matter the amount of musical experience they have.

 In this playground, we will be able to train our pitch and develop our perfect pitch. Enjoy!
*/
import UIKit
import PlaygroundSupport

let vc = HomeViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = UINavigationController(rootViewController: vc)
vc.navigationController?.setNavigationBarHidden(true, animated: true)

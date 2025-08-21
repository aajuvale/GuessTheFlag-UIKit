//
//  ViewController.swift
//  GuessTheFlag-UIKit
//
//  Created by Ahmed Juvale on 8/21/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!

    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        countries += [ "estonia",
                       "france",
                       "germany",
                       "ireland",
                       "italy",
                       "monaco",
                       "nigeria",
                       "poland",
                       "russia",
                       "spain",
                       "uk",
                       "us"
        ]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        questionsAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        // Challenge 1: Showing score
        title =  "Which of these is " + countries[correctAnswer].uppercased() + "? Current Score: \(score)"

        // Challenge 2: Final Alert
        if questionsAsked >= 10 {
            let ac = UIAlertController(title: "Thanks for playing!", message: "You have answered 10 Questions!", preferredStyle: .alert)
            present(ac, animated: true)
        }
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }

        // Challenge 3: Wrong Flag message w/ ternary
        let ac = UIAlertController(
            title: title,
            message: sender.tag == correctAnswer ? "Your score is \(score)" : "Your score is \(score), you picked \(countries[sender.tag]) instead of \(countries[correctAnswer])",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

        present(ac, animated: true)
    }
}


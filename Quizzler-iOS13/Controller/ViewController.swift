//
//  ViewController.swift
//  Quizzler-iOS13
//
//
//

import UIKit



class ViewController: UIViewController {
    

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    var quizBrain = QuizBrain()
    let timeForQuestion = 10
    var timeElapsed = 0
    var timerClock = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(quizBrain.score)"
        trueButton.setTitle("True", for: .normal)
        falseButton.setTitle("False", for: .normal)
        progressbar.progress = 0.0
        question.text = quizBrain.myQuiz[quizBrain.question_number].text
        timer()
    }
    
    func timer(){
        timerClock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(progressUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func progressUpdate(){
        if(timeElapsed<timeForQuestion)
        {
        timeElapsed += 1
        progressbar.progress = Float(timeElapsed)/Float(timeForQuestion)
        }
        else
        {
            timerClock.invalidate()
            if(quizBrain.question_number<quizBrain.myQuiz.count-1){
                quizBrain.question_number += 1
            }
            else{
                quizBrain.question_number = 0
            }
            updateUI()
        }
    }
    
    @IBAction func answeerButtonPressed(_ sender: UIButton) {
        timerClock.invalidate()
        let userAnswer = sender.currentTitle!
        let answer = quizBrain.checkAnswer(userAnswer)
        
        if answer{
            sender.backgroundColor = UIColor.green
        }
        else{
            sender.backgroundColor = UIColor.red
        }
       
        if(quizBrain.question_number<quizBrain.myQuiz.count-1){
            quizBrain.question_number += 1
        }
        else{
            quizBrain.question_number = 0
        }
       
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    @objc func updateUI(){
        scoreLabel.text = "Score: \(quizBrain.score)"
        question.text = quizBrain.myQuiz[quizBrain.question_number].text
        trueButton.backgroundColor = UIColor.clear
        falseButton.backgroundColor = UIColor.clear
        progressbar.progress = 0.0
        timeElapsed = 0
        timer()
    }
}



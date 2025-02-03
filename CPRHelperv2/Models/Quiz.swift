//
//  Quiz.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import Foundation

///Quiz format for the ```QuizView```
struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}

///Questions for the QuizView
let questions: [Question] = [
        Question(
            text: "Who formed the first organized effort to respond to sudden death in 1767?",
            answers: ["American Heart Association", "Society for the Recovery of Drowned Persons", "William A. Tossach"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "Which unusual method was used in early resuscitation techniques?",
            answers: ["Chest compressions", "Rectal fumigation with tobacco smoke", "Electrical defibrillation"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What did Peter Christian Abildgaard demonstrate in 1775?",
            answers: ["The effectiveness of artificial ventilation", "The revival of lifeless animals with electrical shocks", "The distinction between absolute and apparent death"],
            correctAnswerIndex: 1
        )
    ]

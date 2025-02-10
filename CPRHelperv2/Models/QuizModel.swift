//
//  QuizModel.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 07.02.2025.
//

import Foundation
import SwiftUI

///Class that handles the playing of the quiz in the history of CPR
@Observable
class QuizModel{
    var currentQuestionIndex:Int
    var selectedAnswerIndex: Int?
    var showFeedback:Bool
    var score:Int = 0
    var shuffledQuestions = questions.shuffled()
    var isEnd = false
    
    init(currentQuestionIndex: Int = 0, showFeedback: Bool = false, selectedAnswerIndex: Int? = nil) {
        self.currentQuestionIndex = currentQuestionIndex
        self.showFeedback = showFeedback
        self.selectedAnswerIndex = selectedAnswerIndex
    }
    
    ///Checks if answer is correct and whether it should give points
    func checkAnswer() {
        if selectedAnswerIndex == shuffledQuestions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        showFeedback = true
    }

    //Gives the next question
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            showFeedback = false
            if(currentQuestionIndex == questions.count - 1){
                isEnd = true
            }
        }
    }
}

//
//  QuizView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

///View that shows Quiz for the history part of the Practice.
struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var showFeedback = false
    @State private var score = 0
    @State private var currentQuestions = questions.shuffled()
    @Binding var isActive:PracticePage?
    
    var body: some View {
        VStack {
            Text("Quiz")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            Spacer()

            VStack(alignment: .leading, spacing: 16) {
                Text(questions[currentQuestionIndex].text)
                    .font(.title2)
                    .bold()
                    .padding()

                ForEach(0..<questions[currentQuestionIndex].answers.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring) {
                            selectedAnswerIndex = index
                            checkAnswer()
                        }
                    }) {
                        HStack {
                            Text(questions[currentQuestionIndex].answers[index])
                                .foregroundColor(.black)
                                .padding()

                            Spacer()
                            if(showFeedback){
                                Image(systemName: questions[currentQuestionIndex].correctAnswerIndex == index ? "checkmark" : "xmark")
                                    .padding()
                                    .foregroundStyle(questions[currentQuestionIndex].correctAnswerIndex == index ? Color.green : Color.red)
                            }else{
                                //So as to hav th same padding
                                Image(systemName: "dot.circle")
                                    .padding()
                                    .foregroundStyle(Color.clear)
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedAnswerIndex == index ? Color.gray.opacity(0.2) : Color.white
                        )
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    .disabled(showFeedback)
                }
            }

            Spacer()

            if showFeedback {
                Text(selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex ? "Correct!" : "Incorrect")
                    .font(.headline)
                    .foregroundColor(selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex ? .green : .red)
                    .padding()

                Button("Next") {
                    withAnimation(.linear) {
                        nextQuestion()
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }

            Text("Score: \(score)/\(questions.count)")
                .font(.footnote)
                .padding(.bottom)
        }
        .padding()
    }

    private func checkAnswer() {
        if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        showFeedback = true
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            showFeedback = false
        } else {
            // Quiz finished
        }
    }
}

#Preview {
    QuizView(isActive: .constant(PracticePage(type: .history)))
        .fontDesign(.monospaced)
}

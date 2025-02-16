//
//  QuizView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 03.02.2025.
//

import SwiftUI

///View that shows Quiz for the history part of the Practice.
struct QuizView: View {
    @Binding var isActive:PracticePage?
    @State var model = QuizModel()
    @Binding var show:Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    withAnimation {
                        show = false
                    }
                } label: {
                    Label("Back", systemImage: "chevron.left")
                        .padding(.bottom)
                    
                }
                Spacer()
            }
            Text("Quiz")
                .font(.largeTitle)
                .bold()
                .padding(.top)
            Text("Score: \(model.score)/\(model.shuffledQuestions.count)")
                .font(.footnote)
                .padding(.bottom)
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                Text(model.shuffledQuestions[model.currentQuestionIndex].text)
                    .font(.title2)
                    .bold()
                    .padding()

                ForEach(0..<model.shuffledQuestions[model.currentQuestionIndex].answers.count, id: \.self) { index in
                    Button(action: {
                        withAnimation(.spring) {
                            model.selectedAnswerIndex = index
                            model.checkAnswer()
                        }
                    }) {
                        HStack {
                            Text(model.shuffledQuestions[model.currentQuestionIndex].answers[index])
                                .foregroundColor(.black)
                                .padding()

                            Spacer()
                            if(model.showFeedback){
                                Image(systemName: model.shuffledQuestions[model.currentQuestionIndex].correctAnswerIndex == index ? "checkmark" : "xmark")
                                    .padding()
                                    .foregroundStyle(model.shuffledQuestions[model.currentQuestionIndex].correctAnswerIndex == index ? Color.green : Color.red)
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
                            model.selectedAnswerIndex == index ? (colorScheme == .dark ? Color.gray.opacity(0.95):Color.gray.opacity(0.2)) : Color.white
                        )
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    }
                    .disabled(model.showFeedback)
                }
            }

            Spacer()

            if model.showFeedback {
                Text(model.selectedAnswerIndex == model.shuffledQuestions[model.currentQuestionIndex].correctAnswerIndex ? "Correct!" : "Incorrect")
                    .font(.headline)
                    .foregroundColor(model.selectedAnswerIndex == model.shuffledQuestions[model.currentQuestionIndex].correctAnswerIndex ? .green : .red)
                    .padding()

                Button(model.isEnd ? "End" : "Next") {
                    withAnimation(.linear) {
                        if(model.isEnd){
                            withAnimation(.linear) {
                                isActive = nil
                            }
                        }else{
                            model.nextQuestion()
                        }
                    }
                }
                .padding()
                .buttonStyle(.plain)
                .borderedBackground()
            }
        }
        .padding()
    }
}

#Preview {
    QuizView(isActive: .constant(PracticePage(type: .history)), show: .constant(true))
        .fontDesign(.monospaced)
}

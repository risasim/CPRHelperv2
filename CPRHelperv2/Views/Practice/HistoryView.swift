//
//  HistoryVie.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///View depicting the CPR history, simple stylized text with images
struct HistoryView:View {
    @State var showQuiz = false
    @Binding var isActive:PracticePage?
    var body: some View {
        VStack{
            HStack{
                Text("History")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom,0)
                Spacer()
            }
            ScrollView{
                Text(history)
                HStack{
                    Image("history")
                        .resizable()
                        .scaledToFit()
                    Image("history2")
                        .resizable()
                        .scaledToFit()
                }
                Text(history2)
            }
            .padding(.top,0)
            Button {
                showQuiz = true
            } label: {
                Text("Take quiz")
                    .padding()
                    .borderedBackground()
            }

        }
        .navigationDestination(isPresented: $showQuiz, destination: {
            QuizView(isActive: $isActive, show: $showQuiz)
                .navigationBarBackButtonHidden()
        })
        .padding(.horizontal)
    }
}

#Preview {
    NavigationStack{
        HistoryView(isActive: .constant(PracticePage(type:PracticeOptions.history)))
    }
}

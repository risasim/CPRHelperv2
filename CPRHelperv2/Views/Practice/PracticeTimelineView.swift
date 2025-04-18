//
//  PracticeTimelineView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

///Navigation hub for the practicing, shows in bottom sheet
struct PracticeTimelineView: View {
    @State var pages = PracticePagesHandler()
    @State var showRealValues: Bool = false
    @Binding var active:Bool
    @Binding var practiceDetailActive:Bool
    @Binding var practiceDetailType:PracticePage?
    var onboarding:Bool = false
    
    var body: some View {
        VStack(spacing:0) {
            if(!onboarding){
                HStack{
                    Text("Here are some practice blocks for you to learn from")
                        .lineLimit(2)
                        .minimumScaleFactor(0.1)
                        .padding()
                        .bold()
                    Spacer()
                    VStack{
                        Button {
                            active.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .bold()
                                .font(.title)
                                .padding(.trailing)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            ForEach(pages.pages.pages) { page in
                HStack{
                    Image (systemName:(showRealValues ? page.isComplete : false) ? "righttriangle.fill": "righttriangle")
                        .foregroundStyle((showRealValues ? page.isComplete : false) ? Color.red :  Color.primary)
                        .rotationEffect(Angle(degrees: 45))
                        .font(.largeTitle)
                    MenuNode(title: page.type.title(), icon: page.type.icon())
                    Spacer()
                }
                .font(.title)
                .frame(height:90)
                .padding(.leading,10)
                .overlay(alignment: .leading) {
                    if(!pages.isLast(id: page.id)){
                        Rectangle()
                            .animation(.bouncy,value: page.isComplete)
                            .frame(width: 1, height: (showRealValues ? page.isComplete : false) ? 68 : 0)
                            .foregroundColor(.secondary)
                            .offset(x:12.5, y:54.5)
                            .padding(.leading,16)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        active = false
                        practiceDetailType = page
                        practiceDetailActive = true
                        pages.toggle(pageId: page.id)
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    showRealValues = true
                }
            }
        }
        .onDisappear {
            pages.saveToDefaults()
        }
    }
}

#Preview {
    NavigationStack{
        VStack{
            Text("Here is to the crazy ones")
        }
        .sheet(isPresented: .constant(true)) {
            PracticeTimelineView(active: .constant(true), practiceDetailActive: .constant(false), practiceDetailType: .constant(PracticePage(type: PracticeOptions.history)))
                .presentationDetents([.medium])
        }
    }
}

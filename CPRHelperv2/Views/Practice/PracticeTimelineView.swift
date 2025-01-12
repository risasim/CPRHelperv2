//
//  PracticeTimelineView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct PracticeTimelineView: View {
    @State var pages = PracticePagesHandler()
    @State var showRealValues: Bool = false
    @Binding var active:Bool
    @Binding var practiceDetailActive:Bool
    @Binding var practiceDetailType:PracticePage?
    
    var body: some View {
        VStack(spacing:0) {
            HStack{
                Text("Here are some practice blocks for you to learn")
                    .padding()
                    .bold()
                    .minimumScaleFactor(0.0001)
                VStack{
                    Button {
                        active.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .bold()
                            .font(.title)
                            .padding(5)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
            }
            ForEach(pages.pages.pages) { page in
                HStack{
                    Image (systemName:(showRealValues ? page.isComplete : false) ? "righttriangle.fill": "righttriangle")
                        .foregroundStyle((showRealValues ? page.isComplete : false) ? Color.red :  Color.primary)
                        .rotationEffect(Angle(degrees: 45))
                        .font(.largeTitle)
                    MenuNode(title: page.type.title(), icon: "calendar")
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
        PracticeTimelineView(active: .constant(true), practiceDetailActive: .constant(false), practiceDetailType: .constant(PracticePage(type: PracticeOptions.history)))
    }
}

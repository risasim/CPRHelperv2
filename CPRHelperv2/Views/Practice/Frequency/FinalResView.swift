//
//  FinalResView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

struct FinalResView: View {
    @Binding var showResults:Bool
    var data:[(Int,Int)]
    var curFreq:Int
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button {
                    showResults = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding(.top)
                        .padding(.bottom,5)
                }
            }
            .buttonStyle(.plain)
            FreqResultsView(data: data, fFrequecny: curFreq)
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    @Previewable @State var sheetContentHeight = CGFloat(0)
    VStack{
        Text("Here is to the crazy ones")
            .sheet(isPresented: .constant(true)) {
                FinalResView(showResults: .constant(true), data: [(0, 109), (1, 122), (2, 117), (3, 118), (4, 119), (5, 136), (6, 114), (7, 128), (8, 100), (9, 93), (10, 110), (11, 123), (12, 102), (13, 116), (14, 111), (15, 105), (16, 114), (17, 110), (18, 120), (19, 116), (20, 121), (21, 120), (22, 117), (23, 114), (24, 123), (25, 102), (26, 116), (27, 117), (28, 115), (29, 122), (30, 110), (31, 118), (32, 119), (33, 115), (34, 114), (35, 122), (36, 124), (37, 116), (38, 117), (39, 119), (40, 123), (41, 0), (42, 0), (43, 0), (44, 0), (45, 0), (46, 0), (47, 0), (48, 0), (49, 0), (50, 0), (51, 0), (52, 0), (53, 0), (54, 0), (55, 0), (56, 0), (57, 0), (58, 0), (59, 0)], curFreq: 100)
                    .background {
                        //This is done in the background otherwise GeometryReader tends to expand to all the space given to it like color or shape.
                        GeometryReader { proxy in
                            Color.clear
                                .task {
                                    sheetContentHeight = proxy.size.height
                                }
                        }
                    }
                    .presentationDetents([.height(sheetContentHeight),.height(sheetContentHeight+60.0)])
            }
    }
}

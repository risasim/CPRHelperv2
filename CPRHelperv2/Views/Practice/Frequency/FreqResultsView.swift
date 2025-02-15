//
//  FreqResultsView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

//TODO Check correct sizing of the 
///Shows the GraphView and some text depending on how the user did.
struct FreqResultsView: View {
    
    var data:[(Int,Int)]
    var fFrequecny:Int
    
    var body: some View {
        VStack{
            VStack{
                if(fFrequecny<=120 && fFrequecny>=100){
                    Text("Good job, this is how it is supposed to be done.")
                        
                }else if(fFrequecny>120){
                    Text("Slow down cowboy!")
                        .padding(.bottom,10)
                }else{
                    Text("You need to be quicker next time!")
                        .padding(.bottom,10)
                }
            }
            .font(.title2)
            .frame(maxWidth: .infinity)
            HStack{
                if(fFrequecny<=120 && fFrequecny>=100){
                    //Nothing it was perfect
                }else if(fFrequecny>120){
                    Text(" You have resuscitated to quickly, try to sing Jingle Bells or Stayin Alive to keep rhytm.")
                        .font(.headline)
                }else{
                    Text("You have resuscitated to slow, try to sing Jingle Bells or Stayin Alive to keep rhytm.")
                        .font(.headline)
                }
            }
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            Text("Your final frequency was \(fFrequecny) push/min.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            GraphView(data: data)
                .frame(minHeight:250, maxHeight: 300)
            Text("The ideal frequency should be between 100-120 push/min and with depth of 6cm (one package of TicTac).")
                .multilineTextAlignment(.center)
                .font(.footnote)
        }
        .multilineTextAlignment(.center)
    }
}


#Preview {
    @Previewable @State var sheetContentHeight = CGFloat(0)
    VStack{
        Text("Bla bla")
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

#Preview {
    @Previewable @State var sheetContentHeight = CGFloat(0)
    VStack{
        Text("Here is to the crazy ones")
            .sheet(isPresented: .constant(true)) {
                FinalResView(showResults: .constant(true), data:[(0, 109), (1, 122), (2, 117), (3, 118), (4, 119), (5, 136), (6, 114), (7, 128), (8, 100), (9, 93), (10, 110), (11, 123), (12, 102), (13, 116), (14, 111), (15, 105), (16, 114), (17, 110), (18, 120), (19, 116), (20, 121), (21, 120), (22, 117), (23, 114), (24, 123), (25, 102), (26, 116), (27, 117), (28, 115), (29, 122), (30, 110), (31, 118), (32, 119), (33, 115), (34, 114), (35, 122), (36, 124), (37, 116), (38, 117), (39, 119), (40, 123), (41, 0), (42, 0), (43, 0), (44, 0), (45, 0), (46, 0), (47, 0), (48, 0), (49, 0), (50, 0), (51, 0), (52, 0), (53, 0), (54, 0), (55, 0), (56, 0), (57, 0), (58, 0), (59, 0)], curFreq: 99)
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


#Preview {
    @Previewable @State var sheetContentHeight = CGFloat(0)
    VStack{
        Text("Here is to the crazy ones")
            .sheet(isPresented: .constant(true)) {
                FinalResView(showResults: .constant(true), data:[(0, 109), (1, 122), (2, 117), (3, 118), (4, 119), (5, 136), (6, 114), (7, 128), (8, 100), (9, 93), (10, 110), (11, 123), (12, 102), (13, 116), (14, 111), (15, 105), (16, 114), (17, 110), (18, 120), (19, 116), (20, 121), (21, 120), (22, 117), (23, 114), (24, 123), (25, 102), (26, 116), (27, 117), (28, 115), (29, 122), (30, 110), (31, 118), (32, 119), (33, 115), (34, 114), (35, 122), (36, 124), (37, 116), (38, 117), (39, 119), (40, 123), (41, 0), (42, 0), (43, 0), (44, 0), (45, 0), (46, 0), (47, 0), (48, 0), (49, 0), (50, 0), (51, 0), (52, 0), (53, 0), (54, 0), (55, 0), (56, 0), (57, 0), (58, 0), (59, 0)], curFreq: 121)
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

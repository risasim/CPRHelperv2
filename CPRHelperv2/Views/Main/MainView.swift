//
//  MainView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///Root view from which all of the navigation is handled
struct MainView: View {
    
    @State var isInfoActive: Bool = false
    @State var practiceActive:Bool = false
    @State var practiceDetailActive = false
    @State var practiceDetailType:PracticePage? = nil
    @State private var model = EmergencyModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            VStack(){
                AnimatedAppLabel(appName: "CPR:Helper")
                    .padding(.bottom)
                NavigationLink {
                    EmergencyView(model: $model)
                        .onAppear {
                            model.startTimer()
                            model.audioModel.toggleActive()
                        }
                        .onDisappear(perform: {
                            model.audioModel.toggleActive()
                            model.startTimer()
                        })
                } label: {
                    Label("Emergency", systemImage: "waveform.path.ecg")
                        .font(.largeTitle)
                        .labelStyle(MainLabelStyle(isEmergency: true))
                }
                Button {
                    practiceActive.toggle()
                } label: {
                    Label("Practice", systemImage: "heart.text.square.fill")
                        .font(.title)
                        .labelStyle(MainLabelStyle(isDotted: true))
                        .padding(.vertical)
                }

                Spacer()
                Button(action: {isInfoActive.toggle()}, label: {
                    Label("Info", systemImage: "info.circle")
                        .frame(maxWidth: .infinity,maxHeight: 60)
                        .labelStyle(MainLabelStyle())
                })
            }
            .padding()
            .sheet(isPresented: $practiceActive, content: {
                NavigationStack{
                    PracticeTimelineView(active: $practiceActive, practiceDetailActive: $practiceDetailActive, practiceDetailType: $practiceDetailType)
                }
                    .presentationDetents([.medium])
            })
            .sheet(isPresented: $isInfoActive, content: {
                InfoView(active: $isInfoActive)
            })
            .if(practiceDetailType != nil, transform: { view in
                view.fullScreenCover(isPresented: $practiceDetailActive) {
                    NavigationStack{
                        VStack{
                            HStack{
                                Button {
                                    withAnimation {
                                        practiceDetailActive = false
                                    }
                                } label: {
                                    Label("Back", systemImage: "chevron.left")
                                        .padding(.leading)
                                        .padding(.bottom)
                                    
                                }
                                Spacer()
                            }
                            AnyView(practiceDetailType!.type.destination($practiceDetailType))
                        }
                        .if(!practiceDetailType!.isComplete) { view in
                            view
                                .overlay{
                                    ZStack{
                                        Color.clear
                                            .background(
                                                .ultraThinMaterial,
                                                in: RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            )
                                            .ignoresSafeArea()
                                        VStack{
                                            Text((practiceDetailType?.type.explainer())!)
                                            Button {
                                                practiceDetailType!.isComplete.toggle()
                                            } label: {
                                                Label("Got it!", systemImage: "checkmark")
                                                    .padding()
                                            }
                                        }
                                        .padding()
                                        .multilineTextAlignment(.center)
                                    }
                                }
                        }
                    }
                    .accentColor(.primary)
                }
            })
        }
        .fontDesign(.monospaced)
        .accentColor(.primary)
    }
}


#Preview {
    MainView()
}

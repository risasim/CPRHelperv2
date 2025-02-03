//
//  CustomStyles.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import SwiftUI

///Style for the buttons in the ``MainView``
struct MainButtonStyle: ButtonStyle {
    var isDotted:Bool = false
    var isEmergency:Bool=false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .frame(minWidth: 0, maxWidth: .infinity)
            .buttonStyle(.plain)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: isDotted ? StrokeStyle(lineWidth: 1, dash: [5]) : StrokeStyle(lineWidth: 1))
            )
            .if(isEmergency, transform: { view in
                view.background {
                    ZStack{
                        Color.red
                        WornOutTextureView()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .foregroundStyle(Color.white)
            })
        
    }
}

///Style for the label in the ``MainView``
struct MainLabelStyle: LabelStyle {
    var isDotted: Bool = false
    var isEmergency: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        HStack() {
            configuration.icon
            configuration.title
        }
        .foregroundColor(isEmergency ? .white : .primary)
        .padding(.vertical)
        .frame(minWidth: 0, maxWidth: .infinity,maxHeight: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: isDotted ? StrokeStyle(lineWidth: 1, dash: [5]) : StrokeStyle(lineWidth: 1))
        )
        .if(isEmergency, transform: { view in
            view.background {
                ZStack{
                    Color.red
                    WornOutTextureView()
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .foregroundStyle(Color.white)
        })
        
    }
}


struct PulsingToggleStyle: ToggleStyle {

    var systemImageActive: String = "checkmark"
    var systemImageNonActive:String = "xmark"
    var activeColor: Color = .red.opacity(0.6)
    var nonCustom = true

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : Color(.systemGray))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .overlay {
                            if(configuration.isOn || nonCustom){
                                Image(systemName: configuration.isOn ? systemImageActive : systemImageNonActive)
                                    .foregroundColor(configuration.isOn ? activeColor : Color(.systemGray5))
                            }else{
                                Image(systemImageNonActive)
                                    .foregroundColor(configuration.isOn ? activeColor : Color(.systemGray5))
                            }
                        }
                        .offset(x: configuration.isOn ? 14 : -14)

                }
                .frame(width: 60, height: 35)
                .onTapGesture {
                    withAnimation(.smooth(duration: 0.2)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}

struct BorderedBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 3))
            )
            .background(
                ZStack {
                    Color.gray.opacity(0.3)
                }
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
}

extension View {
    func borderedBackground() -> some View {
        self.modifier(BorderedBackgroundModifier())
    }
}

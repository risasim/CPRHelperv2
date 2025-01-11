//
//  FreqSpeedView.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//

import SwiftUI

import SwiftUI
///Shows the current doing of the user with text and with the speedometer.
struct FreqSpeedView: View {
    
    @Binding var value:Int //default value of spedometer
    @Binding var status:StatusSpeed
    
    var body: some View {
        ZStack {
            //Color.black
            VStack {
                SpeedGaugeView(coveredRadius: 225, maxValue: 150, steperSplit: 20, value: $value,status:$status)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Needle: Shape { //create the red needle shape
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height / 2))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}

struct SpeedGaugeView: View {
    
    func colorMix(percent: Int) -> Color {
        let p = Double(percent) / 100.0 // Normalize percent to a 0.0–1.0 range
        let g: Double
        if p <= 0.5 {
            g = p * 2 // Linearly increase from 0 to 1 as p goes from 0.0 to 0.5
        } else {
            g = (1 - p) * 2 // Linearly decrease from 1 to 0 as p goes from 0.5 to 1.0
        }
        let r: Double
        if p <= 0.5 {
            r = 1 - p // Linearly decrease from 1 to 0.5 as p goes from 0.0 to 0.5
        } else {
            r = p // Linearly increase from 0.5 to 1 as p goes from 0.5 to 1.0
        }
        return Color.init(red: r, green: g, blue: 0)
    }
    
    func tick(at tick: Int, totalTicks: Int) -> some View { //this function sets the small and big dashes just like in a spedometer
        let percent = (tick * 100) / totalTicks //get percent for color mix
        let startAngle = coveredRadius / 2 * -1
        let stepper = coveredRadius / Double(totalTicks) //if its 0 to 100 in steps of 10, it will show 0, 10, 20, 30, ... 100.
        let rotation = Angle.degrees(startAngle + stepper * Double(tick)) //get the rotation angle in degrees using the start angle, stepper, and tick
        return VStack { //a VStack that rotates its views with rotationEffect
            Rectangle()
                .fill(colorMix(percent: percent))
                .frame(width: tick % 2 == 0 ? 3 : 2,
                       height: tick % 2 == 0 ? 5 : 3) //flip between small and big dash
            Spacer()
        }.rotationEffect(rotation)
    }
    
    func tickText(at tick: Int, text: String) -> some View {
        let percent = (tick * 100) / tickCount //get percentage for applying color mix
        let startAngle = coveredRadius / 2 * -1 + 90 //get start angle for reference on rotation
        let stepper = coveredRadius / Double(tickCount) //amount of space between each text values
        let rotation = startAngle + stepper * Double(tick) //calculate rotation
        return Text(text).font(.system(size: 15)).foregroundColor(colorMix(percent: percent)).rotationEffect(.init(degrees: -1 * rotation), anchor: .center).offset(x: -73, y: 0).rotationEffect(Angle.degrees(rotation)) //set the text values with the corresponding rotation value and offset the x value so they are aligned with the dashes
    }
    
    let coveredRadius: Double //0 - 360°
    let maxValue: Int
    let steperSplit: Int
    
    private var tickCount: Int {
        return maxValue / steperSplit
    }
    
    @Binding var value: Int
    @Binding var status:StatusSpeed
    
    var body: some View {
        ZStack {
            Text(status.rawValue.capitalized) //for spedometer value shown in middle
                .font(.system(size: 20, weight: Font.Weight.bold))
                .foregroundColor(Color.orange)
                .offset(x: 0, y: 40)
            ForEach(0..<tickCount * 2 + 1) { tick in //this loop sets the dashes
                self.tick(at: tick,
                          totalTicks: self.tickCount * 2)
            }
            ForEach(0..<tickCount + 1) { tick in //this loop sets the text values like: 0, 10, 20, ... around the spedometer
                self.tickText(at: tick, text: "\((self.steperSplit * tick)+40)")
            }
            Needle() //red needle directing the speed
                .fill(Color.red)
                .frame(width: 65, height: 6)
                .offset(x: -30, y: 0)
                .rotationEffect(.init(degrees: getAngle(value: Double(value))), anchor: .center) //get the value set in the main view
                .animation(.linear,value: value)
            Circle() //rotation point of needle, simple circle
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
        }.frame(width: 120, height: 120, alignment: .center).padding(.bottom,-55) //frame of guage
    }
    
    func getAngle(value: Double) -> Double { //function that gets the angle with the specified value and sets it to the needle
        var newVal = value-40
        if(newVal<150 && newVal>0){
            return (newVal / Double(maxValue)) * coveredRadius - coveredRadius / 2 + 90
        }else if(newVal>150){
            return (150 / Double(maxValue)) * coveredRadius - coveredRadius / 2 + 90
        }else{
            return (0 / Double(maxValue)) * coveredRadius - coveredRadius / 2 + 90
        }
    }
}

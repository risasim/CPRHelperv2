//
//  Untitled.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import SwiftUI

///Model for the resuscitation "simulation"
class FreqModel:ObservableObject{
    private var startTimeStamp:Date
    private var timer:Timer?
    private var timeStamps:[Date]
    private let generator = UINotificationFeedbackGenerator()
    
    ///Show the GaugeView
    @Published var show:Bool = false
    ///Showing the results
    @Published var showResults:Bool = false
    ///Status of the speedometer
    @Published var stat:StatusSpeed = .start
    ///Frequency with second in a tuple in array
    @Published var avgsPerSeconds:[(Int,Int)]=[]
    ///Average so far for the estimation of the push/min
    @Published var averageSoFar:Int = 0
    ///Seconds past from start
    @Published var secs:Double = 0.0
    ///If the game is started
    @Published var started:Bool = false
    ///Last push frequency
    @Published var lastFreq:Int = 0
    ///Average of last two seconds, for the speeedometer
    @Published var avgOfLastTwo:Int = 0
    ///The period of the last two pushes, used to wait before recalc
    private var lastTimeDiff:Double = 2.0
    ///How long the "simulation" should run
    private var interval = 60.0
    ///Keep the track of the timestamps with frequencies
    private var dateWithFreqs:[(Date,Int)] = []
    
    init(startTimeStamp: Date = Date(), timer: Timer? = nil, timeStamps: [Date]=[]) {
        self.startTimeStamp = startTimeStamp
        self.timer = timer
        self.timeStamps = timeStamps
        
    }
    
    ///Starts the demo, initializes all variables and create the first timestamp.
    public func startDemo(){
        resetVars()
        startTimeStamp = Date()
        timeStamps.append(startTimeStamp)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] timer in
            self.secs+=0.1
            self.evalData()
            //HROZNE SKACE ASI BUDE POTREBA POSUNOUT INTERVAL POCITANI AVG OF LAST TWo
            self.status()
            self.getAverageSoFar()
            if(!show && secs>=15.0){
                show = true
            }
            self.checkEnd(timer)
            
        }
        self.started = true
    }
    ///Create a new timestamp and triggers all of the functions for the new calculations. If the game is not started it does start it.
    public func push(){
        if(started){
            timeStamps.append(Date())
            recalculate()
            generator.notificationOccurred(.success)
        }else{
            self.startDemo()
        }
    }
    ///Evaluates the data, by taking the number of push happened on the
    private func evalData(){
        var res:[(Int, Int)]=[]
        var counter = 0
        for i in 0...Int(interval){
            if(dateWithFreqs.count-1>1){
                var sum = 0
                var counter = 0
                for t in 1...dateWithFreqs.count-1{
                    if(self.dateWithFreqs[t].0>=startTimeStamp+Double(i) && self.dateWithFreqs[t].0 < startTimeStamp+Double(i)+1.0){
                        sum+=self.dateWithFreqs[t].1
                        counter+=1
                    }else if(self.dateWithFreqs[t].0>=startTimeStamp+Double(i)+1.0){
                        break
                    }
                }
                if (counter != 0){
                    res.append((i,Int(sum/counter)))
                }else{
                    res.append((i,0))
                }
            }else{
                res.append((i,0))
            }
            
        }
        avgsPerSeconds = res
        getAverageSoFar()
    }
    ///Recalculates all of the variables that are associated witht the push
    private func recalculate(){
        self.lastTimeDiff = timeStamps[timeStamps.count-1] - timeStamps[timeStamps.count-2]
        self.lastFreq = Int(pow(lastTimeDiff/60, -1))
        self.dateWithFreqs.append((timeStamps[timeStamps.count-1],lastFreq))
        evalData()
    }
    ///Set the status based on the values of the averagesPerSecs
    private func status(){
        if(secs>3){
            avgOfLastTwo = (avgsPerSeconds[Int(secs)-1].1+avgsPerSeconds[Int(secs)-2].1)/2
            if(avgOfLastTwo<=120 && avgOfLastTwo >= 100){
                self.stat = .right
            }else if(avgOfLastTwo>120){
                self.stat = .slower
            }else{
                self.stat = .faster
            }
        }
    }
    ///Checks if simulation ended, time based on the interval
    private func checkEnd(_ timer: Timer){
        if (self.secs >= interval) {
            timer.invalidate()
            self.timeStamps.append(Date())
            self.recalculate()
            self.started = false
            self.showResults = true
        }
    }
    ///Do average from the seconds that passed
    private func getAverageSoFar(){
        print("got here")
        if(Int(secs) >= 2){
            var sum = 0
            for i in 0..<Int(self.secs)-1{
                sum+=avgsPerSeconds[i].1
            }
            print(Int(Double(sum)/Double(Int(self.secs-1.0))))
            averageSoFar = Int(Double(sum)/Double(Int(self.secs-1.0)))
        }else{
            averageSoFar = 0
        }
    }
    ///Reset all of the variables
    private func resetVars(){
        timer = nil
        timeStamps = []
        show = false
        showResults = false
        stat = .start
        avgsPerSeconds=[]
        averageSoFar = 0
        secs = 0.0
        started = false
        lastFreq = 0
        avgOfLastTwo = 0
        lastTimeDiff = 2.0
        interval = 60.0
        dateWithFreqs = []
    }
}


extension Date {
    ///Add the - operator for date for easier readibilty
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}

enum StatusSpeed:String{
    case faster,right,slower,start
}

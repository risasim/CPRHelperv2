//
//  HistoryVie.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import SwiftUI

///View depicting the CPR history, simple stylized text with images
struct HistoryView:View {
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
                //
            } label: {
                Text("Take quiz")
                    .padding()
            }
            .buttonStyle(.plain)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.tertiary)
            }

        }
        .padding(.horizontal)
    }
}

let history:LocalizedStringResource = """
Cardiopulmonary resuscitation (CPR) has evolved significantly over centuries, integrating various techniques to enhance its effectiveness.

**Early Techniques**

In the 18th century, methods like artificial ventilation gained prominence. In 1732, Scottish surgeon William A. Tossach successfully used mouth-to-mouth resuscitation on a coal miner, marking one of the earliest documented cases of successful CPR in an adult. This event was widely witnessed and later published, influencing medical practices of the time. 

The first organized effort to respond to sudden death emerged in 1767 with the formation of the Society for the Recovery of Drowned Persons in Amsterdam. This society recommended various resuscitation techniques, including mouth-to-mouth ventilation, warming the victim, and even rectal fumigation with tobacco smoke. Their methods reportedly saved over 150 individuals within four years, inspiring similar organizations across Europe and the United States. 
[Society for the Recovery of Drowned Persons](https://en.wikipedia.org/wiki/History_of_cardiopulmonary_resuscitation#Formation_of_rescue_societies)

**Advancements in Defibrillation**

In 1775, Danish physician Peter Christian Abildgaard conducted experiments demonstrating that electrical shocks could revive lifeless animals, laying the groundwork for modern defibrillation techniques. Later, in 1792, English physician James Curry noted the distinction between absolute death and apparent death, emphasizing that the latter could be reversed through appropriate interventions, including external defibrillation.
[Wikipedia](https://en.wikipedia.org/wiki/History_of_cardiopulmonary_resuscitation#Electrical_shocks)

"""

let history2:LocalizedStringKey = """
**Modern CPR Development**

The 20th century witnessed significant advancements in CPR. In the 1950s, the combination of chest compressions and rescue breaths became standardized, forming the basis of modern CPR. The American Heart Association (AHA) played a pivotal role by developing science-based CPR guidelines and leading in first aid, CPR, and AED training. 

Over time, CPR guidelines have evolved to improve survival rates and outcomes. The AHA regularly updates these guidelines to reflect the latest scientific research and best practices, ensuring that responders provide the most effective care during cardiac emergencies. 
 [American Heart Association (AHA)](https://cpr.heart.org/)

Today, CPR is a fundamental skill taught worldwide, emphasizing the importance of immediate intervention in cardiac arrest situations to increase the chances of survival.
"""

#Preview {
    NavigationStack{
        HistoryView()
    }
}

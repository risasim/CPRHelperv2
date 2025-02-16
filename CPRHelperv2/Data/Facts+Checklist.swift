//
//  Facts+Checklist.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import SwiftUI

let checklist = ["Safe to approach","Consciousness","Breathing","Cleared airways","Call"]

let phoneNumbers:[String] = [
    // Global Standard Emergency Numbers
    "112",

    // Europe
    "110", "115", "118", "122", "123", "144", "150", "155", "158", "160", "197", "199",

    // North America
    "911",

    // South America
    "190", "192", "193", "105",

    // Asia
    "119", "120", "100", "101", "102", "103", "108", "175",

    // Africa
    "10111", "10177", "12", "177",

    // Oceania
    "000", "111",

    // Middle East & Additional Regions
    "997","130", "140"
]

//OnBoarding
let onboarding1:LocalizedStringResource = """
Welcome to CPR Helper. My name is Richard, and I created this app to educate users on how to perform CPR and, in case of an unfortunate event, possibly even help them. The app consists of two main elements:
"""

let onboarding2 = """
This view will assist you in case of an emergency.
"""

let onboarding3 = """
And a practice part that will try to prepare you for such an event. Better to be safe than sorry.
"""

//HistoryView
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


//HowToCPR view
let cprGuidePart1:LocalizedStringResource = """
**1. Check the Scene** – Ensure the area is safe before approaching the person.  

**2. Check Responsiveness** – Tap the person and shout, *"Are you okay?"* If there is no response, proceed. 

**3. Call for Help** – Dial emergency services (e.g., **112** in Europe, **911** in the U.S., you can set the default emergency number in the settings). If others are around, ask someone to get an **AED** (Automated External Defibrillator).  

**4. Check for Breathing** – Look, listen, and feel for normal breathing for no more than **10 seconds**. If the person is not breathing or only gasping, start CPR.  
"""
let  cprGuideAirways:LocalizedStringResource = """
**5. Open the Airway** – Tilt the head back and lift the chin to prevent the tongue from blocking the airway.
"""
let checklistExplain = "So far, you can find these steps in the Checklist located in the Emergency section of this app. A check indicates whether something should be present or not. The Checklist is interactive."
let cprGuidePart3:LocalizedStringResource = """
**6. Give Chest Compressions** –
    - Place both hands in the center of the chest.
    - Push hard and fast (*5-6 cm deep*). Do not be afraid to push, even if you hear some ribs breaking, at a rate of *100-120 compressions per minute*.
    - Allow the chest to fully recoil between compressions.

**7. Rescue Breaths (if trained)** 
    - Pinch the nose, give **two breaths**, ensuring the chest rises.
    - Continue with **30 compressions**, then **2 breaths**.
    - If unsure, stick to **hands-only CPR** (continuous compressions).
"""
let cprGuidePart2:LocalizedStringResource = """
**8. Use an AED (if available)** – Follow its voice instructions.  

**9. Continue CPR** – Do not stop until medical help arrives or the person starts breathing.  
"""

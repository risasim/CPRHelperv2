//
//  Facts+Checklist.swift
//  CPRHelperv2
//
//  Created by Richard Šimoník on 11.01.2025.
//
import Foundation
import SwiftUI

let checklist = ["Safe to approach","Consciousness","Breathing","Cleared airways","Call"]

let heartFacts = [ Text("Heart pumps about 2,000 gallons of blood daily"),
                   Text("Heart beats about 100,000 times a day"),
                   Text("Heart has its own electrical system"),
                   Text("Heart can continue beating even when separated from the body")]
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
    "119", "110", "120", "122", "100", "101", "102", "103", "108", "175",

    // Africa
    "10111", "10177", "997", "190", "12", "177",

    // Oceania
    "000", "111",

    // Middle East & Additional Regions
    "997","130", "140"
]
let onboarding1:LocalizedStringResource = """
Welcome to CPR Helper. My name is Richard and I have created this app to educate users on how to perform CPR and in case of an unfortune event even possible help them. The app consists of two main elements:
"""

let onboarding2 = """
The emergency view that will help you in case of neeed of CPR:
"""

let onboarding3 = """
And a practice part that will try to prepare you for such an event. Better to be safe than sorry.
"""

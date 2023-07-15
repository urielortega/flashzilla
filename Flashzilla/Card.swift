//
//  Card.swift
//  Flashzilla
//
//  Created by Uriel Ortega on 13/07/23.
//

import Foundation

struct Card: Codable, Equatable, Identifiable {
    var id = UUID()
    
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

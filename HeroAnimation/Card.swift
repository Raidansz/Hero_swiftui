//
//  Card.swift
//  HeroAnimation
//
//  Created by Raidan on 13/07/2024.
//

import SwiftUI

struct Card: Identifiable{
    var id: String = UUID().uuidString
    var cardImage: String
    var rotation: CGFloat = 0
}


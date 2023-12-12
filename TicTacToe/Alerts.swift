//
//  Alerts.swift
//  TicTacToe
//
//  Created by Thomas Garayua on 12/12/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win!"),
                                    message: Text("You got it!"),
                                    buttonTitle: Text("Hell Yeah!"))
    
    static let computerWin = AlertItem(title: Text("You Lose!"),
                                       message: Text("Looks like the computer wins"),
                                       buttonTitle: Text("Rematch!"))
    
    static let draw = AlertItem(title: Text("Draw!"),
                                message: Text("What a great battle"),
                                buttonTitle: Text("Try Again"))
}


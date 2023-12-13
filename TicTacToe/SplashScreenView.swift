//
//  SplashScreenView.swift
//  TicTacToe
//
//  Created by Thomas Garayua on 12/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                GameView()
            } else {
                if colorScheme == .dark {
                    Image("light mode sky")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                } else {
                    Image("darkModeSky")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                
                VStack {
                    Image("TicTacToeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

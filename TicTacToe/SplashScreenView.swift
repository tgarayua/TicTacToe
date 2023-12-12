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
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            GameView()
        } else {
            VStack {
                VStack {
                    Image("TicTacLogo")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("Tic Tac Toe")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .background(colorScheme == .dark ? .black : .white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
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

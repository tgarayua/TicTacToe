//
//  GameView.swift
//  TicTacToe
//
//  Created by Thomas Garayua on 12/12/23.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
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
                    
                    LazyVGrid(columns: viewModel.columns, spacing: 5) {
                        ForEach(0..<9) { index in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                PlayerIndicator(systemImageName: viewModel.moves[index]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: index)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isGameboardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame()}))
                }
            }
        }
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.red).opacity(0.5)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

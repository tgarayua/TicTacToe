//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Thomas Garayua on 12/12/23.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for postion: Int) {
        if isSquareOccupied(in: moves, forIndex: postion) { return }
        moves[postion] = Move(player: .human, boardIndex: postion)
        
        
        // check for win condtion or draw
        if checkWinCondtion(for: .human, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameboardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPostion = determineComputerMovePostion(in: moves)
            moves[computerPostion] = Move(player: .computer, boardIndex: computerPostion)
            isGameboardDisabled = false
            
            if checkWinCondtion(for: .computer, in: moves) {
                alertItem = AlertContext.computerWin
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePostion(in moves: [Move?]) -> Int {
        
        // if AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPostions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPostions = pattern.subtracting(computerPostions)
            
            if winPostions.count == 1 {
                let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPostions.first!)
                if isAvaiable { return winPostions.first! }
            }
        }
        
        // If AI can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPostions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPostions = pattern.subtracting(humanPostions)
            
            if winPostions.count == 1 {
                let isAvaiable = !isSquareOccupied(in: moves, forIndex: winPostions.first!)
                if isAvaiable { return winPostions.first! }
            }
        }
        
        // If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
        
        var movePostion = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePostion) {
            movePostion = Int.random(in: 0..<9)
        }
        return movePostion
    }
    
    func checkWinCondtion(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPostions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPostions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

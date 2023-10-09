//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andy C on 7/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var choices = ["✊", "✋", "✌️"]
    @State private var gameChoice = "Guess what I'll choose"
    @State private var randomChoice = Int.random(in: 0..<3)
    @State private var userChoice = ""
    
    @State private var gameScore:Int = 0
    @State private var userScore:Int = 0
    @State private var addedScore:Int = 0
    
    var body: some View {
        Text("Game")
            .font(.largeTitle.weight(.bold))
        
        Text("\(gameChoice)")
            .font(.title)
            .padding(.bottom)
            .padding(.init(top: 5, leading: 0, bottom: 60, trailing: 0))
        
        Text("Player")
            .font(.largeTitle.weight(.bold))
        
        Text("Your last choice: \(userChoice)")
            .font(.title3)
            .padding(.init(top: 5, leading: 0, bottom: 0, trailing: 0))
        
        HStack {
            ForEach(0..<3) { num in
                    Button(choices[num]) {
                        gameChoice = choices[randomChoice]
                        userChoice = "\(choices[num])"
                        userChoiceTapped()
                    }
                    .frame(width: 80, height: 80)
                    .font(.largeTitle)
                    .background(Color.secondary)
                    .clipShape(Circle())
                    .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
        }
        .padding(.init(top: 0, leading: 0, bottom: 50, trailing: 0))
        
        
        HStack {
            VStack {
                Text("Game Score")
                    .font(.title3)
                Text("\(gameScore)")
                    .font(.title3)
            }
            .padding()
            
            VStack {
                Text("User Score")
                    .font(.title3)
                Text("\(userScore)")
                    .font(.title3)
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Reset", role: .destructive, action: resetScore)
            // Button("Continue", action: keepPlaying) // commented since it functions same as cancel
        } message: {
            Text("Your choice: \(userChoice)")
        }
    }
    
    // function for calculating score
    func userChoiceTapped() {
        if gameChoice == userChoice {
            scoreTitle = "Tie"
        } else if (gameChoice == "✊" && userChoice == "✋") || (gameChoice == "✌️" && userChoice == "✊") || (gameChoice == "✋" && userChoice == "✌️"){
            scoreTitle = "You Win!"
            addedScore = 5
            userScore += 5
        } else {
            scoreTitle = "You Lose"
            addedScore = 0
            gameScore += 5
        }
        
        showingScore = true
    }
    
    // function to re-shuffle
    func keepPlaying() {
        gameChoice = "Guess what I'll choose"
        randomChoice = Int.random(in: 0..<3)
    }
    
    // function for resetting score to 0
    func resetScore() {
        userScore = 0
        gameScore = 0
        gameChoice = "Guess what I'll choose"
        randomChoice = Int.random(in: 0..<3)
    }
}

#Preview {
    ContentView()
}

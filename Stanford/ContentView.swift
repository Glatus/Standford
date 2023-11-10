//
//  ContentView.swift
//  Stanford
//
//  Created by iosdev on 8.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State var currentEmojis: [String] = []
    let emojis = [["🦆","🦉","🦇","🦅","🦦","🦥","🦡","🦤"],
                         ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇",],
                         ["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉",]]
    @State var theme = 0
    @State var cardCount = 0
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangers
            cardCountAdjusters
        }
        .padding()
        
        
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: currentEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeChangers: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<3) { setIndex in
                themeButtons(setIndex: setIndex)
            }
        }
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
        
    }
    
    func shuffledDeck() {
        let shuffledEmojis = emojis[theme].shuffled()
        var finalEmojis = [String]()
        
        for emoji in shuffledEmojis {
            for _ in 0..<2 {
                finalEmojis.append(emoji)
            }
        }
        currentEmojis = finalEmojis.shuffled()
        cardCount = currentEmojis.count
        
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > currentEmojis.count)
    }
    
    func themeButtons(setIndex: Int) -> some View {
        Button(action: {
            theme = setIndex
            cardCount = currentEmojis.count
            shuffledDeck()
        }, label: {
            switch setIndex {
            case 0:
                VStack {
                    Image(systemName: "bird.fill")
                    Text("Bird").font(.caption)
                }
            case 1:
                VStack {
                    Image(systemName: "carrot.fill")
                    Text("Food").font(.caption)
                }
            case 2:
                VStack {
                    Image(systemName: "soccerball")
                    Text("Balls").font(.caption)
                }
            default:
                VStack {
                    Image(systemName: "ant.fill")
                    Text("BUG").font(.caption)
                }
            }
        })
        .imageScale(.large)
    }
}
struct CardView: View {
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.gray)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

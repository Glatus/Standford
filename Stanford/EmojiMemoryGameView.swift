//
//  EmojiMemoryGameView.swift
//  Stanford
//
//  Created by iosdev on 8.11.2023.
//
// View

import SwiftUI

struct EmojiMemoryGameView: View {
    @State var currentEmojis: [String] = []
    @ObservedObject var viewModel: EmojiMemoryGame
    //let emojis = [["🦆","🦉","🦇","🦅","🦦","🦥","🦡","🦤"],
    //["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇",],
    //["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉",]]
    
    @State var theme = 0
    @State var cardCount = 0
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            Spacer()
            themeChangers
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 0)],spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
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
        }, label: {
            switch setIndex {
            case 0:
                
                LazyVStack {
                    Image(systemName: "bird.fill")
                    Text("Bird")
                }
            case 1:
                LazyVStack {
                    Image(systemName: "carrot.fill")
                    Text("Food")
                }
            case 2:
                LazyVStack {
                    Image(systemName: "soccerball")
                    Text("Balls")
                }
            default:
                LazyVStack {
                    Image(systemName: "ant.fill")
                    Text("BUG")                }
            }
        })
        .font(.footnote)
        .imageScale(.large)
    }
}
struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.gray)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

//
//  ContentView.swift
//  Stanford
//
//  Created by iosdev on 8.11.2023.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = [["🦆","🦉","🦇","🦅","🦦","🦥","🦡","🦤"],["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇",],["⚽️","🏀","🏈","⚾️","🥎","🎾","🏐","🏉",]]
    @State var theme: Int = 0
    @State var cardCount: Int = 6
    
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
        .onAppear() {
            
        }
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
            ForEach(0..<cardCount, id: \.self) {
                index in CardView(content: emojis[theme][index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    func themeButtons(setIndex: Int) -> some View {
        Button(action: {
            theme = setIndex
        }, label: { Image(systemName: "smiley")
        })
        .imageScale(.large)
    }
    
    var themeChangers: some View {
        HStack {
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
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

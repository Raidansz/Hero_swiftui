//
//  ContentView.swift
//  HeroAnimation
//
//  Created by Raidan on 13/07/2024.
//

import SwiftUI

struct ContentView: View {
    @State var cards: [Card] = [
        .init(cardImage: "Card1"),
        .init(cardImage: "Card2")
    ]
    
    @Namespace var animation
    @State var selectedCard: Card?
    @State var showDetail: Bool = false
    @State var showDetailContent: Bool = false
    @State var showExpenses: Bool = false
    
    var body: some View {
        
        CardsScrollView()
                .overlay {
                    if let selectedCard,showDetail{
                        DetailView(card: selectedCard)
                            .transition(.asymmetric(insertion: .identity, removal: .offset(y: 1)))
                    }
                }
                .background(Color(.black))
    }
    
    @ViewBuilder
    func CardsScrollView()->some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15){
                ForEach(cards){card in
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        if selectedCard?.id == card.id && showDetail{
                            Rectangle()
                                .fill(.clear)
                                .frame(width: size.width, height: size.height)
                        }else{
                            Image(card.cardImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: card.id, in: animation)

                                .frame(width: size.width, height: size.height)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                                        selectedCard = card
                                        showDetail = true
                                    }
                                }
                        }
                    }
                    .frame(width: 300)
                }
            }
            .padding(15)
            .padding(.leading,20)
        }
    }
    
    @ViewBuilder
    func DetailView(card: Card)->some View{
        VStack{
            HStack{
                Button {


                    withAnimation(.easeOut(duration: 0.5)){
                        showExpenses = false
                    }
                    withAnimation(.easeOut.delay(0.1)){
                        showDetail = false
                    }

                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Text("Dismiss")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            .padding(.bottom,15)
            .opacity(showDetailContent ? 1 : 0)
            
            Image(card.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: card.id, in: animation)
           
                .frame(height: 220)
            
        }
        .padding(15)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)){
                showDetailContent = true
            }
            withAnimation(.easeInOut.delay(0.1)){
                showExpenses = true
            }
        }
    }

    }

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  PaperScissorsRock
//
//  Created by Baymurat Abdumuratov on 03/02/24.
//

import SwiftUI




struct StyleImage: View {
    let image: String
    let height: CGFloat
    let width: CGFloat
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: width, height: height)
            .clipShape(.rect(cornerRadius: 20))
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                
               
                                        .stroke(Color.white, lineWidth: 5)
                            
            }
            
    }
}

struct TextRoundScore: View{
    var round: Int
    var score: Int
    var customColor: UIColor
    
    var body: some View{
        HStack(){
            
            Text("Round: \(round) |")
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text("Score: \(score)")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color(customColor))
        .clipShape(.rect(cornerRadius: 50))
        .overlay {
            RoundedRectangle(cornerRadius: 53)
                .stroke(Color.white, lineWidth: 4)
        }
    }
}

struct StackModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 20))
            }
}

struct ContentView: View {
   
    let elements = ["paper", "rock", "scissors"]
    let outcome = ["WIN", "LOSE"]
    @State var score = 0
    @State var round = 0
    @State var elementForComparison: String  = ""
    @State var randomElement = ""
    @State var outcomeRandom = ""
    let customColor = #colorLiteral(red: 0.9988586307, green: 0.9143176675, blue: 0.01133282762, alpha: 1)
    let title = "Your game is over"
    @State var showingScore = false
    
   
 
    var body: some View {
      
        ZStack{
            AngularGradient(gradient: Gradient(colors: [Color.green, Color.blue]), center: .center, angle: .degrees(180))
                .ignoresSafeArea()
            
            
            VStack{
                
                Spacer()
                Text("Paper, Rock and Scissors")
                
                    .font(.largeTitle)
               
                VStack(spacing: 15){
                    Text("Computer chose this:")
                        .font(.title)
                    
                    StyleImage(image: randomElement, height: 200, width: 200)   //randomElement
    

                    Spacer()
                    Text(outcomeRandom)
                        .font(.title)
                        .bold()
                        .padding()
                        .padding(.horizontal, 40)
                        .background(outcomeRandom == "LOSE" ? .red : .green)
                        .cornerRadius(20)
                    
                       
                    Spacer()
                    
                    HStack{
                        Button {
                            chekingOutcome(outcomeRandom)
                            
                            if round == 10{
                                showingScore = true
                            }
                        } label: {
                            StyleImage(image: elements[0], height: 100, width: 100)

                        }
                        
                        Button {
                            chekingOutcome(outcomeRandom)
                            if round == 10{
                                showingScore = true
                            }
                            
                        } label: {
                            StyleImage(image: elements[1], height: 100, width: 100)
                        }

                        Button {
                            chekingOutcome(outcomeRandom)
                            if round == 10{
                                showingScore = true
                            }
                            
                        } label: {
                            StyleImage(image: elements[2], height: 100, width: 100)

                        }


                    }
                    Spacer()
                }
                .stackStyle()
                
                Spacer()
                Spacer()
                
                TextRoundScore(round: round, score: score, customColor: customColor)
            }
            .alert(isPresented: $showingScore, content: getAlert)
        }
        
        .onAppear(){
            generateRandomElements()
        }
    }
    
    func getAlert() -> Alert{
        return Alert(
            title: Text("Game is over"),
            message: Text("You gained \(score) points"),
            dismissButton: .default(Text("Restart"), action: {
                score = 0
                round = 0
            }))
    }
    
    func generateRandomElements(){
        randomElement = elements.randomElement() ?? ""
        outcomeRandom = outcome.randomElement() ?? ""
        
        
    }
    
    func chekingOutcome(_ outcome: String){
        if outcome == "WIN"{
            score += 1
            round += 1
            }else{
            score += 0
            round += 1
        }
        generateRandomElements()
    }
    
}

extension View{
    func stackStyle() -> some View{
        modifier(StackModifier())
    }
}

#Preview {
    ContentView()
}

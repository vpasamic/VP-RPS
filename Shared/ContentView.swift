import SwiftUI

struct ContentView: View {
    @State private var options = ["🪨", "📄", "✂️", "🦎", "🖖"]
    @State private var appChoice: Int?
    @State private var shouldWin = Bool.random()
    @State private var playerChoice = 0
    @State private var score = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("RPSLS")
                .font(.largeTitle)
            
            Text("Score: \(score)")
            
            if let appChoice = appChoice {
                Text("App's previous choice: \(options[appChoice])")
                Text("Player choice: \(options[playerChoice])")
            }
            
            HStack {
                ForEach(0..<5) { index in
                    Button(action: {
                        self.playerChoice = index
                        self.appChoice = Int.random(in: 0..<5)
                        self.checkResult()
                    }) {
                        Text(self.options[index])
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            
            
            Image("rules")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 300)
        }
    }
    
    func checkResult() {
        let appWins = [
            (0, 2),
            (0, 3),
            (1, 0),
            (1, 4),
            (2, 1),
            (2, 3),
            (3, 1),
            (3, 4),
            (4, 0),
            (4, 2)
        ]
        
        let playerWins = [
            (0, 1),
            (0, 4),
            (1, 2),
            (1, 3),
            (2, 0),
            (2, 4),
            (3, 0),
            (3, 2),
            (4, 1),
            (4, 3)
        ]
        
        if playerChoice == appChoice {
            score += 0 // Tie, no points awarded
        } else if shouldWin {
            if appWins.contains(where: { $0 == (appChoice!, playerChoice) }) {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if playerWins.contains(where: { $0 == (playerChoice, appChoice!) }) {
                score += 1
            } else {
                score -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

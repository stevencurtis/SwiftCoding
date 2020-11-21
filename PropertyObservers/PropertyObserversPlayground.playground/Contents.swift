import UIKit

class Game {
    var playerOneScore: Int = 0 {
        willSet(score) {
            print ("Player one's score will be \(score)")
        }
        
        didSet(oldScore) {
            print ("Player one's score was \(oldScore)")
            print ("Player one's score is now \(playerOneScore)")
        }
    }
    
    var playerTwoScore: Int = 0 {
        willSet(score) {
            print ("Player two's score will be \(score)")
        }
        
        didSet(oldScore) {
            print ("Player two's score was \(oldScore)")
            print ("Player two's score is now \(playerTwoScore)")
        }
    }
}

let initialGame = Game()
initialGame.playerOneScore = 1
print (initialGame.playerOneScore)
initialGame.playerOneScore = 1

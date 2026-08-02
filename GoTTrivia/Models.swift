import Foundation

struct TriviaQuestion {
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
}

let triviaQuestions = [
    TriviaQuestion(
        question: "What is the motto of House Stark?",
        options: ["Fire and Blood", "Winter is Coming", "We Do Not Sow", "Ours is the Fury"],
        correctAnswerIndex: 1
    ),
    TriviaQuestion(
        question: "Who is the King of the Seven Kingdoms at the start of the series?",
        options: ["Robert Baratheon", "Rhaegar Targaryen", "Aerys II Targaryen", "Joffrey Baratheon"],
        correctAnswerIndex: 0
    ),
    TriviaQuestion(
        question: "What is the currency of Westeros?",
        options: ["Gold Dragon", "Silver Stag", "Copper Penny", "All of the above"],
        correctAnswerIndex: 3
    ),
    TriviaQuestion(
        question: "Which house words are 'Ours is the Fury'?",
        options: ["House Baratheon", "House Targaryen", "House Lannister", "House Tyrell"],
        correctAnswerIndex: 0
    ),
    TriviaQuestion(
        question: "What is Daenerys Targaryen's title?",
        options: ["Queen of the North", "Mother of Dragons", "Breaker of Chains", "Both B and C"],
        correctAnswerIndex: 3
    ),
    TriviaQuestion(
        question: "Who sits on the Iron Throne at the start?",
        options: ["Robert Baratheon", "Aerys II Targaryen", "Joffrey Baratheon", "Daenerys Targaryen"],
        correctAnswerIndex: 0
    ),
    TriviaQuestion(
        question: "What are the words of House Lannister?",
        options: ["Winter is Coming", "Hear Me Roar", "We Do Not Sow", "Fire and Blood"],
        correctAnswerIndex: 1
    ),
    TriviaQuestion(
        question: "What is the seat of House Stark?",
        options: ["Winterfell", "The Eyrie", "Casterly Rock", "Dragonstone"],
        correctAnswerIndex: 0
    ),
]

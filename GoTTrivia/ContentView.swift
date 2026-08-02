import SwiftUI

struct ContentView: View {
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var gameOver = false
    @State private var selectedAnswer: Int? = nil
    @State private var answered = false
    @State private var isCorrect = false

    let questions = triviaQuestions.shuffled()

    var currentQuestion: TriviaQuestion {
        questions[currentQuestionIndex]
    }

    var body: some View {
        ZStack {
            // Retro background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.05, blue: 0.15),
                    Color(red: 0.15, green: 0.1, blue: 0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                if gameOver {
                    GameOverView(score: score, total: questions.count) {
                        resetGame()
                    }
                } else {
                    // Header
                    VStack(spacing: 8) {
                        Text("⚔️ GAME OF THRONES TRIVIA ⚔️")
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                            .foregroundColor(.yellow)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)

                        HStack {
                            Text("Score: \(score)")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundColor(.cyan)

                            Spacer()

                            Text("Q: \(currentQuestionIndex + 1)/\(questions.count)")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundColor(.cyan)
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)

                    Spacer()

                    // Question
                    VStack(spacing: 20) {
                        Text(currentQuestion.question)
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.yellow, lineWidth: 3)
                                    .background(Color(red: 0.2, green: 0.15, blue: 0.3))
                            )
                            .padding(.horizontal, 20)

                        // Answer options
                        VStack(spacing: 12) {
                            ForEach(0..<currentQuestion.options.count, id: \.self) { index in
                                AnswerButton(
                                    text: currentQuestion.options[index],
                                    isSelected: selectedAnswer == index,
                                    isCorrect: answered && index == currentQuestion.correctAnswerIndex,
                                    isIncorrect: answered && selectedAnswer == index && index != currentQuestion.correctAnswerIndex,
                                    isAnswered: answered
                                ) {
                                    if !answered {
                                        selectedAnswer = index
                                        answered = true
                                        isCorrect = index == currentQuestion.correctAnswerIndex

                                        if isCorrect {
                                            score += 1
                                        }

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                            nextQuestion()
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    // Feedback
                    if answered {
                        Text(isCorrect ? "✓ CORRECT!" : "✗ WRONG!")
                            .font(.system(size: 24, weight: .bold, design: .monospaced))
                            .foregroundColor(isCorrect ? .green : .red)
                            .padding()
                    }

                    Spacer()
                }
            }
        }
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswer = nil
            answered = false
            isCorrect = false
        } else {
            gameOver = true
        }
    }

    func resetGame() {
        currentQuestionIndex = 0
        score = 0
        gameOver = false
        selectedAnswer = nil
        answered = false
        isCorrect = false
    }
}

struct AnswerButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isIncorrect: Bool
    let isAnswered: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(borderColor, lineWidth: 2)
                        .background(backgroundColor)
                )
        }
        .disabled(isAnswered)
    }

    var borderColor: Color {
        if isAnswered {
            if isCorrect {
                return .green
            } else if isIncorrect {
                return .red
            }
        }
        return isSelected ? .yellow : .cyan
    }

    var backgroundColor: Color {
        if isAnswered {
            if isCorrect {
                return Color(red: 0.1, green: 0.3, blue: 0.1)
            } else if isIncorrect {
                return Color(red: 0.3, green: 0.1, blue: 0.1)
            }
        }
        return Color(red: 0.15, green: 0.12, blue: 0.25)
    }
}

struct GameOverView: View {
    let score: Int
    let total: Int
    let onRetry: () -> Void

    var percentage: Int {
        (score * 100) / total
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("🏆 GAME OVER 🏆")
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(.yellow)

            Text("FINAL SCORE")
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)

            Text("\(score)/\(total)")
                .font(.system(size: 48, weight: .bold, design: .monospaced))
                .foregroundColor(.green)

            Text("\(percentage)%")
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .foregroundColor(.yellow)

            Button(action: onRetry) {
                Text("► PLAY AGAIN ◄")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.yellow, lineWidth: 3)
                            .background(Color(red: 0.2, green: 0.15, blue: 0.3))
                    )
            }
            .padding(.horizontal, 20)
        }
        .padding(20)
    }
}

#Preview {
    ContentView()
}

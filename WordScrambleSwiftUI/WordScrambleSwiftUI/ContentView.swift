//
//  ContentView.swift
//  WordScrambleSwiftUI
//
//  Created by Lahari Ganti on 18.02.20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var isShowingError = false

  var body: some View {
    NavigationView {
      VStack {
        TextField("Enter your word", text: $newWord, onCommit: addNewWord)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
          .autocapitalization(.none)


        List(usedWords, id: \.self) {
          Image(systemName: "\($0.count).circle")
          Text($0)
        }
      }.navigationBarTitle(rootWord)
      .onAppear(perform: startGame)
        .alert(isPresented: $isShowingError) { () -> Alert in
          Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
      }
    }
  }

  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

    guard answer.count > 0 else { return }
    guard isOriginal(word: answer) else {
      wordError(title: "Word used alreaady", message: "Gotta be more original")
      return
    }

    guard isPossible(word: answer) else {
      wordError(title: "Not possible to form this word", message: "Stop the gibberish")
      return
    }

    guard isReal(word: answer) else {
      wordError(title: "Not an english word", message: "C'mon")
      return
    }

    usedWords.insert(answer, at: 0)
    newWord = ""
  }

  func startGame() {
    if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let words = try? String(contentsOf: fileURL) {
        let allWords = words.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "gork"
        return
      }
    }

    fatalError("Could not load start.txt from bundle")
  }

  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word)
  }

  func isPossible(word: String) -> Bool {
    var tempWord = rootWord.lowercased()

    for letter in word {
      if let position = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: position)
      } else {
        return false
      }
    }

    return true
  }

  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }

  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    isShowingError = true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

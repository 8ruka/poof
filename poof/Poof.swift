//
//  Poof.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation

class Poof: ObservableObject {
    let info:Info
    
    var currentLevelIndex: Int = 0
    var currentQuestionIndex: Int = 0
    @Published var currentLevel:Level!
    @Published var currentQuestion:Question!
    @Published var currentQuestionSucceed:Bool = false
 
    init() {
        print("Poof!")
        let path = Bundle.main.path(forResource: "poof", ofType: "json")!
        let json = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        info = try! JSONDecoder().decode(Info.self, from: json)
        goToQuestion()
    }
    
    func questionCompleted() {
        print("Question completed")
        currentQuestionSucceed = true
        let timer = Timer(timeInterval: 1, repeats: false) { (t) in
            self.currentQuestionSucceed = false
            self.currentQuestionIndex += 1
            self.goToQuestion()
        }
        RunLoop.current.add(timer, forMode: .common)
        
    }
    func goToQuestion() {
        currentLevel = info.levels[currentLevelIndex]
        guard currentQuestionIndex < currentLevel.questions.count else{
            levelCompleted()
            return
        }
        currentQuestion = currentLevel.questions[currentQuestionIndex]
    }
    func levelCompleted() {
    print("level completed")
    }
}

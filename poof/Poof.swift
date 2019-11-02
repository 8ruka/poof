//
//  Poof.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation

class Poof: ObservableObject {
   
    let levels: [Level] = [
        Level(backgroundColorR: .hex("FFF5FF"),
              backgroundColorL: .hex("E6FFDC"),
              questions: [
                Question(reciver: "circlegreenface",
                     objects: [
                        Object(name: "circlegreen",
                               target:Target(name:"circledashedlevel1",
                                             point:.zero )),
                        Object(name: "triangleredsmall",target: nil),
                        Object(name: "squarepurple",target: nil),
                ]
                )
        ], levelmonster: "icon1",
           questionmonster: "level1success",
           finalmonster: "level1finish")
            
        
    ]
 
    @Published var currentLevel:Level
    @Published var currentQuestion:Question
 
    init() {
        print("Poof!")
        currentLevel = levels.first!
        currentQuestion = levels.first!.questions.first!
    }
    
    func questionCompleted() {
        print("Question completed")
    }
    
}

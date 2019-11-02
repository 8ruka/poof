//
//  QuestionView.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var poof:Poof
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                Color(poof.currentLevel.backgroundColorL)
                SVG(poof.currentQuestion.reciver,
                over:poof.currentLevel.backgroundColorL)
                    .padding(50)
                ZStack {
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        Group {
                            if object.target != nil {
                                SVG(object.target!.name, over: object.target!.backgroundColor,  at: .scaleFit(3))
                                    .frame(width:100, height:100)
                            }
                        }
                    }
                }
            }
            ZStack {
                Color(poof.currentLevel.backgroundColorR)
                VStack{
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        SVG(object.name,
                            over: self.poof.currentLevel.backgroundColorR,
                            at: .scaleFit(3))
                            .frame(width:100, height:100)
                            .padding(50)
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView().environmentObject(Poof())
    }
}

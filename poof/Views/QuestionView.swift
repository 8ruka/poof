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
    @State var targetFrames : [String:CGRect] = [:]
    @State var objectOffsets : [String:CGSize] = [:]
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                Color(poof.currentLevel.backgroundColorL)
                SVG(poof.currentQuestion.reciver)
                    .padding(50)
                ZStack {
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        Group {
                            if object.target != nil {
                                GeometryReader { geo in
                                    SVG(object.target!.name, at: .scaleFit(3))
                                        .frame(width:100, height:100)
                                        .onAppear(perform: {
                                            self.targetFrames[object.target!.name] = geo.frame(in: .global)
                                        })
                                    
                                }.frame(width:100, height:100)
                               
                            }
                        }
                    }
                }
            }
            ZStack {
                Color(poof.currentLevel.backgroundColorR)
                VStack{
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        GeometryReader  { geo in
                            SVG(object.name, at: .scaleFit(3))
                            .frame(width:100, height:100)
                            .offset(x:self.objectOffsets[object.name]?.width ?? 0,y:self.objectOffsets[object.name]?.height ?? 0)
                            .padding(50)
                            .animation(.easeOut)
                            .zIndex(self.objectOffsets[object.name] != nil ? 1 : 0)
                            .gesture(DragGesture()
                                .onChanged({ (value) in
                                    self.objectOffsets[object.name] = value.translation
                                })
                                .onEnded({ (value) in
                                    self.objectOffsets[object.name] = .zero
                                    let objectFrame = geo.frame(in:.global)
                                    let point = CGPoint(x: objectFrame.minX + value.location.x, y: objectFrame.minY + value.location.y)
                                    
                                    print("point",point)
                                    if let target = object.target{
                                        let frame = self.targetFrames[target.name]!
                                        print("frame",frame)
                                        if frame.contains(point){
                                            self.poof.questionCompleted()
                                        }
                                    }
                                })
                            )
                        }     .frame(width:100, height:100)
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

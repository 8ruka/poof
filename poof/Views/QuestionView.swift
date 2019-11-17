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
    @State var targetCompleted : [String:Bool] = [:]
    var body: some View {
        HStack(spacing: 0){
            ZStack {
                Color(.hex(poof.currentLevel.backgroundColorL))
                ForEach(poof.currentQuestion.recivers){ reciver in
                    SVG(reciver.name, at: .scaleFit(3))
                        .frame(width: reciver.size.width, height: reciver.size.height)
                        .offset(x: reciver.point.x, y: reciver.point.y)
                }
                    .padding(50)
                ZStack {
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        Group {
                            if object.target != nil {
                                GeometryReader { geo in
                                    SVG(object.target!.name, at: .scaleFit(3))
                                        .frame(width: object.target!.size.width, height: object.target!.size.height)
                                        .offset(x: object.target!.point.x, y: object.target!.point.y)
                                        .onAppear(perform: {
                                            let frame = geo.frame(in: .global)
                                            let offsetframe = CGRect(origin: CGPoint(x: frame.minX + object.target!.point.x, y: frame.minY + object.target!.point.y), size: CGSize(width: object.target!.size.width, height: object.target!.size.height))
                                            self.targetFrames[object.target!.name] = offsetframe
                                    
                                            self.targetCompleted[object.target!.name] = false
                                        })
                                    
                                }
                                    .frame(width:100, height:100)
                            }
                        }
                    }
                }
            }
            ZStack {
                Color(.hex(poof.currentLevel.backgroundColorR))
                if poof.currentQuestionSucceed{
                    Lottie(poof.currentLevel.questionmonster)
                }
                VStack{
                    ForEach(poof.currentQuestion.objects, id: \.name) { object in
                        ObjectView(object: object, completedPoint: Binding<CGPoint?>(get: {
                            if let target = object.target{
                                if self.targetCompleted[target.name] == true {
                                    if let frame = self.targetFrames[target.name]{
                                        return CGPoint(x: frame.minX, y: frame.minY)
                                    }
                                }
                            }
                            return nil
                        }, set: { _ in })) { (point) in
                            if let target = object.target{
                                let frame = self.targetFrames[target.name]!
                                print("frame",frame)
                                if frame.contains(point){
                                    self.targetCompleted[object.target!.name] = true
                                    print("target completed!")
                                    if self.questionCompleted() {
                                       self.poof.questionCompleted()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }.edgesIgnoringSafeArea(.all)
    }
    func questionCompleted () -> Bool {
        for completed in self.targetCompleted{
            if !completed.value {
                return false
            }
        }
        return true
    }
    
    
}


struct ObjectView:View {
    let object : Object
    @State var offset : CGPoint? = nil
    @Binding var completedPoint : CGPoint?
    let check : (CGPoint) ->()
    var body: some View {
        GeometryReader  { geo in
            SVG(self.object.name, at: .scaleFit(3))
                .frame(width: self.object.size.width, height: self.object.size.height)
                .offset(x:self.completedPoint != nil ? self.completedPoint!.x - geo.frame(in: .global).midX : self.offset?.x ?? 0,
                        y:self.completedPoint != nil ? self.completedPoint!.y - geo.frame(in: .global).midY : self.offset?.y ?? 0)
            .padding(50)
            .animation(.easeOut)
            .zIndex(self.offset != nil ? 1 : 0)
            .gesture(DragGesture()
                .onChanged({ (value) in
                    self.offset = CGPoint(x: value.translation.width, y: value.translation.height)
                })
                .onEnded({ (value) in
                    self.offset = .zero
                    let objectFrame = geo.frame(in:.global)
                    let point = CGPoint(x: objectFrame.minX + value.location.x, y: objectFrame.minY + value.location.y)
                    print("point",point)
                    self.check(point)
                })
            )
        }
            .frame(width: self.object.size.width, height: self.object.size.height)
    }
    
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView().environmentObject(Poof())
    }
}

//
//  LevelView.swift
//  poof
//
//  Created by 松原明香 on 2019/11/03.
//  Copyright © 2019 松原明香. All rights reserved.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var poof:Poof
    var body: some View {
        Group{
            if poof.currentLevelSucceed{
                Lottie(poof.currentLevel.levelmonster)
            }else{
                QuestionView()
            }
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView().environmentObject(Poof())
    }
}

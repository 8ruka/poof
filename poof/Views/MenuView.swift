//
//  MenuView.swift
//  poof
//
//  Created by 松原明香 on 2019/11/16.
//  Copyright © 2019 松原明香. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var poof:Poof
    var body: some View {
        VStack{
            Text("Choose level")
                .font(.system(size: 32, weight: .bold, design: .rounded))
            HStack {
               
                ForEach(poof.info.levels) {level in Button(action: {
                    self.poof.goToLevel(level)
                }) {
                    Lottie(level.menumonster)
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
        .frame(width: 1500, height: 1000)
        .previewLayout(.sizeThatFits)
    }
}

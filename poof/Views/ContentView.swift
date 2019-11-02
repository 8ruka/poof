//
//  ContentView.swift
//  poof
//
//  Created by 松原明香 on 2019/09/24.
//  Copyright © 2019 松原明香. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var poof:Poof
    var body: some View {
        QuestionView()
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Poof())
    }
}

//
//  Level.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation
import UIKit

struct Level:Decodable, Identifiable, Equatable{
    static func == (lhs: Level, rhs: Level) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String{levelmonster}
    
    let backgroundColorR : String
    let backgroundColorL : String
    let questions:[Question]
    let menumonster:String
    let levelmonster:String
    let questionmonster : String
 
    
    
}

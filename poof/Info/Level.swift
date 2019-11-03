//
//  Level.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation
import UIKit

struct Level:Decodable {
    let backgroundColorR : String
    let backgroundColorL : String
    let questions:[Question]
    let levelmonster:String
    let questionmonster : String
 
    
    
}

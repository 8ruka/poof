//
//  Reciever.swift
//  poof
//
//  Created by 松原明香 on 2019/11/17.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation
import CoreGraphics

struct Reciever: Decodable,Identifiable{
    var id: String{name}
    
    let name:String
    let size:CGSize
    let point:CGPoint
}

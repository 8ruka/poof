//
//  Object.swift
//  poof
//
//  Created by 松原明香 on 2019/10/27.
//  Copyright © 2019 松原明香. All rights reserved.
//

import Foundation
import CoreGraphics

struct Object:Decodable {
    let name:String
    let target:Target?
}

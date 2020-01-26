//
//  Object.swift
//  ZhongChristopherCE01
//
//  Created by Christopher Zhong on 12/2/19.
//  Copyright © 2019 Christopher Zhong. All rights reserved.

import Foundation

class Clothing{
var type: String
var sizes: [String]
var limit: Int
var salestatus: Bool

//initializers
init(type: String,sizes: [String],limit: Int,salestatus: Bool){
    self.type = type
    self.sizes = sizes
    self.limit = limit
    self.salestatus = salestatus
}
}

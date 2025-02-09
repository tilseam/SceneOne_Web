//
//  ModelTwo.swift
//  MacExample
//
//  Created by Jon Worms on 5/17/18.
//  Copyright © 2018 Jon Worms. All rights reserved.
//

import Foundation

class ModelTwo: NSObject, SupportFile {
    static var fileTypeSubdirectoryName: String { return "ModelTwo" }
    
    static var fileTypeExtension: String { return "m2" }
    
    var fileName: String = "ModelTwo File Name"
    
    static var supportsSecureCoding: Bool { return true }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(valueOne, forKey: "valueOne")
        aCoder.encode(valueTwo, forKey: "valueTwo")
    }
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        if let vone: String = aDecoder.decodeObject(of: NSString.self, forKey: "valueOne") as String? {
            valueOne = vone
        }
        
        if let vtwo: String = aDecoder.decodeObject(of: NSString.self, forKey: "valueTwo") as String? {
            valueTwo = vtwo
        }
    }
    
    var valueOne: String!
    var valueTwo: String!
    
    
    
}

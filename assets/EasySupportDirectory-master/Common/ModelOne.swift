//
//  ModelOne.swift
//  MacExample
//
//  Created by Jon Worms on 5/17/18.
//  Copyright © 2018 Jon Worms. All rights reserved.
//

import Foundation

class ModelOne: NSObject, SupportFile {

    // SupportFile
    static var fileTypeSubdirectoryName: String = "ModelOne"
    static var fileTypeExtension: String = "m1"
    var fileName: String = "Some File Name"



    // NSSecureCoding
    static var supportsSecureCoding: Bool { return true }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        if let vone: NSString = aDecoder.decodeObject(of: NSString.self, forKey: "valueOne") {
            valueOne = vone as String
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(valueOne, forKey: "valueOne")
    }


    // The data we need to save to file
    var valueOne: String!
  
    override init() {
        super.init()
    }

}

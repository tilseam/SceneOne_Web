### Easy Support Directory

*a simple interface for using the Application Support directory on macOS and iOS*

To save a model to the Application Support directory, implement the following protocol

```swift
protocol SupportFile: NSSecureCoding {
    static var fileTypeSubdirectoryName: String { get }
    static var fileTypeExtension: String { get }
    var fileName: String { get }
}
```
from the example:

```swift
// ModelOne.swift

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
```

Lets say we need to save this file to the application support Directory

```swift
let mone: ModelOne = ModelOne()
mone.valueOne = "some string value"
mone.fileName = "file name"

do {
    try SupportFileManager.saveFile(file: mone)
} catch {
    // handle exception
}
```

if we want to load a file:

```swift
let m1: ModelOne? = SupportFileManager.loadFile("file name")
```

Working examples are provided in EasySupportDirectory and EasySupportDirectory_iOS

#### Installation

Add SupportFileManager.swift to your project, that's it.

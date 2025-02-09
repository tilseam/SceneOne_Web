//
//  ViewController.swift
//  EasySupportDirectory
//
//  Created by Jon Worms on 5/18/18.
//  Copyright © 2018 Jon Worms. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mOneVal: NSTextField!
    @IBOutlet weak var mTwoValA: NSTextField!
    @IBOutlet weak var mTwoValB: NSTextField!
    
    
    let moneFileName: String = "mOne File Name"
    let mtwoFileName: String = "mTwo File Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func load(_ sender: Any) {
        
        let m1: ModelOne? = SupportFileManager.loadFile(moneFileName)
        
        let m2Array: [ModelTwo] = SupportFileManager.loadFiles()
        let m2 = m2Array.first
        
        if m1 != nil {
            mOneVal.stringValue = m1!.valueOne
        }
        
        if m2 != nil {
            mTwoValA.stringValue = m2!.valueOne
            mTwoValB.stringValue = m2!.valueTwo
        }
        
    }
    @IBAction func save(_ sender: Any) {
        
        let mone: ModelOne = ModelOne()
        mone.valueOne = mOneVal.stringValue
        mone.fileName = moneFileName
        
        let mtwo: ModelTwo = ModelTwo();
        mtwo.valueOne = mTwoValA.stringValue
        mtwo.valueTwo = mTwoValB.stringValue
        mtwo.fileName = mtwoFileName
        
        do {
            try SupportFileManager.saveFile(file: mone)
            try SupportFileManager.saveFile(file: mtwo)
        } catch {
            print("exception thrown in save")
        }
        
        
    }
    
}


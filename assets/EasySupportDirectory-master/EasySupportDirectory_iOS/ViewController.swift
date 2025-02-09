//
//  ViewController.swift
//  EasySupportDirectory_iOS
//
//  Created by Jon Worms on 5/18/18.
//  Copyright © 2018 Jon Worms. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mOneVal: UITextField!
    @IBOutlet weak var mTwoValA: UITextField!
    @IBOutlet weak var mTwoValB: UITextField!
    
    
    let moneFileName: String = "mOne File Name"
    let mtwoFileName: String = "mTwo File Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func load(_ sender: Any) {
        
        let m1: ModelOne? = SupportFileManager.loadFile(moneFileName)
        
        let m2Array: [ModelTwo] = SupportFileManager.loadFiles()
        let m2 = m2Array.first
        
        if m1 != nil {
            mOneVal.text = m1!.valueOne
        }
        
        if m2 != nil {
            mTwoValA.text = m2!.valueOne
            mTwoValB.text = m2!.valueTwo
        }
        
    }
    @IBAction func save(_ sender: Any) {
        
        let mone: ModelOne = ModelOne()
        mone.valueOne = mOneVal.text
        mone.fileName = moneFileName
        
        let mtwo: ModelTwo = ModelTwo();
        mtwo.valueOne = mTwoValA.text
        mtwo.valueTwo = mTwoValB.text
        mtwo.fileName = mtwoFileName
        
        do {
            try SupportFileManager.saveFile(file: mone)
            try SupportFileManager.saveFile(file: mtwo)
        } catch {
            print("exception thrown in save")
        }
        
        
    }
}


//
//  ViewController.swift
//  Test
//
//  Created by Samuel Wang on 12/20/15.
//  Copyright © 2015 Samuel Wang. All rights reserved.
//

import UIKit
import Sodium

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func removeLessThan() -> String {
        return self.replace("<", replacement: "")
    }
    
    func removeGreaterThan() -> String {
        return self.replace(">", replacement: "")
    }
    
}

let password = "ADD PASSWORD HERE"

let sodium = Sodium()!
let message = "BiGG\(password)WaNGG".dataUsingEncoding(NSUTF8StringEncoding)!
let h = sodium.genericHash.hash(message)! as! NSMutableData
var randomOne = ((String(sodium.randomBytes.buf(8)! as! NSMutableData).removeWhitespace()).removeLessThan()).removeGreaterThan()
let randomTwo = ((String(sodium.randomBytes.buf(8)! as! NSMutableData).removeWhitespace()).removeLessThan()).removeGreaterThan()
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var hashedPassword = ((String(h).removeWhitespace()).removeLessThan()).removeGreaterThan()
        hashedPassword += randomTwo
        randomOne += hashedPassword
        let finalHash = randomOne
        print(finalHash)
        let index = finalHash.startIndex.advancedBy(16)
        let endIndex = finalHash.endIndex.advancedBy(-16)
        let compare = finalHash[Range(start: index, end: endIndex)]
        print(compare)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  ToDo List
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importantCheckBox: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func addClicked(_ sender: Any) {
        
        if textField.stringValue != "" {
            
            if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
                
               let toDoItem = ToDoItem(context: context)
                
                toDoItem.name = textField.stringValue
                
                if importantCheckBox.state == 0 {
//                    not important
                    toDoItem.important = false
                } else {
//                    important
                    toDoItem.important = true
                }
                
                (NSApplication.shared().delegate as? AppDelegate)?.saveAction(nil)
                
                textField.stringValue = ""
                importantCheckBox.state = 0
            }
            
        }
        
    }


}


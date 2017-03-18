//
//  ViewController.swift
//  ToDo List
//
//  Created by Mitch Guzman on 3/18/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var importantCheckBox: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var toDoItems : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getToDoItems()
        print(toDoItems.count)
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func getToDoItems() {
        //        get the todo items from core data
        
        if let context = (NSApplication.shared().delegate as? AppDelegate)?.managedObjectContext {
            
            do {
                //        set them to the class property
                toDoItems = try context.fetch(ToDoItem.fetchRequest())
            } catch {}
        }
        
        //        update the table
        tableView.reloadData()
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
                
                getToDoItems()
                print(toDoItems.count)
            }
            
        }
        
    }
    
    // MARK: - TableView Stuff
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let toDoItem = toDoItems[row]
        
        if tableColumn?.identifier == "importantIdentifier" {
            //            Important column
            if let cell = tableView.make(withIdentifier: "importantCell", owner: self) as? NSTableCellView {
                
                if toDoItem.important  {
                    cell.textField?.stringValue = "❗️"
                } else {
                    cell.textField?.stringValue = ""
                }
                
                return cell
            }
            
        } else {
            //            ToDo name
            if let cell = tableView.make(withIdentifier: "todoItems", owner: self) as? NSTableCellView {
                
                let toDoItem = toDoItems[row]
                
                cell.textField?.stringValue = toDoItem.name!
                
                return cell
            }
        }
        
        
        return nil
    }
    
    
}


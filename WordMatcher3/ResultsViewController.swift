//
//  ResultsViewController.swift
//  WordMatcher
//
//  Created by Jason Clark on 3/8/15.
//  Copyright (c) 2015 Jason Clark. All rights reserved.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    var coreDataStack: CoreDataStack!
    var fetchedResultsController: NSFetchedResultsController!
    
    @IBOutlet weak var tableView: UITableView!
    
    //var num: Int!
    var userInput: String!
    var regExpression: String!

    
    
    @IBOutlet weak var titleLabel: UILabel!


    @IBOutlet weak var wordLabel: UILabel!

    @IBOutlet weak var numberResultsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        println("Looking for matches for the word \(userInput)")
        //println("The word has \(num) letters")
        println("ViewDidLoad.  REGEX is \(regExpression)")

        
        titleLabel.text = "You entered the word:"
        wordLabel.text = "\(userInput)"
        
        
        // Do any additional setup after loading the view.
        //1
        let fetchRequest = NSFetchRequest(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "theWord matches %@",regExpression)

        
        // DESCRIPTORS
        //Must include sort descriptors for NSFetchedResultsController
        let sortDescriptor = NSSortDescriptor(key: "theWord", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //2
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        //3
        var error: NSError? = nil
        if (!fetchedResultsController.performFetch(&error)) {
            println("Error: \(error?.localizedDescription)")
        }
        
        var numberOfResults = fetchedResultsController.fetchedObjects?.count
        
        if let results = numberOfResults {
               numberResultsLabel.text = "There are \(results) matches."
        } else {
            numberResultsLabel.text = "Your search did not match any words"
        }
     
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        println("tableView titleForHeaderInSection Called")
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return sectionInfo.name
    }
    
    
    func numberOfSectionsInTableView (tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo

        return sectionInfo.numberOfObjects
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println("CellForRowAtIndexPath Called")
        
        let resuseIdentifier = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(resuseIdentifier, forIndexPath: indexPath) as TableViewCell
        
        configureCell(cell, indexPath: indexPath)

        
        return cell
    }
    
    
    func configureCell(cell: TableViewCell, indexPath: NSIndexPath) {
        println("Configure cell start")
        let word = fetchedResultsController.objectAtIndexPath(indexPath) as Entity
        
        cell.wordLabel.text = word.theWord
        println("The word in the current cell is \(word.theWord)")
        
    }
    
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let word = fetchedResultsController.objectAtIndexPath(indexPath) as Entity
            
            
    }
    
    
    /** NSFETCHED RESULTS CONTROLLER DELEGATE FUNCTIONS  *******************************************************************************************************************************/
    
    // ANY CHANGE IN CONTENT
    //    func controllerDidChangeContent(controller: NSFetchedResultsController) {
    //        tableView.reloadData()
    //    }
    
    // WILL CHANGE CONTENT BEGIN UPDATES
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    // Handle:  Did CHANGE
    func controller(controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
        atIndexPath indexPath: NSIndexPath!,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath!) {
            
            switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
                
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            case .Update:
                let cell = tableView.cellForRowAtIndexPath(indexPath) as TableViewCell
                configureCell(cell, indexPath: indexPath)
                
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
                
            default:
                break
            }
    }
    
    // Handle:  DID CHANGE CONTENT END UPDATE
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    // Handle: SECTION CHANGES
    func controller(controller: NSFetchedResultsController,
        didChangeSection sectionInfo: NSFetchedResultsSectionInfo,
        atIndex sectionIndex: Int,
        forChangeType type: NSFetchedResultsChangeType) {
            
            let indexSet = NSIndexSet(index: sectionIndex)
            
            switch type {
            case .Insert:
                tableView.insertSections(indexSet, withRowAnimation: .Automatic)
            case .Delete:
                tableView.deleteSections(indexSet, withRowAnimation: .Automatic)
            default:
                break
            }
    }

    

} // END CLASS

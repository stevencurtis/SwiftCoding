//
//  ViewController.swift
//  CoreDataPredicate
//
//  Created by Steven Curtis on 18/06/2019.
//  Copyright © 2019 Steven Curtis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private static let cellReuseId = "Cell"

    @IBOutlet weak var tableView: UITableView!
    var coreDataStack: CoreDataStack!
    var data = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellReuseId)
        
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(withNotification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: nil)
        }
        fetchAndReload()
    }
    

    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        
        let sheet = UIAlertController(title: "Filter", message: nil, preferredStyle: .actionSheet)
        let reset = UIAlertAction(title: "Reset", style: .default, handler: { action in
            
            // we wouldn't usually reach into the AppDelegate from here, but for this example...it has been done
            if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.retrieveDataFromURLIfNeeded()
            }
            self.fetchAllRecords()
        })
        
        let simpleCondition = UIAlertAction(title: "Simple condition", style: .default, handler: { action in
            self.simpleCondition()
        })
        
        let multiTableCondition = UIAlertAction(title: "Multitable", style: .default, handler: { action in
            self.multiTableCondition()
        })
        
        let nrecords = UIAlertAction(title: "First 1 record by SHA", style: .default, handler: { action in
            self.nrecords()
        })
        
        let delete = UIAlertAction(title: "Delete records", style: .default, handler: { action in
            self.deleteAllRecords()
        })
        
        let deleteAllRecordsBeforeToday = UIAlertAction(title: "Delete records after today", style: .default, handler: { action in
            self.deleteAllRecordsAfterToday()
        })
        
        let update = UIAlertAction(title: "Change first SHA to AAA", style: .default, handler: { action in
            self.update()
        })
        
        let insert = UIAlertAction(title: "Insert a new record at position 0", style: .default, handler: { action in
            self.insert()
        })
        
        let batch = UIAlertAction(title: "Batch", style: .default, handler: { action in
            self.batchUpdate()
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cancel)
        sheet.addAction(reset)
        sheet.addAction(simpleCondition)
        sheet.addAction(multiTableCondition)
        sheet.addAction(nrecords)
        sheet.addAction(delete)
        sheet.addAction(deleteAllRecordsBeforeToday)
        sheet.addAction(update)
        sheet.addAction(insert)
        sheet.addAction(batch)

        self.present(sheet, animated: true, completion: nil)
    }
    
    func batchUpdate() {
        
        let entity = NSEntityDescription.entity(forEntityName: "Commit", in: coreDataStack.managedContext)
        let updateBatch = NSBatchUpdateRequest(entity: entity!)
        
        updateBatch.predicate = NSPredicate(format: "sha BEGINSWITH 'e'")
        
        updateBatch.propertiesToUpdate = ["sha" : "changed"]
        
        updateBatch.resultType = .updatedObjectIDsResultType
        
        do {
            let _ = try coreDataStack.managedContext.execute(updateBatch)
            fetchAndReload()
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func insert() {
        let entityOne = NSEntityDescription.insertNewObject(forEntityName: "Commit", into: coreDataStack.managedContext)
        entityOne.setValue("test sha", forKey: "sha")
        entityOne.setValue("test url", forKey: "url")
        entityOne.setValue("test html_url", forKey: "html_url")
        do {
            try coreDataStack.managedContext.save()
            fetchAndReload()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func update() {
        ((data.first) as! Commit).sha = "AAA"
        
        do {
            _ = try coreDataStack.managedContext.save()
            fetchAndReload()
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func nrecords() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")
        
        let sort = NSSortDescriptor(key: "gitcommit.committer.date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        fetchRequest.fetchLimit = 1
        
        do {
            data = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    
    func multiTableCondition() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")

        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let currentDate = calendar.startOfDay(for: Date())
        
        // after today's date
        fetchRequest.predicate = NSPredicate(format: "gitcommit.committer.date <= %@", currentDate as NSDate)
        
        let sort = NSSortDescriptor(key: "gitcommit.committer.date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            data = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func simpleCondition() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")

        //html_url
        fetchRequest.predicate = NSPredicate(format: "sha BEGINSWITH 'e'")
        
        do {
            data = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllRecords() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")
        do {
            data = try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()

        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllRecords() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)

        do {
            _ = try coreDataStack.managedContext.execute(deleteRequest)
            data.removeAll()
            tableView.reloadData()
            
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllRecordsAfterToday() {
        let fetchRequest = NSFetchRequest<Commit>(entityName: "Commit")
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let currentDate = calendar.startOfDay(for: Date())
        
        // after today's date
        fetchRequest.predicate = NSPredicate(format: "gitcommit.committer.date > %@", currentDate as NSDate)

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            _ = try coreDataStack.managedContext.execute(deleteRequest)
            data.removeAll()
            fetchAndReload()
            
        } catch let error as NSError {
            print ("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @objc func notificationReceived (withNotification notification: NSNotification) {
        print ("notificationReceived", data.count)
        DispatchQueue.main.async {
            self.fetchAndReload()
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = (data[indexPath.row] as! Commit).sha
        cell.detailTextLabel?.text = (data[indexPath.row] as! Commit).gitcommit?.committer!.date?.description
        return cell
    }
}

extension ViewController {
    func fetchAndReload() {
        let fetchRequest: NSFetchRequest<Commit> = Commit.fetchRequest()
        do { data =
            try coreDataStack.managedContext.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
}

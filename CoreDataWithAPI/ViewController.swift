//
//  ViewController.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var searchText: String? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var fetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    
    //MARK: View Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCoreData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight=UITableViewAutomaticDimension
        tableView.estimatedRowHeight=300
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    //MARK: Search controller
    func updateSearchResults(for searchController: UISearchController) {
        searchText = searchController.searchBar.text!
        if(searchText != ""){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            fetchedResultsController = getResultController(context: managedContext, searchText: searchText)
            do {
                try self.fetchedResultsController.performFetch()
                print("Now Searching")
                tableView.reloadData()
            }catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        }
        
        if searchController.isActive == false{
            getCoreData()
            tableView.reloadData()
        }
    }
    
    
    //MARK: User Defined Functions
    
    func getCoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        fetchedResultsController = getResultController(context: managedContext, searchText: nil)
        do {
            try self.fetchedResultsController.performFetch()
            print(fetchedResultsController.fetchedObjects?.count ?? 0)
            if fetchedResultsController.fetchedObjects?.count == 0{
                getData()
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func getData(){
        ListingViewModel.getListings()
    }
    
    func getResultController(context: NSManagedObjectContext, searchText: String?) -> NSFetchedResultsController<NSFetchRequestResult>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Listing")
        let sortDescriptor = NSSortDescriptor(key: "unit", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if searchText != nil{
        let predicate = NSPredicate(format: "unit CONTAINS[c] %@", searchText!)
        fetchRequest.predicate = predicate
        }
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }
    
    
    //MARK: FetchedResultController Functions
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        default:
            print("Running the default case")
        }
    }
    
    
    //MARK: TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currSection = fetchedResultsController.sections?[section] {
            return currSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingCell") as? ListingTableViewCell
        let record = fetchedResultsController.object(at: indexPath) as! Listing
        
        if let unitTypeText = record.unit {
            if searchController.isActive == true{
                if searchText != nil{
                    if searchText != ""{
                        cell?.highlightText(searchText: searchText!, wholeText: unitTypeText)
                    }
                }
            }
            else{
                cell?.unitTypeText.text = unitTypeText
            }
        }
        
        
        
        if let description = record.desc {
            cell?.descriptionText.text = description
        }
        
        if let photo = record.image {
            cell?.listingImageView?.image = UIImage(data: photo as Data)
        }
        
        
        return cell!
    }
    
    
}


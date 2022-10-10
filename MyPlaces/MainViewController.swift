//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Andrey on 24.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet var reversedSortingButton: UIBarButtonItem!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var places: Results<Place>!
    private var ascendingSorting = true
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredPlaces: Results<Place>!
    private var searchBarIsEmty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmty
    }

    
  // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StorageManager.seedData()
        places = realm.objects(Place.self)
        
        // Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Private section
       
       private func sorting() {
           if segmentedControl.selectedSegmentIndex == 0 {
               places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
           }
           else {
               places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
           }
           tableView.reloadData()
       }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
             
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = places[indexPath.row]
        }
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
    
    // MARK: -  IBActions
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    
    @IBAction func reversedSorting(_ sender: Any) {
        ascendingSorting.toggle()
        reversedSortingButton.image = ascendingSorting ? UIImage(named: "AZ") : UIImage(named: "ZA")
        sorting()
    }
}

 // MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(for: searchController.searchBar.text!)
    }
    private func filterContent(for searchText: String) {
        filteredPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        tableView.reloadData()
    }
}


 //MARK: - Table view delegate,  Table view data source
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.typeLabel.text = place.type
        cell.lacationLabel.text = place.location
        cell.imageOfPlace.clipsToBounds = true
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2

        return cell
    }
    
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let place = places[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(_,_) in
                    StorageManager.deleteObject(place)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                return [deleteAction]
    }

}

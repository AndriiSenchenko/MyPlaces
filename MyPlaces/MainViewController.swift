//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Andrey on 24.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit
import RealmSwift

 class MainViewController: UITableViewController {
    
     var places: Results<Place>!
    
  // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        StorageManager.seedData()
        places = realm.objects(Place.self)
    }

    //MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
                let place = places[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(_,_) in
                    StorageManager.deleteObject(place)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                return [deleteAction]
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
}

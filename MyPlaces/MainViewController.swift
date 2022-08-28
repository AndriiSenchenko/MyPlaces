//
//  MainViewController.swift
//  MyPlaces
//
//  Created by Andrey on 24.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    let places = Place.getPlaces()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        cell.nameLabel.text = places[indexPath.row].name
        cell.imageOfPlace.image = UIImage(named: places[indexPath.row].image)
        cell.typeLabel.text = places[indexPath.row].type
        cell.lacationLabel.text = places[indexPath.row].location
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        
        return cell
    }

    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue){
        
    }

}

//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Andrey on 27.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row == 0 else{
            view.endEditing(true)
            return
        }
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            // TODO: choose image picer
            self.chooseImagePicker(sourse: .camera)
        }
        
        let photo = UIAlertAction(title: "Photo", style: .default) { _ in
            // TODO: choose image picer
            self.chooseImagePicker(sourse: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        
        
        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
        
    }
    
    
}

// MARK: text field delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
}


extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker (sourse: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(sourse){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = sourse
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true)
    }
}


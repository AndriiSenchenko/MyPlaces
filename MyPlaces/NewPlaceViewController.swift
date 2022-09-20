//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by Andrey on 27.08.2022.
//  Copyright © 2022 Andrey. All rights reserved.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    var imageIsChanged = false
    var currentPlace: Place?
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeType: UITextField!
    @IBOutlet var placeLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        DispatchQueue.main.async {
//            self.newPlace.savePlace()
//        }
  
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        tableView.tableFooterView = UIView()
        setupEditScreen()
    }
    
    
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
    // MARK: Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewPlace(){
        
        let image = imageIsChanged ? placeImage.image : UIImage(named: "imagePlaceholder")
                
        let newPlace = Place(name: placeName.text!,
                             location: placeLocation.text,
                             type: placeType.text,
                             image: image!.pngData())
        StorageManager.saveObject(newPlace)
        
    }

    private func setupEditScreen(){
        guard let currentPlace = currentPlace else { return }
        guard let data = currentPlace.imageData, let image = UIImage(data: data) else { return }
        placeImage.image = image
        placeType.text = currentPlace.type
        placeName.text = currentPlace.name
        placeLocation.text = currentPlace.location
        placeImage.contentMode = .scaleAspectFill
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: Text field delegate
extension NewPlaceViewController: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: Work with image
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageIsChanged = true
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        dismiss(animated: true)
    }
}

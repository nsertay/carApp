//
//  NewCarController.swift
//  carApp
//
//  Created by Nurmukhanbet Sertay on 21.03.2023.
//

import UIKit
import CoreData

class NewCarController: UITableViewController {
    
    var allFieldsFilled = true
    var car: Car!
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 2
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 3
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 10.0
            descriptionTextView.layer.masksToBounds = true
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = true
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true)
                }
                
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            
            
            photoSourceController.addAction(cameraAction)
            photoSourceController.addAction(photoLibraryAction)
            photoSourceController.addAction(cancelAction)
            
            
            present(photoSourceController, animated: true)
        }
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || typeTextField.text == "" || addressTextField.text == "" || phoneTextField.text == "" || descriptionTextView.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            car = Car(context: appDelegate.persistentContainer.viewContext)
            
            car.name = nameTextField.text!
            car.type = typeTextField.text!
            car.location = addressTextField.text!
            car.phone = phoneTextField.text!
            car.summary = descriptionTextView.text
            car.isFavorite = false
            
            if let imageData = photoImageView.image?.pngData() {
                car.image = imageData
            }
            
            print("Saving Data to Context....>>>>>")
            
            appDelegate.saveContext()
            
            let alertController = UIAlertController(title: "", message: "Your data added successfully!\nWhat we should do?", preferredStyle: .alert)
            let alertAction1 = UIAlertAction(title: "Go to home", style: .default) { action in
                self.dismiss(animated: true)
            }
            let alertAction2 = UIAlertAction(title: "Stay here", style: .default, handler: nil)
            alertController.addAction(alertAction1)
            alertController.addAction(alertAction2)
            present(alertController, animated: true, completion: nil)
            
            
        }
    }
    
    
}

extension NewCarController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextField.becomeFirstResponder()
        }
        return true
    }
}

extension NewCarController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true)
    }
}

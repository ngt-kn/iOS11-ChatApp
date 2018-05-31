//
//  SelectPictureViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/30/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var imagePicker : UIImagePickerController?
    var imageAdded = false
    var imageName = "\(NSUUID().uuidString).jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func presentAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        if imagePicker != nil {
            imagePicker?.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func selectPhotoPressed(_ sender: UIBarButtonItem) {
        if imagePicker != nil {
            imagePicker?.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil)
        }
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let message = messageTextField.text {
            if imageAdded && message != "" {
                // Upload the image to firebase storage
                
                let imagesFolder = Storage.storage().reference().child("images")
                
                if let image = imageView.image {
                    let imageData = UIImageJPEGRepresentation(image, 0.1)
                    let imageRef = imagesFolder.child(imageName)
                    
                    imageRef.putData(imageData!, metadata: nil) { (metadata, error) in
                        if let error = error {
                            self.presentAlert(message: error.localizedDescription)
                        } else {
                            // Segue to next controller
                            imageRef.downloadURL(completion: { (url, error) in
                                if error != nil {
                                    print(error?.localizedDescription as Any)
                                } else {
                                    let downloadURL = url?.absoluteString
                                    self.performSegue(withIdentifier: "sendMessageSegue", sender: downloadURL)
                                }
                            })
                        }
                    }
                }
            } else {
                // error
                presentAlert(message: "Please select a picture and enter a vaild message")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let downloadURL = sender as? String{
            if let sendVC = segue.destination as? ContactTableViewController{
                sendVC.downloadURL = downloadURL
                sendVC.messageDescription = messageTextField.text!
                sendVC.imageName = imageName
            }
        }
        
    }
    
}

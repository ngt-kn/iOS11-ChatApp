//
//  SelectPictureViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/30/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var imagePicker : UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
}

//
//  SnapViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/31/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import SDWebImage
import FirebaseStorage

class SnapViewController: UIViewController {
    

    @IBOutlet weak var imsgeView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var snap : DataSnapshot?
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let snapDictionary = snap?.value as? NSDictionary {
            if let messageDescription = snapDictionary["description"] as? String {
                if let imageURL = snapDictionary["imageURL"] as? String{
                    messageLabel.text = messageDescription
                    
                    if let url = URL(string: imageURL){
                        imsgeView.sd_setImage(with: url)
                    }
                    if let imageName = snapDictionary["imageName"] as? String {
                        self.imageName = imageName
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if let currentUserUid = Auth.auth().currentUser?.uid{
           
            if let key = snap?.key{
                Database.database().reference().child("users").child(currentUserUid).child("snaps").child(key).removeValue()
                Storage.storage().reference().child("images").child(imageName).delete(completion: nil)
            }
        }    
    }

}

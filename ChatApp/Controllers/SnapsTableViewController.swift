//
//  SnapsTableViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/30/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsTableViewController: UITableViewController {
    
    var snaps : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUserUid = Auth.auth().currentUser?.uid{
            Database.database().reference().child("users").child(currentUserUid).child("snaps").observe(.childAdded) { (snapshot) in
                self.snaps.append(snapshot)
                self.tableView.reloadData()
            }
        }

    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let snap = snaps[indexPath.row]

        if let snapDictionary = snap.value as? NSDictionary {
            if let fromEmail = snapDictionary["from"] as? String {
                cell.textLabel?.text = fromEmail
            }
        }
        return cell
    }

    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
            if let viewVC = segue.destination as? SnapViewController {
                if let snap = sender as? DataSnapshot {
                    viewVC.snap = snap
                }
            }
        }
        
    }
    
    
    

}

//
//  ViewController.swift
//  ShowcaseApp
//
//  Created by Kerry Nasta on 4/13/18.
//  Copyright © 2018 Kerry Nasta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var contacts: [Contact] = []
    let defaultsData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadContacts()
        
//        contacts = defaultsData.array(forKey: "contacts") as! [Contact]
        
//        contacts.append(Contact(name: "Kerry Nasta", company: "Burberry", position: "CEO", email: "knasta@burberry.com", phone: "8157359142", fax: "", address: "123 Perfection Ave, New York, NY 60012", notes: "Job positions available online"))

    }
    
    func loadContacts() {
        guard let contactsEncoded = UserDefaults.standard.value(forKey: "contactsArray") as? Data else {
            print("Couldn't read in data from UserDefaults")
            return
        }
        let decoder = JSONDecoder()
        if let contactsArray = try? decoder.decode(Array.self, from: contactsEncoded) as [Contact] {
            self.contacts = contactsArray
        } else {
            print("Couldn't decode data")
        }
    }
    
//    func saveDefaultsData() {
//    defaultsData.set(contacts, forKey: "contacts")
//    }
    
    func saveDefaultsData() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts) {
            UserDefaults.standard.set(encoded, forKey: "contactsArray")
        } else {
            print("ERROR: saving encoded did not work")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContact" {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            let destination = segue.destination as! ContactDetailTableVC
            destination.contact = contacts[selectedIndexPath.row]
        } else {
            if let selectedRow = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedRow, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromContactDetailTableVC(segue: UIStoryboardSegue){
        if let selectedIndexPath = tableView.indexPathForSelectedRow { // tableview cell you clicked on
            let source = segue.source as! ContactDetailTableVC
            contacts[selectedIndexPath.row] = source.contact
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let source = segue.source as! ContactDetailTableVC
            let newIndexPath = IndexPath(row: contacts.count, section: 0)
            contacts.append(source.contact)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveDefaultsData()
    }
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = contacts[indexPath.row].company
        return cell
    }
    //function to delete rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveDefaultsData()
        }
}
    //function to move rows
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let contactsToMove = contacts[sourceIndexPath.row]
//        contacts.remove(at: sourceIndexPath.row)
//        contacts.insert(contactsToMove, at: destinationIndexPath.row)
//        tableView.deleteRows(at: [sourceIndexPath], with: .fade)
//        saveDefaultsData()
//    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let contact = contacts[sourceIndexPath.row] //make a copy of the item you are going to move
        contacts.remove(at: sourceIndexPath.row) //delete item from the original location (pre-move)
        contacts.insert(contact, at: destinationIndexPath.row) //insert item into the "to", post-move, location
        saveDefaultsData()
    }
    
}

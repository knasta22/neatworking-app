//
//  ContactDetailTableVC.swift
//  ShowcaseApp
//
//  Created by Kerry Nasta on 4/24/18.
//  Copyright © 2018 Kerry Nasta. All rights reserved.
//

import UIKit

class ContactDetailTableVC: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if contact == nil {
            contact = Contact(name: "", company: "", position: "", email: "", phone: "", address: "", notes: "")
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameTextField.text = contact.name
        companyTextField.text = contact.company
        positionTextField.text = contact.position
        emailTextField.text = contact.email
        phoneTextField.text = contact.phone
        addressTextView.text = contact.address
        notesTextView.text = contact.notes
        imageView.image = UIImage(data: contact.imageData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        contact.name = nameTextField.text!
        contact.company = companyTextField.text!
        contact.position = positionTextField.text!
        contact.email = emailTextField.text!
        contact.phone = phoneTextField.text!
        contact.address = addressTextView.text!
        contact.notes = notesTextView.text!
    }
    
    @IBAction func unwindFromPicturePageVC(segue: UIStoryboardSegue) {
        let source = segue.source as! PicturePageVC
        let image = source.image
        imageView.image = image
        contact.imageData = UIImageJPEGRepresentation(image, 0.5) ?? Data()
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}


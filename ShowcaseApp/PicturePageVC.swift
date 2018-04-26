//
//  PicturePageVC.swift
//  ShowcaseApp
//
//  Created by Kerry Nasta on 4/23/18.
//  Copyright © 2018 Kerry Nasta. All rights reserved.
//

import UIKit

class PicturePageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var contactImage: UIImageView!
    
    var imagePicker = UIImagePickerController()
    let defaultsData = UserDefaults.standard
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

    }
    //ATTEMPT TO SAVE PHOTO DATA PLZ HELP
//    func writeData(image: UIImage) {
//        if let imageData = UIImagePNGRepresentation(image) {
//            let fileName = NSUUID().uuidString
//            let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//            let writePath = documents.appending(fileName)
//            do {
//                try imageData.write(to: URL(fileURLWithPath: writePath))
//                
//            } catch {
//                print("error in trying to write imagedata for url")
//            }
//        } else {
//            print("error trying to convert image into a raw data file")
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        contactImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func cameraPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
            //completion = {self.writeData(image: contactImage!)}
        } else {
            showAlert(title: "Camera Not Available", message: "There is no camera available on this device")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        image = contactImage.image!
    }
    
    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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


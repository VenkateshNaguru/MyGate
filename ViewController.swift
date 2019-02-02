//
//  ViewController.swift
//  MyGate
//
//  Created by Venkatesh Naguru on 02/02/19.
//  Copyright © 2019 Venkatesh. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    private var usersList = [User]()
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        let results = realm.objects(User.self)
        
        for user in results {
            usersList.append(user)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }

    @IBAction func AddButtonAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let username = "User \(usersList.count + 1)"
        let user = User()
        user.username = username
        user.passcode = generateRandomNumber()
        if let data:Data = image!.pngData() {
            user.imageData = data
        } else if let data:Data = image?.jpegData(compressionQuality: 1.0) {
           user.imageData = data
        }
        usersList.append(user)
        try! realm.write {
            realm.add(user)
        }

        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func generateRandomNumber() -> Int {
        var finalNumber = 0
        var place = 1
        for _ in 0..<6 {
            place *= 10
            let randomNumber = arc4random_uniform(10)
            finalNumber += Int(randomNumber)*place
        }
        return finalNumber
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserListTableViewCell
        let user = usersList[indexPath.row]
        cell.usernameLabel.text = user.username
        cell.passcodeLabel.text = "#" + String(user.passcode)
        let userImage = UIImage(data: user.imageData!)
        var imageData : Data?
        if let data:Data = userImage!.pngData() {
            imageData = data
        } else if let data:Data = userImage?.jpegData(compressionQuality: 1.0) {
            imageData = data
        }
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: 64] as CFDictionary
        let source = CGImageSourceCreateWithData(imageData! as CFData, nil)!
        let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options)!
        let thumbnail = UIImage(cgImage: imageReference)
        cell.imageView?.image = thumbnail
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
    
}


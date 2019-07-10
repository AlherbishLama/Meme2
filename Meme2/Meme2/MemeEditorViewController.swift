//
//  ViewController.swift
//  Meme2
//
//  Created by Lama Alherbish on 5/15/19.
//  Copyright © 2019 Udacity. All rights reserved.
//


import UIKit

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {

  
    @IBOutlet weak var topNavBar: UINavigationBar!
    @IBOutlet weak var bottomNavBar: UINavigationBar!
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottonTextField: UITextField!
    

    
    
    let imagepicker = UIImagePickerController()
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black ,
        NSAttributedString.Key.foregroundColor: UIColor.white ,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: Float(-4) ]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        setUpTextField(textField: topTextField)
        setUpTextField(textField: bottonTextField)
        shareButton.isEnabled = self.imagePickerView.image == nil
    }
    
    func setUpTextField(textField: UITextField) {
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        subscribeToKeyboardNotifications()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK : TextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func pickAnImageFromLibrary(_ sender:Any) {
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.photoLibrary)
        }
    
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
       // if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
        
        presentImagePickerWith(sourceType: UIImagePickerController.SourceType.camera)
       // }
       
    }
    
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated:true, completion:nil)
    }
    
    
    
    
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.contentMode = .scaleToFill
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
   
    func save() {
        // Create the meme
        let memedImage = meme(TopTextField: topTextField.text!, BottonTextField: bottonTextField.text!, OriginalImage: imagePickerView.image!, MemeImage: generateMemedImage())
        //Add it to the memes array on the application Delegate
       
        SingletonClass.memes.append(memedImage)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        topNavBar.isHidden = true
        bottomNavBar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        topNavBar.isHidden = false
        bottomNavBar.isHidden = false
        return memedImage
    }
    
    
    @IBAction func shareMeme(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { (activityVC , success , items , error) in
            
            if success == true {
                self.save()
            }
            self.dismiss(animated: true, completion: nil)
        }
        present(activityVC, animated: true, completion:nil)
    }
    
    
}


extension MemeEditorViewController {
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:) ), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if bottonTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if bottonTextField.isFirstResponder  {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}


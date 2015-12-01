//
//  StartScreen.swift
//  PicTiles
//
//  Created by Puttipong S. on 11/26/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit

class StartScreen: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playGame(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        selectedImage = image
        dismissViewControllerAnimated(true, completion: {self.moveNextView()})
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "toOption"){
            let svc = segue.destinationViewController as! OptionController
            svc.image = selectedImage
        }
    }
    
    func moveNextView(){
        
        performSegueWithIdentifier("toOption", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

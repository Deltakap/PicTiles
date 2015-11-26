//
//  OriginalImage.swift
//  PicTiles
//
//  Created by Puttipong S. on 11/26/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit

class OriginalImage: UIViewController {
    
    @IBOutlet weak var originalimg: UIImageView!
    
    var image:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        originalimg.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
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

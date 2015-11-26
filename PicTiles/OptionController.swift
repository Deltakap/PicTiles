//
//  OptionController.swift
//  PicTiles
//
//  Created by Puttipong S. on 11/25/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit

class OptionController: UIViewController {

    @IBOutlet weak var difficultySegment: UISegmentedControl!
    @IBOutlet weak var sizeSegment: UISegmentedControl!
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
    
    @IBAction func startGame(sender: AnyObject) {
        
        if(sizeSegment.selectedSegmentIndex == 0){
            
            performSegueWithIdentifier("EightPuzzle", sender: self)
        }
        else{
            
            performSegueWithIdentifier("FifteenPuzzle", sender: self)
        }
    }
    
    @IBAction func backToStart(sender: AnyObject) {
        
        performSegueWithIdentifier("backToStart", sender:self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "EightPuzzle"){
            let svc = segue.destinationViewController as! EightPuzzle
            svc.difficulty = difficultySegment.selectedSegmentIndex
            svc.image = self.image
        }
        
        if(segue.identifier == "FifteenPuzzle"){
            let svc = segue.destinationViewController as! FifteenPuzzle
            svc.difficulty = difficultySegment.selectedSegmentIndex
            svc.image = self.image
        }
    }
    
}

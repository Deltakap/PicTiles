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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let svc = segue.destinationViewController as! EightPuzzle
        svc.difficulty = difficultySegment.selectedSegmentIndex
    }
    
}

//
//  FifteenPuzzle.swift
//  PicTiles
//
//  Created by Puttipong S. on 11/25/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit
import CoreData

class FifteenPuzzle: UIViewController {

    @IBOutlet var collectionOfImages: Array<UIImageView>?
    @IBOutlet weak var moveLabel: UILabel!
    
    var imagesPosition: [Int] = [Int](count: 16, repeatedValue: -1)
    var tempImagesPosition: [Int] = [Int](count: 16, repeatedValue: -1)
    var imageTileList:[UIImage] = []
    
    var indexTap1 = -1
    var indexTap2 = -1
    
    let puzzleSize = 16
    let tilesPerRow = 4
    
    var image:UIImage!
    
    var moveCount = 0
    
    var difficulty = -1
    
    var scoreMultiplier = 1.0
    
    var totalScore = 0.0;
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for(var i=0; i<puzzleSize; i++){
            
            collectionOfImages![i].addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            )
        }
        
        randomCreateImage()
        moveUpdate()
        
        switch(difficulty){
            
        case 1: scoreMultiplier = 1.5
            break
        case 2: scoreMultiplier = 2.0
            break
        case 3: scoreMultiplier = 3.0
            break
        default: scoreMultiplier = 1.0
        }
    }
    
    func moveUpdate(){
        
        moveLabel.text = String(format: "Move: %d",moveCount)
    }
    
    func randomCreateImage(){
        
        var processedImage:UIImage?
        
        if(difficulty == 0){
            
            processedImage = OpenCV.processImageWithOpenCV(image)
        }
        else if(difficulty == 1){
            
            processedImage = OpenCV.processImageWithOpenCV2(image)
        }
        else if(difficulty == 2){
            
            processedImage = OpenCV.processImageWithOpenCV3(image)
        }
        else if(difficulty == 3){
            
            processedImage = OpenCV.processImageWithOpenCV4(image)
        }
        
        imageTileList = [UIImage](count: 16, repeatedValue: image)
        
        if(difficulty == 0){
            
            processedImage = OpenCV.processImageWithOpenCV(image)
        }
        else if(difficulty == 1){
            
            processedImage = OpenCV.processImageWithOpenCV2(image)
        }
        
        let imageBlank: UIImage! = UIImage.init(named: "darkbg.png")
        
        let tempImageRef: CGImageRef = processedImage!.CGImage!
        
        for (var i = 0; i<tilesPerRow; i++) {
            for(var j = 0; j<tilesPerRow; j++){
                
                let start = Int(image.size.width/4)*j
                let stop = Int(image.size.height/4)*i
                
                NSLog("%f %f", CGFloat(start), CGFloat(stop))
                
                imageTileList[4*i+j] = UIImage.init(
                    CGImage: CGImageCreateWithImageInRect(tempImageRef,
                        CGRectMake(CGFloat(start), CGFloat(stop), image.size.width/4, image.size.height/4))!
                )
            }
        }
        
        imageTileList[puzzleSize-1] = imageBlank
        
        var solvable = false
        
        var positionTemp = [Int](count: 15, repeatedValue: -1)
        
        while(!solvable){
            
            positionTemp = shuffle([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14])
            solvable = checkSolvable(positionTemp)
        }
        
        for i in 0..<(puzzleSize-1){
            
            imagesPosition[i] = positionTemp[i]
            tempImagesPosition[i] = positionTemp[i]
            collectionOfImages![i].image = imageTileList[positionTemp[i]]
        }
        
        imagesPosition[puzzleSize-1] = 15
        tempImagesPosition[puzzleSize-1] = 15
        collectionOfImages![puzzleSize-1].image = imageBlank
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(img: AnyObject){
        
        var indexTemp = -1
        
        for(var i = 0; i<puzzleSize; i++){
            
            if(collectionOfImages![i] == img.view){
                indexTemp = i
            }
        }
        
        if(indexTap1 == -1){
            indexTap1 = indexTemp
        }
        else{
            indexTap2 = indexTemp
        }
        
        if(indexTap1 != -1 && indexTap2 != -1){
            
            NSLog("%d %d",indexTap1,indexTap2)
            
            let checkEmpty = imagesPosition[indexTap2] == puzzleSize-1
            
            let checkNorth = (indexTap1 - tilesPerRow) == indexTap2
            let checkSouth = (indexTap1 + tilesPerRow) == indexTap2
            let checkEast = (indexTap1 + 1) == indexTap2 && indexTap2 != 4 && indexTap2 != 8 && indexTap2 != 12
            let checkWest = (indexTap1 - 1) == indexTap2 && indexTap2 != 3 && indexTap2 != 7 && indexTap2 != 11
            
            let adjacent = checkNorth || checkSouth || checkEast || checkWest
            
            if (checkEmpty && adjacent){
            
                let imgTemp = collectionOfImages![indexTap1].image
                let posTemp = imagesPosition[indexTap1]
                
                collectionOfImages![indexTap1].image = collectionOfImages![indexTap2].image
                collectionOfImages![indexTap2].image = imgTemp
                
                imagesPosition[indexTap1] = imagesPosition[indexTap2]
                imagesPosition[indexTap2] = posTemp
                
                moveCount++
                
                if(checkFinish()){
                
                    var moveScore = 10000.0 * (90.0/Double(moveCount))
                    
                    moveScore = round(moveScore)
                    
                    totalScore = moveScore*scoreMultiplier
                    
                    let finishString = String.init(format:
                        "\nMove Used: %d\t   %.0f\nScore Multiplier:\t  %.1f\n\nTotal Score:\t\t%.0f"
                        , moveCount, moveScore,scoreMultiplier,totalScore)
                    
                    let alert = UIAlertController(title: "Finished",
                        message: finishString,
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alert.addTextFieldWithConfigurationHandler{ (textField) in
                        textField.placeholder = "Name"
                        textField.keyboardType = .Default
                    }
                    
                    alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.Default,
                        handler: {(action:UIAlertAction!) in
                            
                            let textField = alert.textFields?.first
                            self.name = textField?.text
                            self.exitView(self)
                        })
                    )
                    
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
            }
        
            indexTap1 = -1
            indexTap2 = -1
            
        }
        
        moveUpdate()
        
    }
    
    func shuffle (var list:[Int])->[Int]{
        
        let size = list.count
        
        var shuffledArray = [Int](count: size, repeatedValue: 0)
        shuffledArray.removeAll(keepCapacity: true)
        
        while(!list.isEmpty){
            
            let randomIndex = (Int)(arc4random_uniform(8))
            
            if(randomIndex <= list.count-1){
                
                shuffledArray.append(list.removeAtIndex(randomIndex))
            }
        }
        
        return shuffledArray
    }
    
    func checkSolvable (list:[Int])->Bool{
        
        var inversion = 0
        
        for i in 0..<(list.count-1){
            for j in i+1..<(list.count){
                
                if(list[i]>list[j]){
                    inversion++
                }
            }
        }
        
        NSLog("%d",inversion)
        
        return inversion%2 == 0
    }
    
    func checkFinish()->Bool{
        
        var inversion = 0
        
        for i in 0..<(imagesPosition.count){
            for j in i+1..<(imagesPosition.count){
                
                if(imagesPosition[i]>imagesPosition[j]){
                    inversion++
                }
            }
        }
        
        //        dump(imagesPosition)
        //
        //        NSLog("%d",inversion)
        
        return inversion == 0
    }
    
    @IBAction func exitView(sender:AnyObject) {
        
        if(name != ""){
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let entity = NSEntityDescription.entityForName("Score",
                inManagedObjectContext:managedContext)
            
            let score = NSManagedObject(entity: entity!,
                insertIntoManagedObjectContext: managedContext)
            
            score.setValue(name, forKey: "name")
            score.setValue(totalScore, forKey: "score")
            
            do {
                try managedContext.save()
                NSLog("Insert Successfully")
                
            } catch let error as NSError  {
                NSLog("Can't insert DB")
            }
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func exitView2(sender:AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showOriginal"){
            
            let svc = segue.destinationViewController as! OriginalImage
            svc.image = self.image
        }
    }
    
    @IBAction func resetClick(sender: AnyObject) {
        
        for i in 0..<(tempImagesPosition.count){
            
            collectionOfImages![i].image = imageTileList[tempImagesPosition[i]]
            imagesPosition[i] = tempImagesPosition[i]
            moveCount = 0
            moveUpdate()
        }
    }

}

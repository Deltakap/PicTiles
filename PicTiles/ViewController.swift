//
//  ViewController.swift
//  PicTiles
//
//  Created by Puttipong S. on 11/20/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet var collectionOfImages: Array<UIImageView>?
    var imagesPosition: [Int] = [Int](count: 9, repeatedValue: -1)
    
    var indexTap1 = -1
    var indexTap2 = -1
    
    let puzzleSize = 9
    let tilesPerRow = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for(var i=0; i<puzzleSize; i++){
            
            collectionOfImages![i].addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: Selector("imageTapped:"))
            )
        }
        
        randomCreateImage()
    }
    
    func randomCreateImage(){
        
        let image: UIImage! = UIImage.init(named: "cat.jpg")
        let imageBlank: UIImage! = UIImage.init(named: "darkbg.gif")
        
        let tempImageRef: CGImageRef = image.CGImage!
        
        var imageTileList = [UIImage](count: 9, repeatedValue: image)
        
        for (var i = 0; i<tilesPerRow; i++) {
            for(var j = 0; j<tilesPerRow; j++){
                
                let start = Int(image.size.width/3)*j
                let stop = Int(image.size.height/3)*i
                
                NSLog("%f %f", CGFloat(start), CGFloat(stop))
                
                imageTileList[3*i+j] = UIImage.init(
                    CGImage: CGImageCreateWithImageInRect(tempImageRef,
                    CGRectMake(CGFloat(start), CGFloat(stop), image.size.width/3, image.size.height/3))!
                )
            }
        }
        
        imageTileList[puzzleSize-1] = imageBlank
        
        var solvable = false
        
        var positionTemp = [Int](count: 8, repeatedValue: -1)
        
        while(!solvable){
            
            positionTemp = shuffle([0,1,2,3,4,5,6,7])
            solvable = checkSolvable(positionTemp)
        }
        
        for i in 0..<(puzzleSize-1){
            
            imagesPosition[i] = positionTemp[i]
            collectionOfImages![i].image = imageTileList[positionTemp[i]]
        }
        
        imagesPosition[puzzleSize-1] = 8
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
            let checkEast = (indexTap1 + 1) == indexTap2
            let checkWest = (indexTap1 - 1) == indexTap2
            
            let adjacent = checkNorth || checkSouth || checkEast || checkWest
            
            if (checkEmpty && adjacent){
            
                let imgTemp = collectionOfImages![indexTap1].image
                let posTemp = imagesPosition[indexTap1]
                
                collectionOfImages![indexTap1].image = collectionOfImages![indexTap2].image
                collectionOfImages![indexTap2].image = imgTemp
                
                imagesPosition[indexTap1] = imagesPosition[indexTap2]
                imagesPosition[indexTap2] = posTemp
            
            }
            
            indexTap1 = -1
            indexTap2 = -1
        }
        
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
            for j in i+1..<(list.count-1){
                
                if(list[i]>list[j]){
                    inversion++
                }
            }
        }
        
        return inversion%2 == 0
    }

}


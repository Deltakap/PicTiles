//
//  ScoreBoard.swift
//  PicTiles
//
//  Created by Puttipong S. on 12/1/15.
//  Copyright © 2015 Puttipong S. All rights reserved.
//

import UIKit
import CoreData

class ScoreBoard: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var scoreBoard: UITableView!
    
    var scores = [Score]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scoreBoard.delegate = self
        scoreBoard.dataSource = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Score")
        
        let sortDescriptor = NSSortDescriptor(key: "score", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        do{
            try
            self.scores = managedContext.executeFetchRequest(fetchRequest) as! [Score]
        }
        catch{
            NSLog("Error Fetch")
        }
        
//        for score in scores{
//            NSLog(score.name!)
//            NSLog((score.score?.stringValue)!)
//        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("1")
        return scores.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        NSLog("2")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("rightCell", forIndexPath: indexPath) as UITableViewCell
        
        let score = scores[indexPath.row]
        
        let text = String(format: "%d.) "+score.name!,indexPath.row+1)
        cell.textLabel?.text = text
        cell.detailTextLabel?.text = (score.score?.stringValue)!
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

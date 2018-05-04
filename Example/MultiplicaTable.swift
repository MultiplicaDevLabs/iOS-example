//
//  MultiplicaDatasource.swift
//  Example
//
//  Created by Daniel Cabello on 3/22/18.
//  Copyright © 2018 Daniel Cabello. All rights reserved.
//

import Foundation
import UIKit
import FoldingCell

class MultiplicaTable : NSObject, UITableViewDataSource, UITableViewDelegate{
    var itemHeight = [CGFloat](repeating: 91.0, count: 100)
    let closeHeight: CGFloat = 91
    let openHeight: CGFloat = 166
    var repositories =  [Repository]()
    
    func reloadData(data repositories: [Repository]) {
        self.repositories = repositories
        itemHeight = [CGFloat](repeating: 91.0, count: repositories.count)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemHeight.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeight[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GithubFoldingCell.self), for: indexPath)
        if let cell = cell as? GithubFoldingCell {
            cell.repository = repositories[(indexPath as IndexPath).row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        var duration = 0.0
        if itemHeight[indexPath.row] == closeHeight { // open cell
            itemHeight[indexPath.row] = openHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
            
        } else {// close cell
            itemHeight[indexPath.row] = closeHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 1.1
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
 /*
 
 override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return itemHeight.count
 }
 
 override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCellWithIdentifier(String(DemoFoldingCell), forIndexPath: indexPath)
 
 return cell
 }
 
 override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
 return itemHeight[indexPath.row]
 }
 
 override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 let cell = tableView.cellForRowAtIndexPath(indexPath) as! FoldingCell
 
 var duration = 0.0
 if itemHeight[indexPath.row] == closeHeight { // open cell
 itemHeight[indexPath.row] = openHeight
 cell.selectedAnimation(true, animated: true, completion: nil)
 duration = 0.5
 } else {// close cell
 itemHeight[indexPath.row] = closeHeight
 cell.selectedAnimation(false, animated: true, completion: nil)
 duration = 1.1
 }
 
 UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
 tableView.beginUpdates()
 tableView.endUpdates()
 }, completion: nil)
 
 }*/
}

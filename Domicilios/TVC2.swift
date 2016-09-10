//
//  TVC2.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 8/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit

class TVC2: UITableViewController {
    let categorias:[String] = ["Nombre", "Valor del domicilio", "Tiempo del domicilio","Rating", "Categorias"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ordenar por:"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.categorias.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath)
        cell.imageView?.image = UIImage(named: "\(categorias[indexPath.row]).png")
        cell.textLabel?.text = self.categorias[indexPath.row]
        return cell
    }
    @IBAction func cancelar(sender: AnyObject) {
        //let navc = self.navigationController
        //navc?.performSegueWithIdentifier("inicio", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    /*
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 4
        {
            self.performSegueWithIdentifier("segue_categorias", sender: self)
        }
        else{
            self.performSegueWithIdentifier("segue_inicio", sender: self)
        }
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cc = segue.destinationViewController as! TVC
        cc.flag = false
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let ip = self.tableView.indexPathForSelectedRow
        if (ip!.row != 4){
            let navController = segue.destinationViewController as! UINavigationController
            let detailController = navController.topViewController as! TVC
            detailController.flag = ip!.row + 1;
        }
    }
 
}

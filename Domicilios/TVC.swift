//
//  TVC.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 8/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class TVC: UITableViewController {
    var contexto:NSManagedObjectContext? = nil
    var nombre:Array<String> = Array<String>()
    var categoria:Array<String> = Array<String>()
    var ubicacion_txt:Array<String> = Array<String>()
    var rating:Array<Int> = Array<Int>()
    var domicilio:Array<Int> = Array<Int>()
    var tiempo_domicilio:Array<Int> = Array<Int>()
    var imagen: Array<UIImage> = Array<UIImage>()
    var flag:Int = 0
    var orden:Array<Int> =  Array<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Domicilios"
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        switch flag {
        case 0:
            borrar()
            let urls = "https://api.myjson.com/bins/1zib8"
            let url = NSURL(string: urls)
            let datos:NSData? = NSData(contentsOfURL: url!)
            if datos == nil{
                let alert = UIAlertController(title:"Error", message: "No hay conexion a Internet", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alert, animated: true, completion: nil)
            }
            else{
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    let dico1 = json as! [NSDictionary]
                    for i in dico1{
                        //var restaurante:Array<String> = Array<String>()
                        let restaurante = restaurantes()
                        let cat = i["categorias"] as! NSString as String
                        restaurante.categorias = cat
                        let dom = i["domicilio"] as! NSString as String
                        restaurante.domicilio = Int(Double(dom)!)
                        let nom = i["nombre"] as! NSString as String
                        restaurante.nombre = nom
                        let rai = i["rating"] as! NSString as String
                        restaurante.rating = Int(Double(rai)!)
                        let tie = i["tiempo_domicilio"] as! NSString as String
                        restaurante.tiempo_domicilio = Int(tie)!
                        let map = i["ubicacion_txt"] as! NSString as String
                        restaurante.ubicacion_txt = map
                        
                        let foto2 = i["logo_path"] as! NSString as String
                        let fot = NSURL(string: foto2)
                        let dat = NSData(contentsOfURL: fot!)
                        if(dat != nil){
                            restaurante.logo_path = dat!
                            restaurante.flag_img = false
                        }
                        else{
                            restaurante.flag_img = true
                        }
                        let realm = try! Realm()
                        try! realm.write{
                            realm.add(restaurante)
                        }
                    }
                }
                catch _ {
                }
            }
            query()
        case 1:
            query()
            orden_nombre()
        case 2:
            query()
            orden_domicilio()
        case 3:
            query()
            orden_tiempo_domicilio()
        case 4:
            query()
            orden_rating()
        case 5:
            query_1()
        case 6:
            query_2()
        case 7:
            query_3()
        case 8:
            query_4()
        case 9:
            query_5()
        case 10:
            query_6()
        case 11:
            query_7()
        default:
            query()
        }
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
        return self.nombre.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda2", forIndexPath: indexPath) as! CustomCell
        if(orden.isEmpty){
        cell.nombre.text = self.nombre[indexPath.row]
        cell.categoria.text = self.categoria[indexPath.row]
        cell.foto.image = self.imagen[indexPath.row]
        cell.precio.text = "$ \(self.domicilio[indexPath.row])"
        cell.minutos.text = "\(self.tiempo_domicilio[indexPath.row]) min"
        switch self.rating[indexPath.row] {
        case 0:
            cell.e1.image = UIImage(named: "EG.png")!
            cell.e2.image = UIImage(named: "EG.png")!
            cell.e3.image = UIImage(named: "EG.png")!
            cell.e4.image = UIImage(named: "EG.png")!
            cell.e5.image = UIImage(named: "EG.png")!
        case 1:
            cell.e1.image = UIImage(named: "ED.png")!
            cell.e2.image = UIImage(named: "EG.png")!
            cell.e3.image = UIImage(named: "EG.png")!
            cell.e4.image = UIImage(named: "EG.png")!
            cell.e5.image = UIImage(named: "EG.png")!
        case 2:
            cell.e1.image = UIImage(named: "ED.png")!
            cell.e2.image = UIImage(named: "ED.png")!
            cell.e3.image = UIImage(named: "EG.png")!
            cell.e4.image = UIImage(named: "EG.png")!
            cell.e5.image = UIImage(named: "EG.png")!
        case 3:
            cell.e1.image = UIImage(named: "ED.png")!
            cell.e2.image = UIImage(named: "ED.png")!
            cell.e3.image = UIImage(named: "ED.png")!
            cell.e4.image = UIImage(named: "EG.png")!
            cell.e5.image = UIImage(named: "EG.png")!
        case 4:
            cell.e1.image = UIImage(named: "ED.png")!
            cell.e2.image = UIImage(named: "ED.png")!
            cell.e3.image = UIImage(named: "ED.png")!
            cell.e4.image = UIImage(named: "ED.png")!
            cell.e5.image = UIImage(named: "EG.png")!
        case 5:
            cell.e1.image = UIImage(named: "ED.png")!
            cell.e2.image = UIImage(named: "ED.png")!
            cell.e3.image = UIImage(named: "ED.png")!
            cell.e4.image = UIImage(named: "ED.png")!
            cell.e5.image = UIImage(named: "ED.png")!
            default: break
            }
        }
        else{
            cell.nombre.text = self.nombre[orden[indexPath.row]]
            cell.categoria.text = self.categoria[orden[indexPath.row]]
            cell.foto.image = self.imagen[orden[indexPath.row]]
            cell.precio.text = "$ \(self.domicilio[orden[indexPath.row]])"
            cell.minutos.text = "\(self.tiempo_domicilio[orden[indexPath.row]]) min"
            switch self.rating[orden[indexPath.row]] {
            case 0:
                cell.e1.image = UIImage(named: "EG.png")!
                cell.e2.image = UIImage(named: "EG.png")!
                cell.e3.image = UIImage(named: "EG.png")!
                cell.e4.image = UIImage(named: "EG.png")!
                cell.e5.image = UIImage(named: "EG.png")!
            case 1:
                cell.e1.image = UIImage(named: "ED.png")!
                cell.e2.image = UIImage(named: "EG.png")!
                cell.e3.image = UIImage(named: "EG.png")!
                cell.e4.image = UIImage(named: "EG.png")!
                cell.e5.image = UIImage(named: "EG.png")!
            case 2:
                cell.e1.image = UIImage(named: "ED.png")!
                cell.e2.image = UIImage(named: "ED.png")!
                cell.e3.image = UIImage(named: "EG.png")!
                cell.e4.image = UIImage(named: "EG.png")!
                cell.e5.image = UIImage(named: "EG.png")!
            case 3:
                cell.e1.image = UIImage(named: "ED.png")!
                cell.e2.image = UIImage(named: "ED.png")!
                cell.e3.image = UIImage(named: "ED.png")!
                cell.e4.image = UIImage(named: "EG.png")!
                cell.e5.image = UIImage(named: "EG.png")!
            case 4:
                cell.e1.image = UIImage(named: "ED.png")!
                cell.e2.image = UIImage(named: "ED.png")!
                cell.e3.image = UIImage(named: "ED.png")!
                cell.e4.image = UIImage(named: "ED.png")!
                cell.e5.image = UIImage(named: "EG.png")!
            case 5:
                cell.e1.image = UIImage(named: "ED.png")!
                cell.e2.image = UIImage(named: "ED.png")!
                cell.e3.image = UIImage(named: "ED.png")!
                cell.e4.image = UIImage(named: "ED.png")!
                cell.e5.image = UIImage(named: "ED.png")!
            default: break
            }
        }
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
     CustomTableViewCell
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
    func orden_nombre(){
        var nombre1 = nombre
        let nombre2 = nombre1.sort { $0 < $1 }
        for i in 0 ..< nombre1.count{
            for j in 0 ..< nombre1.count{
                if (nombre1[j] == nombre2[i]){
                    nombre1[j] = " "
                    orden.append(j)
                }
            }
        }
    }
    func orden_rating(){
        for i in 0 ..< rating.count {
            for j in 0 ..< rating.count {
                if(5-i == rating[j]){
                    orden.append(j)
                }
            }
        }
    }
    func orden_domicilio(){
        var domicilio2 = domicilio
        var val_max:Int = -1
        var vari:Int = 0
        for _ in 0 ..< domicilio2.count {
            for j in 0 ..< domicilio2.count {
                if(val_max < domicilio2[j]){
                    val_max = domicilio2[j]
                    vari = j
                }
            }
            val_max = -1
            orden.append(vari)
            domicilio2[vari] = -2
        }
    }
    func orden_tiempo_domicilio(){
        var domicilio2 = tiempo_domicilio
        var val_max:Int = 0
        var vari:Int = 0
        for _ in 0 ..< domicilio2.count {
            for j in 0 ..< domicilio2.count {
                if(val_max < domicilio2[j]){
                    val_max = domicilio2[j]
                    vari = j
                }
            }
            val_max = 0
            orden.append(vari)
            domicilio2[vari] = -1
        }
    }
    func borrar(){
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    func query(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        for rest in todosRestaurantes{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
             if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
             }
             else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
             }
        }
    }
    func query_1(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Hamburguesas y Perros Calientes'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_2(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Pollo'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_3(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Pizza'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_4(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Desayunos'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_5(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Sanduches'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_6(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Arepas'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    func query_7(){
        let realm = try! Realm()
        let todosRestaurantes = realm.objects(restaurantes)
        let filter = todosRestaurantes.filter("categorias == 'Comida Mexicana'")
        for rest in filter{
            ubicacion_txt.append(rest.ubicacion_txt)
            nombre.append(rest.nombre)
            categoria.append(rest.categorias)
            rating.append(rest.rating)
            domicilio.append(rest.domicilio)
            tiempo_domicilio.append(rest.tiempo_domicilio)
            if(rest.flag_img){
                let pr = UIImage(named: "placeholder.jpg")!
                imagen.append(pr)
            }
            else{
                let pr = UIImage(data:rest.logo_path)!
                imagen.append(pr)
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let ip = self.tableView.indexPathForSelectedRow
        if (ip?.row != nil){
            let cc = segue.destinationViewController as! VC
            if(orden.isEmpty){
                cc.nom = self.nombre[ip!.row]
                cc.cat = self.categoria[ip!.row]
                cc.map = self.ubicacion_txt[ip!.row]
                cc.imagen = self.imagen[ip!.row]
                cc.domicilio = self.domicilio[ip!.row]
                cc.tiempo_domicilio = self.tiempo_domicilio[ip!.row]
                cc.rat = self.rating[ip!.row]
            }
            else{
                cc.nom = self.nombre[orden[ip!.row]]
                cc.cat = self.categoria[orden[ip!.row]]
                cc.map = self.ubicacion_txt[orden[ip!.row]]
                cc.imagen = self.imagen[orden[ip!.row]]
                cc.domicilio = self.domicilio[orden[ip!.row]]
                cc.tiempo_domicilio = self.tiempo_domicilio[orden[ip!.row]]
                cc.rat = self.rating[orden[ip!.row]]
            }
        }
    }

}

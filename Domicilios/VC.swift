//
//  VC.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 10/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
import CoreLocation

class VC: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var e1: UIImageView!
    @IBOutlet weak var e2: UIImageView!
    @IBOutlet weak var e3: UIImageView!
    @IBOutlet weak var e4: UIImageView!
    @IBOutlet weak var e5: UIImageView!
    @IBOutlet weak var categoria: UILabel!
    @IBOutlet weak var mapa: MKMapView!
    @IBOutlet weak var precio: UILabel!
    @IBOutlet weak var tiempo: UILabel!
    @IBOutlet weak var not: UILabel!
    
    var nom : String = " "
    var map : String = " "
    var cat : String = " "
    var rat : Int = 0
    var domicilio : Int = 0
    var tiempo_domicilio : Int = 0
    var imagen:UIImage = UIImage()
    private let manejador = CLLocationManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        var punto = CLLocationCoordinate2D()
        if (map != ""){
            mapa.hidden = false
            let characters = map.characters.map { String($0) }
            var num1 = ""
            var num2 = ""
            var flag = true
            for i in 0 ..< characters.count{
                if (characters[i] == ","){
                    flag = false
                }
                if flag {
                    num1 = "\(num1)\(characters[i])"
                }
                else if(characters[i] != ","){
                    num2 = "\(num2)\(characters[i])"
                }
            }
            let latitud = Double(num1)
            let longitud = Double(num2)
            
            punto.latitude = latitud!
            punto.longitude = longitud!
            let pin = MKPointAnnotation()
            pin.title = nom
            pin.subtitle = cat
            pin.coordinate = punto
            mapa.addAnnotation(pin)
        }
        else{
            mapa.hidden = true
            not.hidden = false
        }
        
        let region = MKCoordinateRegion(center: punto, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapa.setRegion(region, animated: true)
        
        nombre.text = nom
        foto.image = imagen
        categoria.text = cat
        precio.text = "$ \(domicilio)"
        tiempo.text = "\(tiempo_domicilio) min"
        switch rat {
        case 0:
            e1.image = UIImage(named: "EG.png")!
            e2.image = UIImage(named: "EG.png")!
            e3.image = UIImage(named: "EG.png")!
            e4.image = UIImage(named: "EG.png")!
            e5.image = UIImage(named: "EG.png")!
        case 1:
            e1.image = UIImage(named: "ED.png")!
            e2.image = UIImage(named: "EG.png")!
            e3.image = UIImage(named: "EG.png")!
            e4.image = UIImage(named: "EG.png")!
            e5.image = UIImage(named: "EG.png")!
        case 2:
            e1.image = UIImage(named: "ED.png")!
            e2.image = UIImage(named: "ED.png")!
            e3.image = UIImage(named: "EG.png")!
            e4.image = UIImage(named: "EG.png")!
            e5.image = UIImage(named: "EG.png")!
        case 3:
            e1.image = UIImage(named: "ED.png")!
            e2.image = UIImage(named: "ED.png")!
            e3.image = UIImage(named: "ED.png")!
            e4.image = UIImage(named: "EG.png")!
            e5.image = UIImage(named: "EG.png")!
        case 4:
            e1.image = UIImage(named: "ED.png")!
            e2.image = UIImage(named: "ED.png")!
            e3.image = UIImage(named: "ED.png")!
            e4.image = UIImage(named: "ED.png")!
            e5.image = UIImage(named: "EG.png")!
        case 5:
            e1.image = UIImage(named: "ED.png")!
            e2.image = UIImage(named: "ED.png")!
            e3.image = UIImage(named: "ED.png")!
            e4.image = UIImage(named: "ED.png")!
            e5.image = UIImage(named: "ED.png")!
        default: break
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            manejador.startUpdatingLocation()
            mapa.showsUserLocation = true
        }else{
            manejador.stopUpdatingLocation()
            mapa.showsUserLocation = false
        }
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

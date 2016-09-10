//
//  RealmRestaurante.swift
//  Domicilios
//
//  Created by Carlos Buitrago on 9/09/16.
//  Copyright © 2016 Carlos Buitrago. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class restaurantes: Object {
    dynamic var nombre = ""
    dynamic var categorias = ""
    dynamic var ubicacion_txt = ""
    dynamic var domicilio = 0
    dynamic var rating = 0
    dynamic var tiempo_domicilio = 0
    dynamic var flag_img = true
    dynamic var logo_path = NSData()
}
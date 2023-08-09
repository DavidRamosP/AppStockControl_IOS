//
//  ListaViewController.swift
//  Almacen
//
//  Created by beyser on 30/07/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct ProductoFirebase{
    let motivo: String
    let nombre: String
    let sku: String
    let stock: String
    let fecha: Date
}

class ListaViewController: UIViewController, UITableViewDataSource {
  
    @IBOutlet weak var listaTableView: UITableView!
    var productoLista : [ProductoFirebase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaTableView.dataSource = self
        self.obtenerProductos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productoLista.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaProducto" , for: indexPath) as! ListaTableViewCell
        let producto = productoLista[indexPath.row]
        
        cell.motivoLabel.text = producto.motivo
        cell.nombreLabel.text = producto.nombre
        cell.skuLabel.text = producto.sku
        cell.stockLabel.text = producto.stock
          let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
             let fechaString = dateFormatter.string(from: producto.fecha)
             cell.fechaLabel.text = fechaString
       
        return cell
    }
    
    
    func obtenerProductos(){
        productoLista.removeAll()
        let db = Firestore.firestore()
        db.collection("productos").getDocuments(completion: {(query, error) in
            if let err = error{
                print("Se presento un error")
            }else{
                for document in query!.documents{
                    let data = document.data()
                    let motivo = data["comentario"] as? String ?? ""
                    let nombre = data["nombre"] as? String ?? ""
                    let sku = data["sku"] as? String ?? ""
                    let stock = data["stock"] as? String ?? ""
                    let timestamp = data["fecha"] as? Timestamp
                    let fecha = timestamp?.dateValue()
                    
                    let product = ProductoFirebase(motivo: motivo, nombre: nombre, sku: sku, stock: stock, fecha: fecha ?? Date())
                    self.productoLista.append(product)
                    
                }
                
                self.listaTableView.reloadData()
            }
        })
    }
    
    
    @IBAction func ActulizarButton(_ sender: Any) {
        self.obtenerProductos()
    }
    
}

  

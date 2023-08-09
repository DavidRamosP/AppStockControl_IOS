//
//  BuscarViewController.swift
//  Almacen
//
//  Created by beyser on 30/06/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct ProductosFirebase{
    let imagen: String
    let nombre: String
    let precio: String
    let proveedor: String
    let sku: String
    let stock: String
}

class BuscarViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate {
   
    @IBOutlet weak var buscarTableView: UITableView!
    
    @IBOutlet weak var buscarSearchBar: UISearchBar!
    
    var productoBuscar : [ProductosFirebase] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       buscarTableView.dataSource = self
       buscarSearchBar.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productoBuscar.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuscarItem", for: indexPath) as! BuscarTableViewCell
        let producto = productoBuscar[indexPath.row]
           
        cell.nombreLabel.text = String(format: "%@ %@", "Nombre:",producto.nombre)
        cell.precioLabel.text = String(format: "%@ %@", "Precio:",producto.precio)
        cell.proveedorLabel.text = String(format: "%@ %@", "Proveedor:",producto.proveedor)
        cell.skuLabel.text = String(format: "%@ %@", "SKU:",producto.sku)
        cell.stockLabel.text = String(format: "%@ %@", "STOCK:",producto.stock)
        
        let urlIMG = producto.imagen
        let data = try! Data(contentsOf: URL(string: urlIMG)!)
        DispatchQueue.main.async{
            cell.imageView?.image = UIImage(data: data)
        }
       
        return cell
        
     
       }
    //----------------------
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
        
         
      }
    
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          searchBar.resignFirstResponder()
          guard let query = searchBar.text else {return}
           print(query)
        
        self.buscarProductos(query: query)
        
        
      }
    
        //----------------------
    
 
    func buscarProductos(query: String){
        productoBuscar.removeAll()
        let db = Firestore.firestore()
        let productoCollection = db.collection("productos")
        let queryFirestore = productoCollection.whereField("sku", isEqualTo: query)
        queryFirestore.getDocuments(completion: { (queryStore, error)  in
            for document in queryStore!.documents{
                let data = document.data()
             let img = data["img"] as? String ?? ""
             let nombre = data["nombre"] as? String ?? ""
             let precio = data["precio"] as? String ?? ""
             let proveedor = data["proveedor"] as? String ?? ""
             let sku = data["sku"] as? String ?? ""
             let stock = data["stock"] as? String ?? ""
             let product = ProductosFirebase(imagen: img, nombre: nombre, precio: precio, proveedor: proveedor, sku: sku, stock: stock)
                self.productoBuscar.append(product)
            
            }
            
            self.buscarTableView.reloadData()
       
        })
        
    }
  
    
}

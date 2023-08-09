//
//  ActulizarViewController.swift
//  Almacen
//
//  Created by beyser on 01/07/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct productosFirebase{
    let comentario: String
    let sku: String
    let stock: String
}



class ActulizarViewController: UIViewController {

    @IBOutlet weak var SkuTextField: UITextField!
    
    @IBOutlet weak var StockTextField: UITextField!
    
    @IBOutlet weak var MotivoTextField: UITextField!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
 
    
    @IBAction func actualizarButton(_ sender: Any) {
        
          guard let sku = SkuTextField.text, !sku.isEmpty,
          let stock = StockTextField.text, !stock.isEmpty,
          let comentario = MotivoTextField.text, !comentario.isEmpty else {
          mostrarAlerta(mensaje: "Asegúrate de completar todos los campos.")
                     return
        }
        let fechaActual = Date()
        let db = Firestore.firestore()
             let docRef = db.collection("productos").document(sku)
             docRef.updateData([
                 "stock": stock,
                 "comentario": comentario,
                 "fecha": fechaActual,
    
             ]) { error in
                 if let error = error {
// Llama a la función mostrarAlerta si hay un error al actualizar el documento
                    self.mostrarAlerta(mensaje: "Asegurate de llenar el sku correcto")
                 } else {
                    self.mostrarAlerta(mensaje: "Se actualizo correctamente")
                     self.SkuTextField.text = ""
                     self.StockTextField.text = ""
                     self.MotivoTextField.text = ""
                   
                 }
                
             }
         }
    
    //funcion para mostrar alerta
    func mostrarAlerta(mensaje: String) {
        let alert = UIAlertController(title: "MENSAJE",message: mensaje,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
  
}

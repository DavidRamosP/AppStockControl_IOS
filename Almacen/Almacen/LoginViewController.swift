	//
//  LoginViewController.swift
//  Almacen
//
//  Created by beyser on 27/06/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var correoTextField: UITextField!
    
    @IBOutlet weak var contrasenaTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func verificarLogin(_ sender: Any) {
        let correo = correoTextField.text ?? ""
        let contrasena = contrasenaTextField.text ?? ""
        
        if correo.isEmpty && contrasena.isEmpty{
            
        }else{
            Auth.auth().signIn(withEmail: correo, password: contrasena, completion: { result, error in if let resultLogin = result{
                print("Bienvenido")
                let userId = resultLogin.user.uid
                self.obtenerUsuario(uid: userId)
                
                
            }else{
                self.mostrarAlerta(mensaje: "Verificar datos ingresados")
                }
        })
    }
}
    
    func obtenerUsuario(uid: String){
        let db = Firestore.firestore()
        let docref = db.collection("users").document(uid)
        docref.getDocument(completion: {(document, error) in
            if let document = document, document.exists{
                let data = document.data()
                let correo = data?["correo"] as? String ?? ""
                let nombre = data?["nombre"] as? String ?? ""
                let apellido = data?["apellido"] as? String ?? ""
                
                self.saveUserDefaults(nombre: nombre, apellido: apellido, correo: correo)
               self.inicioMenu()
                
            }else{
                self.mostrarAlerta(mensaje: "Usuario no existe")
              
            }
        })
    }
    
    
    
    func inicioMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inicio = storyboard.instantiateViewController(withIdentifier: "BarViewController") as! BarViewController
        inicio.modalPresentationStyle = .fullScreen
        self.present(inicio, animated: true, completion: nil)
    }

    func saveUserDefaults(nombre: String,apellido: String,correo: String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: Constantes.userDefaults.login)
        userDefaults.set(nombre, forKey: Constantes.userDefaults.nombre)
        userDefaults.set(apellido, forKey: Constantes.userDefaults.apellido)
        userDefaults.set(correo, forKey: Constantes.userDefaults.correo)
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

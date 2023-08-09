//
//  InicioViewController.swift
//  Almacen
//
//  Created by beyser on 10/07/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController {

    @IBOutlet weak var nombreLabel: UILabel!
    
    @IBOutlet weak var apellidoLabel: UILabel!
    
    @IBOutlet weak var correoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cargarDatos()
        

    }
    
    func cargarDatos(){
    let userDefaults = UserDefaults.standard
    let nombre = userDefaults.string(forKey:Constantes.userDefaults.nombre)
    let apellido = userDefaults.string(forKey:Constantes.userDefaults.apellido)
    let correo = userDefaults.string(forKey: Constantes.userDefaults.correo)
        
        nombreLabel.text = "\(nombre ?? "")"
        apellidoLabel.text = "\(apellido ?? "")"
        correoLabel.text = "\(correo ?? "")"
        
    }

    @IBAction func cerrarSesion(_ sender: Any) {
        cierreSesion()
    }
    
    
    func cierreSesion(){
    let alerta = UIAlertController(title: "¿Desea cerrar sesion?", message: "Seleccione una opcion", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "CANCELAR", style: .cancel, handler: nil))
        alerta.addAction(UIAlertAction(title: "ACEPTAR", style: .default, handler: { action in self.eliminarSesion() }))
        self.present(alerta, animated: true, completion: nil)
    }

    func eliminarSesion(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        self.viewComensar()
    }
    func viewComensar(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let comensarView = storyBoard.instantiateViewController(withIdentifier: "ComiensoViewController") as! ComiensoViewController
        let navigationController = UINavigationController(rootViewController: comensarView)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
        
    }
}

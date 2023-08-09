//
//  ComiensoViewController.swift
//  Almacen
//
//  Created by beyser on 12/07/23.
//  Copyright © 2023 beyser. All rights reserved.
//

import UIKit

class ComiensoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewWillAppear(_ animated: Bool){
        if verificarSesion(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menuView = storyboard.instantiateViewController(identifier: "BarViewController") as! BarViewController
            menuView.modalPresentationStyle = .fullScreen
            self.present(menuView, animated: true, completion: nil)
        }
    }
    
    
    func verificarSesion() -> Bool{
    let login = UserDefaults.standard.bool(forKey:Constantes.userDefaults.login)
        return login
    }
   

}

//
//  UIImageView+Extension.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import UIKit

extension UIImageView{
    func loadImage(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }else{
                self?.image = UIImage(named: "fondo3")
            }
        }
    }
    

}

//
//  DetailViewController.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    
    //MARK: - Models
    private var appState: AppState
    private var viewModel: DetailViewModel
    
    //MARK: - Variables
    private var hero: Heroes?
    private var transform:Transformation?

    init(hero: Heroes? = nil, transform: Transformation? = nil,appState:AppState,viewModel:DetailViewModel ) {
        self.hero = hero
        self.transform = transform
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let hero = viewModel.heroData {
            imgDetail.loadImage(url: URL(string: hero.photo!)!)
            lblName.text = hero.name
            txtDescription.text = hero.description
        }else{
            if let transform = viewModel.transformData{
                imgDetail.loadImage(url: URL(string: transform.photo!)!)
                lblName.text = transform.name
                txtDescription.text = transform.description
            }
        }
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

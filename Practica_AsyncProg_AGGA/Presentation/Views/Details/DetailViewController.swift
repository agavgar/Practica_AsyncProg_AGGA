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

        self.title = "Detail"
        setRightBar(UInavItem: self.navigationItem, UInavCont: self.navigationController!)
        navigationController?.navigationBar.tintColor = .yellow
        
        checkUI()
        
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOut))
        navigationController?.navigationItem.rightBarButtonItem?.tintColor = .yellow
        
    }
    
    @objc
    func logOut(_sender: Any) {
        self.appState.LogOut()
    }
    
    func checkUI(){
        
        txtDescription.textColor = .white
        
        if viewModel.heroData != nil, let hero = viewModel.heroData {
            DispatchQueue.main.async {
                self.imgDetail.loadImage(url: URL(string: hero.photo!)!)
                self.lblName.text = hero.name
                self.txtDescription.text = hero.description
            }
        }else{
            if viewModel.transformData != nil, let transform = viewModel.transformData, let info = transform.description{
                DispatchQueue.main.async {
                    self.imgDetail.loadImage(url: URL(string: transform.photo!)!)
                    self.lblName.text = transform.name
                    self.txtDescription.text = info // NO FUNCIONA ESTA LINEA Y NO SE PORQUÉ
                    print("Es este: \(info)")
                }
            }
        }
    }

}

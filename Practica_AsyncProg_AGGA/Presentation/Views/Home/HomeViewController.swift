//
//  HomeViewController.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Models
    private var appState: AppState
    private var viewModel: HeroesViewModel
    
    private var suscriptors = Set<AnyCancellable>()
    
    //MARK: - Init
    init(appState: AppState, viewModel: HeroesViewModel) {
        self.appState = appState
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Heroes"
        setRightBar(UInavItem: self.navigationItem, UInavCont: self.navigationController!)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        binding()
    }

    
    //MARK: - Add button on the right bar
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
        
    }
    
    @objc
    func logOut(_sender: Any) {
        self.appState.LogOut()
    }
    
    func binding(){
        self.viewModel.$heroData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.tableView.reloadData()
            })
            .store(in: &suscriptors)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.heroData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        
        let hero = viewModel.heroData[indexPath.row]
        
        if let name = hero.name,let photo = hero.photo {
            cell.heroLbl.text = name
            cell.heroImage.loadImage(url: URL(string: photo)!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = viewModel.heroData[indexPath.row].id{
            let transformViewModel = TransformViewModel(id: id)
            let transformVC = TransformationViewController(appState: self.appState, viewModel: transformViewModel)
            self.navigationController?.pushViewController(transformVC, animated: true)
        }
        
    }
}



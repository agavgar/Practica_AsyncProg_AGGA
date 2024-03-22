//
//  TransformationViewController.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 21/3/24.
//

import UIKit
import CombineCocoa
import Combine

class TransformationViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblNoData: UILabel!
    
    //MARK: - Models
    private var appState:AppState
    private var viewModel: TransformViewModel
    
    private var suscriptors = Set<AnyCancellable>()
    
    init(appState: AppState, viewModel: TransformViewModel) {
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
        
        self.title = "Transform"
        setRightBar(UInavItem: self.navigationItem, UInavCont: self.navigationController!)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "HeroTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        binding()
        
    }
    
    func setRightBar(UInavItem: UINavigationItem,UInavCont: UINavigationController ){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem?.tintColor = .yellow
        
    }
    
    @objc
    func logOut(_sender: Any) {
        self.appState.LogOut()
    }
    
    
    //MARK: - Binding UI
    func binding(){
        self.viewModel.$transformData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] data in
                self?.tableView.reloadData()
                if data.isEmpty{
                    DispatchQueue.main.async {
                        self?.lblNoData.isHidden = false
                    }
                }else{
                    DispatchQueue.main.async {
                        self?.lblNoData.isHidden = true
                    }
                }
            })
            .store(in: &suscriptors)
    }
}

//MARK: - Datasource
extension TransformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewModel = DetailViewModel(transformData: viewModel.transformData[indexPath.row])
        let detailVC = DetailViewController(appState: self.appState, viewModel: detailViewModel)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
//MARK: - Delegate
extension TransformationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transformData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HeroTableViewCell
        
        let transform = viewModel.transformData[indexPath.row]
        
        if let name = transform.name, let photo = transform.photo {
            cell.heroLbl.text = name
            cell.heroImage.loadImage(url: URL(string: photo)!)
        }
        
        return cell
        
        
    }
    
    
    
}

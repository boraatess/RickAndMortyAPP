//
//  HomeViewController.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 14.06.2022.
//

import SnapKit
import UIKit
import AlamofireMapper
import Alamofire

class HomeViewController: BaseVC {
    
    let screen = UIScreen.main.bounds
    var page = 1
    public static var characterModel: CharacterResponse?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(HomeTableviewCell.self, forCellReuseIdentifier: "homeCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func getData() {
        NetworkManager().getCharacterList(page: String(page)) { [weak self] response in
            DispatchQueue.main.async {
                self?.characterModel = response
                HomeViewController.characterModel? = response
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func clickedFilter() {
        let vc = FilterViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
}

extension HomeViewController {
    
    func layout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.setupNav()
    }
    
    func setupNav() {
        let filter = UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(clickedFilter))
        navigationItem.rightBarButtonItem = filter
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.characterModel?.results?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableviewCell
        let result = self.characterModel?.results?[indexPath.row]
        guard let response = result else { return UITableViewCell() }
        cell.refreshCell(response: response)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            print("fetch more")
            
            guard !NetworkManager().isPaginating else {
                return
            }
            
            tableView.tableFooterView = createSpinnerFooter()
            
            let pageInt = self.page + 1
            let pageS = pageInt
            self.page = pageS
            
            print(pageS)
            
            NetworkManager().getCharacterList(pagination: true, page: String(pageS)) { [weak self] response in
                if response.results?.count == 0 {
                    let pageInt = (Int(self!.page) ) - 1
                    let pageS = String(pageInt)
                    self!.page = Int(pageS) ?? 0
                }
                if response.results?.isEmpty == false {
                    var charList = CharacterResponse()
                    charList.results = response.results
                    charList.info = response.info
                    
                    HomeViewController.characterModel?.results?.append(contentsOf: response.results!)
                    self?.characterModel?.results?.append(contentsOf: response.results!)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                else {
                    print("Error")
                }
            }
        
        }
    }
    
}

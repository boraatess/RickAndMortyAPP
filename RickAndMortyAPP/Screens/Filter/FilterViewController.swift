//
//  FilterViewController.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 16.06.2022.
//

import SnapKit
import UIKit
 
class FilterViewController: BaseVC {
    
    private let viewContent: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.alpha = 1
        view.layer.opacity = 1
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "filterCell")
        return tableView
    }()
    
    var names: [String] = ["Rick","Morty"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.layout()
    }
    
}

extension FilterViewController {
    
    func layout() {
        view.backgroundColor = .gray
        view.alpha = 0.8
        //view.layer.opacity = 1
        view.addSubview(viewContent)
        viewContent.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(320)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(320)
        }
        viewContent.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        // cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(names[indexPath.row])
        if indexPath.row == 0 {
            self.sendRequest(id: 1)
        }
        else if indexPath.row == 1 {
            self.sendRequest(id: 2)
        }
        self.dismiss(animated: true)
    }
     
    func sendRequest(id: Int) {
        NetworkManager().getCharacterWithID(id: String(id)) { [weak self] response in
            DispatchQueue.main.async {
                if response.name != "" {
                    HomeTableviewCell.result = response
                    
                    self?.tableView.reloadData()
                }
                else {
                    print("Error!")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: -10, y: 0, width: screenSize().width * 0.8, height: 50))
        view.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: screenSize().width, height: 30))
        label.text = "Filter"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

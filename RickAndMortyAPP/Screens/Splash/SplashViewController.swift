//
//  SplashViewController.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 14.06.2022.
//

import UIKit
import SnapKit

class SplashViewController: UIViewController {
    
    private let imgCover: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        checkOutUser()
    }
    
    func checkOutUser() {
        self.layout()
        NetworkManager().getCharacterList(page: "1") { response in
            if response.results?.count ?? 0 > 0 {
                self.showHome()

            }
            else {
                self.showAlert()
            }
        }
    }
    
    func showHome() {
        let vc = HomeViewRouter().prepareView()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "UYARI!", message: "Lütfen internet bağlantı ayarlanızı kontrol ediniz.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Kapat", style: .destructive) { action in
            
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

extension SplashViewController {
    func layout() {
        view.backgroundColor = .white
        imgCover.image = UIImage(named: "rickandmorty")
        view.addSubview(imgCover)
        imgCover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

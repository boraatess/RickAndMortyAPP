//
//  HomeRouter.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 14.06.2022.
//

import Foundation
import UIKit

class HomeViewRouter {
    
    let screen = UIScreen.main.bounds
    var view = HomeViewController()
    
    func prepareView() -> UIViewController {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screen.width/2, height: 44))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.textColor = .black
        label.text = "Rick and Morty"
        label.font = UIFont(name: "AvenirNext-Heavy", size: 24)
        self.view.navigationItem.titleView = label
        return view
    }
    
}

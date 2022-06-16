//
//  BaseVC.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 16.06.2022.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    var characterModel: CharacterResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}

//
//  HomeTableviewCell.swift
//  RickAndMortyAPP
//
//  Created by bora ateş on 14.06.2022.
//

import UIKit
import SnapKit
import Kingfisher

class HomeTableviewCell: UITableViewCell {
    let screen = UIScreen.main.bounds
    
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .systemGray5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    private let imgCover: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let idLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "#id:"
        label.font = .systemFont(ofSize: 20)
       return label
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Name:"
        label.font = .systemFont(ofSize: 20)
       return label
    }()
    
    private let locationLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Location:"
        label.font = .systemFont(ofSize: 20)
       return label
    }()
    
    public static var result: Result?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
        
    }
    
    func refreshCell(response: Result) {
        HomeTableviewCell.result = response
        let url = URL(string: response.image ?? "")
        imgCover.kf.setImage(with: url)
        idLabel.text = "#id: \(response.id ?? 0)"
        nameLabel.text = "Name: \(response.name ?? "")"
        locationLabel.text = "Location: \(response.location?.name ?? "")"
    }
    
    func layout() {
        contentView.addSubview(shadowView)
        shadowView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(screen.width-100)
            make.height.equalTo(screen.width)
            make.edges.equalToSuperview()
        }
        shadowView.addSubview(imgCover)
        imgCover.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(screen.width)
            make.height.equalTo(screen.width-100)
        }
        shadowView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(imgCover.snp.bottom)
            make.trailing.equalToSuperview().inset(30)
        }
        shadowView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom)
            make.leading.equalToSuperview().offset(30)
        }
        shadowView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
        }
    }
}

//
//  MovieViewController.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/8/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class MovieViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    let searchBar = UISearchBar()
    
    let addButton = {
        let bt = UIButton()
        bt.setTitle("추가", for: .normal)
        bt.backgroundColor = .lightGray
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
        return bt
    }()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    private func configureVC() {
        view.backgroundColor = .white
        navigationItem.title = "Movie"
        configureHierachy()
        configureLayout()
    }
    private func configureHierachy() {
        [collectionView, searchBar, tableView].forEach{view.addSubview($0)}
        searchBar.addSubview(addButton)
    }
    private func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }

        addButton.snp.makeConstraints { make in
            make.trailing.equalTo(searchBar.snp.trailing).inset(16)
            make.centerY.equalTo(searchBar)
            make.width.equalTo(52)
            make.height.equalTo(32)
        }
        collectionView.backgroundColor = .blue
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        tableView.backgroundColor = .cyan
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(collectionView.snp.bottom)
        }
    }
}

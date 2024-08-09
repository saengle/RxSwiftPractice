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
    
    private let movieView = MovieView()
    
    private let vm = MovieViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = movieView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureVC()
    }
    
    private func bind() {
        let data = ["스트림덱", "키보드", "손풍기", "컵", "마우스패드", "샌들", ""]
        let myData = BehaviorSubject(value: data)
        myData.bind(to: movieView.collectionView.rx
            .items(cellIdentifier: MovieCollectionViewCell.id, cellType: MovieCollectionViewCell.self)) { (row, element, cell) in
            cell.label.text = "\(element)"
        }.disposed(by: disposeBag)
        
        myData.bind(to: movieView.tableView.rx
            .items(cellIdentifier: MovieTableViewCell.id, cellType: MovieTableViewCell.self)) { (row, element, cell) in
            cell.appNameLabel.text = element
        }.disposed(by: disposeBag)
    }
    
    private func configureVC() {
        navigationItem.title = "Movie"
    }
}

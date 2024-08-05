//
//  SimpleTableView.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxSwift
import RxCocoa

class SimpleTableView: UIViewController {
    
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let items = Observable.just((0..<20).map{
            "\($0)"})
        
        items.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = "\(element) & row \(row)"
        }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: {value in
            print("tapped \(value)")})
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .subscribe(onNext: {indexPath in
                print("\(indexPath.section), \(indexPath.row) pressed")
            })
            .disposed(by: disposeBag)// ????
    }
}

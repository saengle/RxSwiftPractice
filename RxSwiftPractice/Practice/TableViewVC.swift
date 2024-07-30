//
//  TableViewVC.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//
import UIKit

import RxCocoa
import RxSwift
import SnapKit

class TableViewVC: UIViewController {
    let tableView = UITableView()
    let label = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([ 
        "꿀잠자기",
        "영화보기",
        "수영하기"
        ])
        
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self) //셀 터치 이벤트
            .map{ data in
            "\(data)를 클릭했습니다"}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.backgroundColor = .blue
        label.backgroundColor = .lightGray
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(300)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
    }
}

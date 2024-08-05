//
//  ShoppingVC.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/5/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ShoppingVC: UIViewController {
    
    let textField = { 
        let tf = UITextField()
        tf.placeholder = "추가할 쇼핑 리스트를 입력해주세요"
        return tf
    }()
    let addButton = {
        let bt = UIButton()
        bt.setTitle("추가", for: .normal)
        return bt
    }()
    let tableView = UITableView()
    
    let vm = ShoppingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    let disposeBag = DisposeBag()
    
    func bind() {
//        let input = ShoppingViewModel.Inpu
//        let output = vm.transform
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just([
        "아이패드",
        "아이폰",
        "아이폰플립"
        ])
        
        items.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self) //셀 터치 이벤트
            .map{ data in
            "\(data)를 클릭했습니다"}
            .bind(with: self, onNext: { owner, value in
                print(value)
            })
            .disposed(by: disposeBag)
        
        addButton.rx.tap
            .bind(with: self) { owner, _ in
                print("버튼 눌림")
            }
    }
    
    func setUI() {
        navigationItem.title = "쇼핑"
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        
        textField.backgroundColor = .lightGray
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(44)
        }
        addButton.tintColor = .gray
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.trailing.equalTo(textField.snp.trailing).inset(16)
            make.height.equalTo(32)
            make.width.equalTo(72)
        }
        tableView.backgroundColor = .blue
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}

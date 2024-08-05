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
struct Shopping: Identifiable {
    let id = UUID()
    var isChecked: Bool
    var isStar: Bool
    let content: String
}

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
    
    var items = [
        Shopping(isChecked: true, isStar: false, content: "아이폰사기"),
        Shopping(isChecked: false, isStar: true, content: "콩나물 사가기"),
        Shopping(isChecked: false, isStar: true, content: "통 앞다리살 두근")]
    
   lazy var itemList = BehaviorRelay(value: items)
    
    func bind() {
        
        
        tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.id)
        
        //        let input = ShoppingViewModel.Input(addTapCell: , addTapCheck: <#T##ControlEvent<Void>#>, addTapStar: <#T##ControlEvent<Void>#>, row: <#T##ControlProperty<Int>#>, shoppings: <#T##BehaviorRelay<[Shopping]>#>)
        //        let output = vm.transform(input: input)
        //
        
        
        
        itemList.bind(to: tableView.rx.items(cellIdentifier: ShoppingTableViewCell.id, cellType: ShoppingTableViewCell.self)) { (row, element, cell) in
            print(element)
            print(type(of: element))
            //            cell.configureCell(data: element)
            cell.checkButton.rx.tap
                .bind(with: self) { owner, _ in
                    print(owner)
                }.disposed(by: cell.disposeBag)
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
                owner.textField.rx.text.orEmpty
                    .bind(with: self) { owner, value in
                        owner.items.append(Shopping(isChecked: false, isStar: false, content: value))
                    }
                owner.itemList.accept(owner.items)
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

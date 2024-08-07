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
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    let tableView = UITableView()
    
    let vm = ShoppingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    let disposeBag = DisposeBag()
    
    func bind() {
        
        let input = ShoppingViewModel.Input(
//            addTapCell: <#T##ControlEvent<Void>#>,
//            tapCheck: ,
//            addTapStar: <#T##ControlEvent<Void>#>,
//            row: <#T##ControlProperty<Int>#>,
//            shoppings: BehaviorSubject<[Shopping]>
        )
        
        let checkTap: () = ()
        
        let output = vm.transform(input: input)
        

        
        output.tableShoppings.bind(to: tableView.rx.items(cellIdentifier: ShoppingTableViewCell.id, cellType: ShoppingTableViewCell.self)) {(row, element, cell) in
            cell.configureCell(data: element)
            
            cell.checkButton.rx.tap
                .bind(with: self) { owner, void in
                    owner.vm.tableItems[row].isChecked.toggle()
                }.disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        output.collectionShoppings.bind(to: collectionView.rx.items(cellIdentifier: ShoppingCollectionViewCell.id, cellType: ShoppingCollectionViewCell.self)) { (row, element, cell) in
            cell.configureCell(data: element)
        }
        .disposed(by: disposeBag)
        
//        tableView.rx.modelSelected(String.self) //셀 터치 이벤트
//            .map{ data in
//                "\(data)를 클릭했습니다"}
//            .bind(with: self, onNext: { owner, value in
//                print(value)
//            })
//            .disposed(by: disposeBag)
        
//        addButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.textField.rx.text.orEmpty
//                    .bind(with: self) { owner, value in
//                        owner.items.append(Shopping(isChecked: false, isStar: false, content: value))
//                    }
//                owner.itemList.accept(owner.items)
//            }
    }
    
    func setUI() {
        navigationItem.title = "쇼핑"
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(addButton)
        view.addSubview(tableView)
        view.addSubview(collectionView)
        
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
        
        collectionView.register(ShoppingCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCollectionViewCell.id)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.id)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}

//
//  ShoppingTableViewCell.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/5/24.
//

import UIKit

import RxCocoa
import RxSwift

class ShoppingTableViewCell: UITableViewCell {
    
    static let id = "ShoppingTableViewCell"
    
    let label = UILabel()
    let checkButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "checkbox"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    let starButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "star"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(data: Shopping) {
        let myData = BehaviorSubject(value: data)
        let checkButtonImage = data.isChecked ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "checkmark.square")
        let starButtonImage = data.isStar ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        myData.bind(with: self) { cell, data in
            cell.checkButton.setImage(checkButtonImage, for: .normal)
            cell.starButton.setImage(starButtonImage, for: .normal)
        }.disposed(by: disposeBag)
        label.rx.text.onNext(data.content)
    }
    
    func setUI() {
        contentView.addSubview(label)
        contentView.addSubview(checkButton)
        contentView.addSubview(starButton)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        starButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}

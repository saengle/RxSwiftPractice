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
        bt.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        bt.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        bt.tintColor = .black
        return bt
    }()
    
    let starButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "star"), for: .normal)
        bt.setImage(UIImage(systemName: "star.fill"), for: .selected)
        bt.tintColor = .black
        return bt
    }()
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(data: Shopping) {
        checkButton.isSelected = data.isChecked
        starButton.isSelected = data.isStar
        label.rx.text.onNext(data.content)
    }
    
    private func setUI() {
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

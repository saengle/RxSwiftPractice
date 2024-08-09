//
//  ShoppingCollectionViewCell.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/7/24.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

class ShoppingCollectionViewCell: UICollectionViewCell {
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: Shopping) {
        label.text = data.content
    }
}

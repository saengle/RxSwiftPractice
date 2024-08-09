//
//  MovieCollectionViewCell.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/8/24.
//

import UIKit

import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        label.textAlignment = .center
        label.textColor = .black
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

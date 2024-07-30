//
//  PickerViewVC.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//


import UIKit

import RxCocoa
import RxSwift
import SnapKit

class PickerViewVC: UIViewController {
    let pickerView = UIPickerView()
    let label = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        let items = Observable.just([ 
        "맛집탐방",
        "수영하기",
        "꿀잠자기",
        "영화보기"
        ])
        items.bind(to: pickerView.rx.itemTitles) {(row, element) in
        return element
        }
        .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self)
            .map{$0.description}
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(pickerView)
        view.addSubview(label)
        pickerView.backgroundColor = .blue
        label.backgroundColor = .lightGray
        pickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(300)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
    }
}

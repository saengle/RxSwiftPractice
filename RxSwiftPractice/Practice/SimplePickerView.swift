//
//  SimplePickerView.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxSwift
import RxCocoa

class SimplePickerView: UIViewController {
    
    
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        Observable.just([UIColor.lightGray, UIColor.cyan, UIColor.yellow])
            .bind(to: pickerView.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)

        pickerView.rx.modelSelected(UIColor.self)
            .subscribe(onNext: { models in
                print("models selected 3: \(models)")
            })
            .disposed(by: disposeBag)
        
        
    }
}

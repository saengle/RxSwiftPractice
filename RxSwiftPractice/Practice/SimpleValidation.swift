//
//  SimpleValidation.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//
import UIKit

import RxCocoa
import RxSwift

class SimpleValidation: UIViewController {
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    
    let result = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension SimpleValidation {
    private func setUI() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(result)
        number1.snp.makeConstraints { make in
            
        }
        number2.snp.makeConstraints { make in
            
        }
        number3.snp.makeConstraints { make in
            
        }
        result .snp.makeConstraints { make in
            
        }
    }
}

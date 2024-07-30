//
//  TextFieldButton.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class TextFieldButton: UIViewController {
    let signName = UITextField()
    let signEmail = UITextField()
    let button = UIButton()
    let label = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) {
            value1, value2 in
            return "name : \(value1),  email : \(value2)"
        }
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty // string
            .map{$0.count < 4}
            .bind(to: signEmail.rx.isHidden) // 아래거 있어도 이곳에 커서가 있을 때 4글자 이상을 충족하면 버튼이 보이는데 ???
        // button.rx.isHidden 없애면 될듯 ?
        // 없애는게 더 자연스럽넹 ㅇㅋ
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map{$0.count < 4}
            .bind(to: button.rx.isHidden)
            .disposed(by: disposeBag)
        
        button.rx.tap.map { _ in
            "폭풍의 시공에 오신것을 환영합니다 ~!"
        }.bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
    }
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(label)
        view.addSubview(signName)
        view.addSubview(signEmail)
        signName.backgroundColor = .lightGray
        signEmail.backgroundColor = .cyan
        button.backgroundColor = .blue
        label.backgroundColor = .lightGray
        
        signName.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide )
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
            make.height.equalTo(100)
        }
        signEmail.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        

        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(30)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
    }
}

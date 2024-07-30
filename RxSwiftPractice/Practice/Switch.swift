//
//  Switch.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class SwitchVC: UIViewController {
    let mySwitch = UISwitch()
    let label = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
       
        Observable
//            .of(false)  // 무슨 차이가 있능교... 저스트, 오브
            .just(false)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
    }
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(mySwitch)
        view.addSubview(label)
        mySwitch.backgroundColor = .blue
        label.backgroundColor = .lightGray
        mySwitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(300)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
    }
}

//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit

import RxCocoa
import RxSwift
import SnapKit

class PhoneViewController: UIViewController {
    let disposeBag = DisposeBag()
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    
    let descriptionLabel = UILabel()
    let startNumber = Observable.just("010")
    
    let validText = Observable.just("연락처는 10자이상의 숫자로만 이루어져야합니다.")
    
    let nextButton = PointButton(title: "다음")
    
    let vm = PhoneViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
    }
    
    func bind() {
        
        validText.bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        startNumber.bind(with: self) { owner, value in
            owner.phoneTextField.text = value
        }.disposed(by: disposeBag)
        
        let validation = phoneTextField.rx.text.orEmpty
            .map { $0.count >= 10 && Int($0) != nil }
        
        validation.bind(to: descriptionLabel.rx.isHidden, nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        validation.bind(with: self) { owner, value in
            let color: UIColor = value ? .systemPink : .lightGray
            owner.nextButton.backgroundColor = color
        }
        .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }.disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        view.addSubview(descriptionLabel)
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(phoneTextField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

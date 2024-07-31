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
    let nameTF = UITextField()
    let passwordTF = UITextField()

    let nameValidationLabel = UILabel()
    let passwordValidationLabel = UILabel()
    
    let button = UIButton()
    
    let disposeBag = DisposeBag()
    
    let minimalLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        nameValidationLabel.text = "유저의 이름은 최소 \(minimalLength)글자 이상이여야합니다."
        passwordValidationLabel.text = "유저의 이름은 최소 \(minimalLength)글자 이상이여야합니다."
        
        let usernameValid = nameTF.rx.text.orEmpty
            .map{ $0.count >= self.minimalLength }
            .share(replay: 1)
        
        let passwordValid = passwordTF.rx.text.orEmpty
            .map{ $0.count >= self.minimalLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1}
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTF.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)

        button.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
    }
}

extension SimpleValidation {
    func showAlert() {
        let alert = UIAlertController(
            title: "RxExample",
            message: "This is wonderful",
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(nameTF)
        view.addSubview(passwordTF)
        view.addSubview(nameValidationLabel)
        view.addSubview(passwordValidationLabel)
        view.addSubview(button)
        nameTF.backgroundColor = .lightGray
        passwordTF.backgroundColor = .lightGray
        nameValidationLabel.backgroundColor = .lightGray
        passwordValidationLabel.backgroundColor = .lightGray
        button.backgroundColor = .blue
        nameTF.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(200)
        }
        nameValidationLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTF).inset(70)
        }
        passwordTF.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameValidationLabel).inset(100)
        }
        passwordValidationLabel .snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF).inset(70)
        }
        button.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordValidationLabel).inset(100)
        }
    }
}

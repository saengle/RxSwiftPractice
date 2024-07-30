//
//  FirstPractice.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class FirstPracticeViewController: UIViewController {
    let button = UIButton()
    let label = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}
/*
 Observable: 이벤트를 방출하는 SomeThing ~
 Observer: Observable가 방출하는 이벤트(들)에 반응하는 친구.
 
 subscribe: 옵저버와 옵저버블을 연결하는 메서드.(구독)
            구독을 하고나면 옵저버블이 방출하는 이벤트를 옵저버가 받아서 지정한 행동이 가능함.
 
 bind : 1)subscribe와 같지만 서브스크라이브가 가진 온 넥스트, 온 에러, 온 컴플리트, 온 디스포즈 중에 에러, 컴플리트가 없음.
        -> 에러와 컴플리트가 발생하지 않는 무한한 이벤트를 방출하는 상황에서 사용
      2) '항상' Main Thread에서 동작하므로 UI객체를 사용할 때 주로 사용함.
 */
extension FirstPracticeViewController {
    private func firstPractice() {
        
        
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(label)
        button.backgroundColor = .blue
        label.backgroundColor = .lightGray
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
        label.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(100)
        }
    }
}

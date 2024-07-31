//
//  OperatorCombineLatest.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import UIKit

import RxSwift
/*
 combineLatest를 사용하면 모든 속성이 최소 한번 이상 방출되었을때부터 구독을 시작함.
 또 한번 프린트 할 때 각 속성별로 마지막으로 방출된 모든 것을 함께 방출해줌 !
 프린트 예시
 last a = 5, last b =  카레카레야, last c = 15
 last a = 5, last b =  완전좋아 ! , last c = 15
 last a = 5, last b =  완전좋아 ! , last c = 0
 */
class OperatorCombineLatest: UIViewController {
    
    let a = PublishSubject<Int>()
    let b = PublishSubject<String>()
    let c = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(a, b, c) {e, f, g in
        return "last a = \(e), last b =  \(f), last c = \(g)"
        }
        .subscribe(with: self) { owner, data in
        print(data)
        }
        .disposed(by: disposeBag)
        
        a.onNext(5)
        b.onNext("샨티샨티")
        b.onNext("카레카레야")
        c.onNext(15)
        b.onNext( "완전좋아 ! ")
        c.onNext(0)
    }
}

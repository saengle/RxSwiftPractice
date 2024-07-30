//
//  ObservableExample.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 7/31/24.
//

import RxCocoa
import RxSwift

import UIKit

class ObservableExample: UIViewController {

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        firstJust()
    }
}
extension ObservableExample {
    func firstJust() { // 엘리멘트 파라미터로 하나의 값을 받아 옵저버블을 리턴함. 즉 하나의 값만 방출.
        
        let itemsA = ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - \(error)")
            } onCompleted: {
                print("just - Completed")
            } onDisposed: {
                print("just - Disposed")
            }
            .disposed(by: disposeBag)
        /*
         just - ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
         just - Completed
         just - Disposed
         */
    }
}

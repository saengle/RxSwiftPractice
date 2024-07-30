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
        secondOf()
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
    
    func secondOf() { // element parameter가 가변 파라미터로 선언되어있어서 여러 가지 값을 동시에 전달 할 수 있음.
        let itemsA = ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
        let itemsB = ["순살로 한 감자탕", "빠가사리매운탕", "매운 떡볶이"]
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - \(error)")
            } onCompleted: {
                print("of - Completed")
            } onDisposed: {
                print("of - Disposed")
            }
            .disposed(by: disposeBag)
/*
 of - ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
 of - ["순살로 한 감자탕", "빠가사리매운탕", "매운 떡볶이"]
 of - Completed
 of - Disposed
 */
    }
    func thirdFrom() { // 배열을 파라미터로 받고 각 엘리먼트를 옵저버블로 리턴함.
        let itemsA = ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - \(error)")
            } onCompleted: {
                print("from - Completed")
            } onDisposed: {
                print("from - Disposed")
            }
            .disposed(by: disposeBag)
        /*
         from - 영화보기
         from - 꿀잠자기
         from - 수영하기
         from - 시공조아
         from - Completed
         from - Disposed
         */
    }
         take - ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
         take - ["영화보기", "꿀잠자기", "수영하기", "시공조아"]
         take - Completed
         take - Disposed
         */
    }
}

//
//  ShoppingViewModel.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/5/24.
//

import UIKit

import RxCocoa
import RxSwift

class ShoppingViewModel {
    
    let disposeBag = DisposeBag()
    
    var tableItems = [
        Shopping(isChecked: true, isStar: false, content: "아이폰사기"),
        Shopping(isChecked: false, isStar: true, content: "콩나물 사가기"),
        Shopping(isChecked: false, isStar: true, content: "통 앞다리살 두근")
    ]
    
    private lazy var myTableItems = BehaviorSubject(value: tableItems)
    
    var collectionItems: [Shopping] = [
    Shopping(isChecked: false, isStar: false, content: "IT"),
    Shopping(isChecked: false, isStar: false, content: "음식"),
    Shopping(isChecked: false, isStar: false, content: "가구"),
    Shopping(isChecked: false, isStar: false, content: "밀키트"),
    Shopping(isChecked: false, isStar: false, content: "음료"),
    Shopping(isChecked: false, isStar: false, content: "Apple"),
    ]
    
    private lazy var myCollectionItems = BehaviorSubject(value: collectionItems)
    
    struct Input {
        let starButtonTap: PublishSubject<Int>
                let checkButtonTap: PublishSubject<Int>
                let shoppings: PublishSubject<Shopping>
    }
    
    struct Output {
        //        let addTapCell: ControlEvent<Void>
        let tableShoppings: BehaviorSubject<[Shopping]>
        let collectionShoppings: BehaviorSubject<[Shopping]>
    }
    
    func transform(input: Input) -> Output {
        
        input.shoppings.subscribe(with: self) { owner, value in
            owner.tableItems.append(value)
            owner.myTableItems.onNext(owner.tableItems)
        }.disposed(by: disposeBag)
        
        input.checkButtonTap.subscribe(with: self) { owner, value in
            owner.tableItems[value].isChecked.toggle()
            owner.myTableItems.onNext(owner.tableItems)
        }.disposed(by: disposeBag)
        
        input.starButtonTap.subscribe(with: self) { owner, value in
            owner.tableItems[value].isStar.toggle()
            owner.myTableItems.onNext(owner.tableItems)
        }.disposed(by: disposeBag)
        
        return Output( tableShoppings: myTableItems, collectionShoppings: myCollectionItems)
    }
}

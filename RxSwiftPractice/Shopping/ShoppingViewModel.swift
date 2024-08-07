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
    Shopping(isChecked: false, isStar: false, content: "목업데이터")
    ]
    
    private lazy var myCollectionItems = BehaviorSubject(value: collectionItems)
    
    struct Input {
        //        let addTapCell: ControlEvent<Void>
//                let tapCheck: ()
//                let tapStar: ControlEvent<Void>
        //        let row: ControlProperty<Int>
        //        let shoppings: PublishSubject<[Shopping]>
    }
    
    struct Output {
        //        let addTapCell: ControlEvent<Void>
        let tableShoppings: BehaviorSubject<[Shopping]>
        let collectionShoppings: BehaviorSubject<[Shopping]>
    }
    
    func transform(input: Input) -> Output {
        
        
        //        input.addTapCheck
        //            .bind(with: self) { owner, _ in
        ////                items[]
        //            }
        
        return Output( tableShoppings: myTableItems, collectionShoppings: myCollectionItems)
    }
}

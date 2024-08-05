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
    
    var items = BehaviorRelay(value: [
        Shopping(isChecked: true, isStar: false, content: "아이폰사기"),
        Shopping(isChecked: false, isStar: true, content: "콩나물 사가기"),
        Shopping(isChecked: false, isStar: true, content: "통 앞다리살 두근")])
    
    struct Input {
        let addTapCell: ControlEvent<Void>
        let addTapCheck: ControlEvent<Void>
        let addTapStar: ControlEvent<Void>
        let row: ControlProperty<Int>
        let shoppings: BehaviorRelay<[Shopping]>
    }
    struct Output {
        let addTapCell: ControlEvent<Void>
        let shoppings: BehaviorRelay<[Shopping]>
    }
    func transform(input: Input) -> Output {
        
        input.addTapCheck
            .bind(with: self) { owner, _ in
//                items[]
            }
        
        return Output(addTapCell: input.addTapCell, shoppings: items)
    }
}

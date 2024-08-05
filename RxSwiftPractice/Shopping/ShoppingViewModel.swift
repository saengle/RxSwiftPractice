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
    
    let items = Observable.just([
    "아이패드",
    "아이폰",
    "아이폰플립"
    ])
    
    struct Input {
//        let item = 
        let addTap: ControlEvent<Void>
    }
    struct Output {
        let addTap: ControlEvent<Void>
    }
//    func transform(input: Input) -> Output {
//        
//        return
//    }
}

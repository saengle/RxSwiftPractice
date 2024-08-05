//
//  BirthdayViewModel.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/6/24.
//

import Foundation

import RxSwift
import RxCocoa


class BirthdayViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input { // birthdayDatePicketr.rx.date
        let birthday: ControlProperty<Date>
    }
    
    struct Output {
        let year: BehaviorRelay<Int>
        let month: BehaviorRelay<Int>
        let day: BehaviorRelay<Int>
        let validationResult: BehaviorRelay<Bool>
    }
    
    func valitaion(date: Date) -> Bool {
        let today = Date()
        let bDay = date
        
        let diff = bDay.timeIntervalSinceNow / 86400
        let res = (-diff >= 365 * 18)
        return res
    }
    
    func transform(input: Input) -> Output {
        let year = BehaviorRelay(value: 2024)
        let month = BehaviorRelay(value: 8)
        let day = BehaviorRelay(value: 5)
        let validationResult = BehaviorRelay(value: false)
        
        input.birthday
            .bind(with: self) { owner, date in
                let component = Calendar.current.dateComponents([.day, .month, .year], from: date)
                year.accept(component.year!)
                month.accept(component.month!)
                day.accept(component.day!)
                validationResult.accept( owner.valitaion(date: date))
            }
            .disposed(by: disposeBag)
        
        return Output(year: year, month: month, day: day, validationResult: validationResult)
    }
}

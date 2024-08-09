//
//  MovieViewModel.swift
//  RxSwiftPractice
//
//  Created by 쌩 on 8/8/24.
//

import Foundation

import RxCocoa
import RxSwift

class MovieViewModel {
    
    let disposeBag = DisposeBag()
    
    var movieList: [DailyBoxOfficeList] = []
    
    
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let query: ControlProperty<String>
    }
    struct Output {
        let movieList: Observable<[DailyBoxOfficeList]>
    }
    
    func transform(input: Input) -> Output {
        let boxOfficeList = PublishSubject<[DailyBoxOfficeList]>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(input.query)
            .distinctUntilChanged()
            .map {
                guard let intQuery = Int($0) else {
                    return 20240805 }
                return intQuery
            }
            .map { return "\($0)" }
            .flatMap{ NetworkManager.shared.callBoxOffice(query: $0)}
            .subscribe(with: self, onNext: { owner, movie in
                owner.movieList = movie.boxOfficeResult.dailyBoxOfficeList
                
                boxOfficeList.onNext(owner.movieList)
            }, onError: { owner, error in
                print("error: ", error)
            }, onCompleted: { owner in
                print("completed")
            }, onDisposed: { owner in
                print("disposed")
            })
            .disposed(by: disposeBag)
        
        return Output(movieList: boxOfficeList)
    }
}

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
        firstPractice()
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
        // 1.
//        button.rx.tap.subscribe { _ in
//            self.label.text = "버튼을 클릭했다 오바"
//        } onError: { error in
//            print("error")
//        } onCompleted: {
//            print("completed")
//        } onDisposed: {
//            print("disposed")
//        }
//        .disposed(by: disposeBag)
        // 2. 1에서 필요 없는것 일부 삭제 .
        // 인피니트 옵저버 시퀀스 이므로 에러, 컴플리트가 없음.
//        button.rx.tap.subscribe { _ in
//            self.label.text = "버튼 이즈 클릭드"
//        } onDisposed: {
//            print("disposed")
//        }
//        .disposed(by: disposeBag)
//        
        // 3. leak 대응. (RX와 연관은 없지만 ,, 아무튼 누수 방지. 스위프트 방식으로)
//        button.rx.tap.subscribe { [weak self] _ in
//            self?.label.text = "훌랄라숯불바베큐치킨먹고싶다아아아"
//        } onDisposed: {
//            print("Disposed")
//        }
//        .disposed(by: disposeBag)
        //4.
//        button.rx.tap
//            .withUnretained(self) // weak self 매번 쓰기 귀찮으니 기능으로 구현해줌.
//            .subscribe { _ in
//                self.label.text = "버튼이 클릭되었다구우우웅"
//            } onDisposed: {
//                print("Disposed")
//            }
//            .disposed(by: disposeBag)
//        //5.  subscribe 자체에 weak self 기능을 가져옴
//        button.rx.tap
//            .subscribe(with: self) { owner, _ in // owner 가 클로저안에서는 self를 대신하니 오우너로 사용!!
//                owner.label.text = "뭐라고 써도 관계 없지만 보통 owner 괜찮은듯 ??"
//            } onDisposed: { owner in
//                print("Disposed")
//            }
//            .disposed(by: disposeBag)
//        //6. uikit에서만 사용 가능.
//        // 섭스크라이브는 스레드가 보장이 되지 않음 ! -> 백그라운드에서도 동작 됨 어떤 스레드든 관계 없이.
//        // & 보라색 에서 발생 가능 ! -> 디스패치큐 메인 사용해야함.
//        button.rx.tap.subscribe(with: self) { owner, _ in
//            DispatchQueue.main.async{
//                owner.label.text = "요 위 오우너는 왜 쓸때마다 다른 추천어가 떠서 탭 누르면 자꾸 다른거로 변경되는거야 ... 맘에 안들어 고쳐줘요 알엑스"
//            }
//        } onDisposed: { owner in
//            print("뭐야 요기는 멀쩡하잖아 저 위만 저러네 ??? Disposed ! ")
//        }
//        .disposed(by: disposeBag)
//        //7. DispatchQueue 자꾸 쓰기 귀찮을테니 기능으로 넣어줄게 !
//        // 짜쟌 스레드 고정하는 방법이야 !
//        button.rx.tap
//            .observe(on: MainScheduler.instance) // 앞으로 진행하는 코드는 메인스레드로 진행해줄게 !
//            .subscribe(with: self) { owner, _ in
//                owner.label.text = "뭔가 다시 길어졌어 ..."
//            } onDisposed: { owner in
//                print("disPoseddddd")
//            }
//            .disposed(by: disposeBag) // 이거도 자꾸 쓰다보니 아주 귀찮아지는군
        //
            // 8. subscribe 자체를 메인스레드에서 동작시켜주자 ~ 저것도 쓰다보니 귀찮아 !(위 기능 전부 포함)
        // + 버튼은 error가 애초에 없는데 안받는 친구는 없어 ???   => UI
//        button.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.label.text = "bind 님 두둥 등장 UI관련된 귀찮은것들 다 줄여주지 후하하하하"
//            }
//            .disposed(by: disposeBag)
        // 9.
        button.rx.tap
            .map{"버튼을 클릭했어요를레이히"} // observable<String>
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
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

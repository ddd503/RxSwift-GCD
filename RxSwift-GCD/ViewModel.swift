//
//  ViewModel.swift
//  RxSwift-GCD
//
//  Created by kawaharadai on 2019/12/21.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func injection(input: Input) -> Output
}

final class ViewModel: ViewModelType {

    struct Input {
        let mainTap: Observable<()>
    }

    struct Output {
        let finishedLongAction: Driver<()>
    }

    let main = MainScheduler.instance
    let mainAsync = MainScheduler.asyncInstance
    let concurrentMain = ConcurrentMainScheduler.instance
    let concurrentDispatchDefault = ConcurrentDispatchQueueScheduler(qos: .default)
    let concurrentDispatchBack = ConcurrentDispatchQueueScheduler(qos: .background)

    func injection(input: Input) -> Output {
        let finishedLongAction = input.mainTap
            .observeOn(main)
            .flatMap { (_) -> Observable<()> in
                return self.longAction()
                    .catchErrorJustReturn(())

        }
        .asDriver(onErrorDriveWith: Driver.never())

        return Output(finishedLongAction: finishedLongAction)
    }

    // 時間のかかる処理のダミー
    func longAction() -> Observable<()> {
        print("\(Thread.isMainThread)")
        return Observable.just(())
    }
}

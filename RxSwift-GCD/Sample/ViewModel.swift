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
        let tapMain: Observable<()>
        let tapMainAsync: Observable<()>
        let tapConcurrentMain: Observable<()>
        let tapCurrent: Observable<()>
        let tapConcurrentDispatch: Observable<()>
    }

    struct Output {
        let didEndLongActionAtMain: Driver<(sampleCode: String, description: String)>
        let didEndLongActionAtMainAsync: Driver<(sampleCode: String, description: String)>
        let didEndLongActionAtConcurrentMain: Driver<(sampleCode: String, description: String)>
        let didEndLongActionAtCurrent: Driver<(sampleCode: String, description: String)>
        let didEndLongActionAtConcurrentDispatch: Driver<(sampleCode: String, description: String)>
    }

    func injection(input: Input) -> Output {
        let didEndLongActionAtMain =
            input.tapMain
                .observeOn(MainScheduler.instance)
                .flatMap({ (_) -> Observable<(sampleCode: String, description: String)> in
                    return self.longAction(scheduler: MainScheduler.instance)
                        .catchErrorJustReturn(("", ""))
                })
                .asDriver(onErrorJustReturn: ("", ""))

        let didEndLongActionAtMainAsync =
            input.tapMainAsync
                .observeOn(MainScheduler.asyncInstance)
                .flatMap({ (_) -> Observable<(sampleCode: String, description: String)> in
                    return self.longAction(scheduler: MainScheduler.asyncInstance)
                        .catchErrorJustReturn(("", ""))
                })
                .asDriver(onErrorJustReturn: ("", ""))

        let didEndLongActionAtConcurrentMain =
            input.tapConcurrentMain
                .observeOn(ConcurrentMainScheduler.instance)
                .flatMap({ (_) -> Observable<(sampleCode: String, description: String)> in
                    return self.longAction(scheduler: ConcurrentMainScheduler.instance)
                        .catchErrorJustReturn(("", ""))
                })
                .asDriver(onErrorJustReturn: ("", ""))

        let didEndLongActionAtCurrent =
            input.tapCurrent
                .observeOn(CurrentThreadScheduler.instance)
                .flatMap({ (_) -> Observable<(sampleCode: String, description: String)> in
                    return self.longAction(scheduler: CurrentThreadScheduler.instance)
                        .catchErrorJustReturn(("", ""))
                })
                .asDriver(onErrorJustReturn: ("", ""))

        let didEndLongActionAtConcurrentDispatch =
            input.tapConcurrentDispatch
                .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .flatMap({ (_) -> Observable<(sampleCode: String, description: String)> in
                    return self.longAction(scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
                        .catchErrorJustReturn(("", ""))
                })
                .asDriver(onErrorJustReturn: ("", ""))

        return Output(didEndLongActionAtMain: didEndLongActionAtMain,
                      didEndLongActionAtMainAsync: didEndLongActionAtMainAsync,
                      didEndLongActionAtConcurrentMain: didEndLongActionAtConcurrentMain,
                      didEndLongActionAtCurrent: didEndLongActionAtCurrent,
                      didEndLongActionAtConcurrentDispatch: didEndLongActionAtConcurrentDispatch)
    }

    // 時間のかかる処理のダミー
    func longAction(scheduler: ImmediateSchedulerType) -> Observable<(sampleCode: String, description: String)> {
        print("メインスレッドかどうか：\(Thread.isMainThread)")
        let threadType = WorkingThreadType(scheduler: scheduler)!
        return Observable.just((sampleCode: threadType.sampleCade,
                                description: threadType.description))
    }
}

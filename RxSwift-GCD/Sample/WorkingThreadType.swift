//
//  WorkingThreadType.swift
//  RxSwift-GCD
//
//  Created by kawaharadai on 2019/12/28.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum WorkingThreadType {
    case main
    case mainAsync
    case concurrentMain
    case current
    case concurrentDispatch

    // ImmediateSchedulerTypeスレッド系の基盤プロトコル
    init?(scheduler: ImmediateSchedulerType) {
        switch scheduler {
        case is MainScheduler:
            self = .main
        case is SerialDispatchQueueScheduler:
            self = .mainAsync
        case is ConcurrentMainScheduler:
            self = .concurrentMain
        case is CurrentThreadScheduler:
            self = .current
        case is ConcurrentDispatchQueueScheduler:
            self = .concurrentDispatch
        default: return nil
        }
    }

    var sampleCade: String {
        switch self {
        case .main:
            return "MainScheduler.instance"
        case .mainAsync:
            return "MainScheduler.asyncInstance"
        case .concurrentMain:
            return "ConcurrentMainScheduler.instance"
        case .current:
            return "CurrentThreadScheduler.instance"
        case .concurrentDispatch:
            return "ConcurrentDispatchQueueScheduler(qos: .background)"
        }
    }

    var description: String {
        switch self {
        case .main:
            return "メインスレッドを保証\nキューイングされているものがない場合、即時実行、observeOnに最適化"
        case .mainAsync:
            return "メインスレッドを保証\n必ずDispatchQueue.mainでディスパッチ"
        case .concurrentMain:
            return "メインスレッドを保証\nキューイングされているものがない場合、即時実行、subscribeOnに最適化"
        case .current:
            return "実行スレッドを切り替えずに現在のスレッドで処理をキューイング(溜めて)して順次実行する"
        case .concurrentDispatch:
            return "処理をバックグラウンドで並列実行する\n動作スレッドをqosやqueueで指定することが可能"
        }
    }
}

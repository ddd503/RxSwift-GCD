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

enum WorkingThreadType: Int, CaseIterable {
    case main
    case mainAsync
    case concurrentMain
    case current
    case concurrentDispatch

    var title: String {
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
            return "メインスレッドを保証（キューイングされているものがない場合、即時実行、observeOnに最適化）"
        case .mainAsync:
            return "メインスレッドを保証（必ずDispatchQueue.mainでディスパッチ）"
        case .concurrentMain:
            return "メインスレッドを保証（キューイングされているものがない場合、即時実行、subscribeOnに最適化のため今回は不使用）"
        case .current:
            return "実行スレッドを切り替えずに現在のスレッドで処理をキューイング(溜めて)して順次実行する"
        case .concurrentDispatch:
            return "処理をバックグラウンドで並列実行する（動作スレッドをqosやqueueで指定することが可能）"
        }
    }

    // ImmediateSchedulerTypeスレッド系の基盤プロトコル
    var thread: ImmediateSchedulerType {
        switch self {
        case .main:
            // メインスレッドを保証（キューイングされているものがない場合、即時実行、observeOnに最適化）
            return MainScheduler.instance
        case .mainAsync:
            // メインスレッドを保証（必ずDispatchQueue.mainでディスパッチ）
            return MainScheduler.asyncInstance
        case .concurrentMain:
            // メインスレッドを保証（キューイングされているものがない場合、即時実行、subscribeOnに最適化のため今回は不使用）
            return ConcurrentMainScheduler.instance
        case .current:
            // 実行スレッドを切り替えずに現在のスレッドで処理をキューイング(ためて)して順次実行する（割り込みの即時実行のImmediateSchedulerは廃止？？）
            return CurrentThreadScheduler.instance
        case .concurrentDispatch:
            // 処理をバックグラウンドで並列実行する（動作スレッドをqosやqueueで指定することが可能）
            return ConcurrentDispatchQueueScheduler(qos: .background)
        }
    }
}

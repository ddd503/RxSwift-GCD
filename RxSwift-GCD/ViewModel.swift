//
//  ViewModel.swift
//  RxSwift-GCD
//
//  Created by kawaharadai on 2019/12/21.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func injection(input: Input) -> Output
}

final class ViewModel: ViewModelType {

    struct Input {

    }

    struct Output {

    }

    func injection(input: Input) -> Output {
        return Output()
    }

}

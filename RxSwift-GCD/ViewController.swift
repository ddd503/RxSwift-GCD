//
//  ViewController.swift
//  RxSwift-GCD
//
//  Created by kawaharadai on 2019/12/18.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak private var mainButton: UIButton!
    @IBOutlet weak private var mainAsyncButton: UIButton!
    @IBOutlet weak private var concurrentMainButton: UIButton!
    @IBOutlet weak private var currentButton: UIButton!
    @IBOutlet weak private var concurrentDispatchButton: UIButton!

    @IBOutlet weak private var sampleCodeLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ViewModel()
            .injection(input: ViewModel.Input(tapMain: mainButton.rx.tap.asObservable(),
                                              tapMainAsync: mainAsyncButton.rx.tap.asObservable(),
                                              tapConcurrentMain: concurrentMainButton.rx.tap.asObservable(),
                                              tapCurrent: currentButton.rx.tap.asObservable(),
                                              tapConcurrentDispatch: concurrentDispatchButton.rx.tap.asObservable()))

        viewModel.didEndLongActionAtMain
            .drive(onNext: { [weak self] (sampleCode, description) in
                self?.update(sampleCode: sampleCode, description: description)
            })
            .disposed(by: disposeBag)

        viewModel.didEndLongActionAtMainAsync
        .drive(onNext: { [weak self] (sampleCode, description) in
            self?.update(sampleCode: sampleCode, description: description)
        })
        .disposed(by: disposeBag)

        viewModel.didEndLongActionAtConcurrentMain
        .drive(onNext: { [weak self] (sampleCode, description) in
            self?.update(sampleCode: sampleCode, description: description)
        })
        .disposed(by: disposeBag)

        viewModel.didEndLongActionAtCurrent
        .drive(onNext: { [weak self] (sampleCode, description) in
            self?.update(sampleCode: sampleCode, description: description)
        })
        .disposed(by: disposeBag)

        viewModel.didEndLongActionAtConcurrentDispatch
        .drive(onNext: { [weak self] (sampleCode, description) in
            self?.update(sampleCode: sampleCode, description: description)
        })
        .disposed(by: disposeBag)
    }

    func update(sampleCode: String, description: String) {
        sampleCodeLabel.text = sampleCode
        descriptionLabel.text = description
    }

}


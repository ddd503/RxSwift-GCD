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

    @IBOutlet weak private var button: UIButton!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = ViewModel().injection(input: ViewModel.Input(mainTap: button.rx.tap.asObservable()))

        viewModel.finishedLongAction.drive(onNext: { _ in
            print("did tap")
        })
            .disposed(by: disposeBag)
    }

}


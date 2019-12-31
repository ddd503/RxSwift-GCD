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

    @IBOutlet weak private var sampleCadeLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}


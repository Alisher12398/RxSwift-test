//
//  ViewController.swift
//  RxSwift-test1
//
//  Created by Алишер Халыкбаев on 02/06/2019.
//  Copyright © 2019 Алишер Халыкбаев. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bag = DisposeBag()
        
        //1
        let helloSequence = Observable.from(["H","e","l","l","o"])
        let subscription = helloSequence.subscribe { event in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
        subscription.disposed(by: bag)
        
        //2
        let observable2 = Observable.just("Hello Rx!")
        // Creating a subscription just for next events
        let subscription2 = observable2.subscribe (onNext:{
            print($0)
        })
        subscription2.disposed(by: bag)
        
        //3
        let publishSubject = PublishSubject<Any>()
        _ = publishSubject.subscribe(onNext:{
            print($0)
        }).disposed(by: bag)
        // Subscription1 receives these 2 events, Subscription2 won't
        publishSubject.onNext("Hello")
        publishSubject.onNext("Again")
        // Sub2 will not get "Hello" and "Again" because it susbcribed later
        _ = publishSubject.subscribe(onNext:{
            print(#line,$0)
        })
        publishSubject.onNext("Both Subscriptions receive this message")
    }
}


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
        
        //1 Switch
        print("Example 1:")
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
        print("\n")
        
        //2 Map
        print("Example 2:")
        var array = [1,2,3,4]
        let helloSequence2 = Observable.from(array).map { value in
            return value * 10
        }
        let sub2 = helloSequence2.subscribe{ event in
            switch event {
            case .next(let value):
                print("Added new element: \(value)")
            case .error(let error):
                print(error)
            case .completed:
                print("completed array")
            }
        }
        array.append(5)
        array.append(6)
        array.append(7)
        sub2.disposed(by: bag)
        print("\n")
        
        //3 subscribe onNext
        print("Example 3:")
        let observable2 = Observable.just("Hello Rx!")
        let subscription2 = observable2.subscribe (onNext:{
            print($0)
        })
        subscription2.disposed(by: bag)
        print("\n")
        
        //4 Publish Subject, append elements to Subject
        print("Example 4:")
        let publishSubject = PublishSubject<Any>()
        
        _ = publishSubject.subscribe(onNext:{
            print($0)
        }).disposed(by: bag)
        
        publishSubject.onNext("Hello")
        publishSubject.onNext("Again")
        
        _ = publishSubject.subscribe(onNext:{
            print(#line,$0)
        })
        
        publishSubject.onNext("Both Subscriptions receive this message")
        print("\n")
        
        //5 FlatMap
        print("Example 5:")
        let sequence1  = Observable.of(1,2)
        let sequence2  = Observable.of(3,4)
        let sequenceOfSequences = Observable.of(sequence2,sequence1)
        sequenceOfSequences.flatMap{ return $0 }.subscribe(onNext:{
            print($0)
        })
        print("\n")
        
        //6 Filter
        print("Example 6:")
//        let publishSubject2 = PublishSubject<Int>()
//
//        _ = publishSubject2.subscribe(onNext:{
//            print($0)
//        }).disposed(by: bag)
//        publishSubject2.onNext(1)
//        publishSubject2.onNext(2)
//        publishSubject2.onNext(6)
//        publishSubject2.onNext(3)
//        publishSubject2.onNext(10)
//        print("\n")
        
        let dataSource = Observable.just([1, 2, 3, 4, 5])
        let filterSource = PublishSubject<Int>()

        Observable
            .combineLatest(dataSource, filterSource) { data, filter in data.filter { $0 > 3 } }
            .subscribe(onNext: { print($0) })

        filterSource.onNext(10)
        filterSource.onNext(2)

        print("Done")
    }
}


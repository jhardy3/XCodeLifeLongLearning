//
//  ViewController.swift
//  SynchronizationTest
//
//  Created by Jake Hardy on 4/19/16.
//  Copyright © 2016 NSDesert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foo()
        synchronize(numberArray) {
            self.fetchImageJustCause({ 
                print(self.numberArray.count)
            })
            print(self.numberArray.count)
        }
        numberArray = []
        print(numberArray.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func foo() {
        var sum = 0
        var pendingElements = 10
        
        for i in 0 ..< 10 {
            processElementAsync(i) { value in
                
                self.synchronize(pendingElements) {
                    sum += value
                    pendingElements--
                
                    if pendingElements == 0 {
                        print(sum)
                    }
                }
                
            }
        }
    }
    
    func synchronize(lockObj: AnyObject!, closure: ()->()){
        objc_sync_enter(lockObj)
        closure()
        objc_sync_exit(lockObj)
    }
    
    func processElementAsync(i: Int, completion: (value: Int) -> Void) {
        fetchImageJustCause { 
            completion(value: i)
        }
    }
    
    func fetchImageJustCause(completion: () -> Void) {
        NetworkController.fetchImageAtURL(imageURL) { (image) in
            guard let image = image else { return }
            completion()
        }
    }
    
}

class QueueTest {
    private let queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT)
    
    private var _myProperty = [Int]()
    
    internal var myProperty: [Int] {
        get {
            var result = [Int]()
            dispatch_sync(queue) {
                result = self._myProperty
            }
            return result
        }
        set {
            dispatch_barrier_async(queue) {
                    self._myProperty = newValue
                    print(newValue)
            }
        }
    }
    
    
    
    
}


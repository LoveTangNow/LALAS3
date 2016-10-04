//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let a  = str.startIndex
let b  = str.endIndex

str[a]
let d = str[str.index(before: str.endIndex)]
let c = str.characters.last




/*
//1.创建NSBlockOperation对象
let operation = BlockOperation { () -> Void in
    //NSLog("%@", Thread.current)
}

//2.添加多个Block
for i in 0..<5 {
    operation.addExecutionBlock { () -> Void in
        sleep(10)
        NSLog("第%ld次 -- %@", i, Thread.current)
    }
}

operation.addExecutionBlock { () -> Void in
    NSLog("第%ld次 -- %@",9, Thread.current)
}



//2.开始任务
operation.start()
 */

/**
//1.创建其他队列
let queue = OperationQueue()

//2.创建NSBlockOperation对象
let operation = BlockOperation { () -> Void in
    NSLog("%@", Thread.current)
}

//3.添加多个Block
for i in 0..<5 {
    operation.addExecutionBlock { () -> Void in
        NSLog("第%ld次 - %@", i, Thread.current)
    }
}

//4.队列添加任务
queue.addOperation(operation)
*/




import UIKit
import XCTest


//private var range1 = 153...171
//private var range2 = 168...175
//
//var interceptingRange: ClosedRange<Int> {
//    let start = max(range1.lowerBound, range2.lowerBound)
//    let end = min(range1.upperBound, range2.upperBound)
//
//    if start <= end {
//        return start...end
//    } else {
//        // There is no intersection
//        return start...start
//    }
//}
//
//print("interceptive range: \(interceptingRange)")


// for res 10 to 20 italic and 12 to 15 bold
// 12 to 15 — d
// 5 to 12 - d
// 18 to 23 - d
// 9 to 24 - d
// 2 to 10 — nope bold - italic
// 20 to 21 - nope bold - italic

//func getInterceptiveRange(range1: ClosedRange<Int>, range2: ClosedRange<Int>) {
//    let start = max(range1.lowerBound, range2.lowerBound)
//    let end = min(range1.upperBound, range2.upperBound)
//
//    let rng: ClosedRange<Int>
//    if start <= end {
//        rng = start...end
//        print("interceptive range: \(rng)")
//    }
//}

//getInterceptiveRange(range1: 153...171, range2: 168...175)
//getInterceptiveRange(range1: 168...171, range2: 153...175)
//getInterceptiveRange(range1: 168...175, range2: 153...171)
//getInterceptiveRange(range1: 153...168, range2: 168...175)

//getInterceptiveRange(range1: 10...20, range2: 12...15)
//getInterceptiveRange(range1: 10...20, range2: 5...12)
//getInterceptiveRange(range1: 10...20, range2: 18...23)
//getInterceptiveRange(range1: 10...20, range2: 9...24)
//getInterceptiveRange(range1: 10...20, range2: 2...10)
//getInterceptiveRange(range1: 10...20, range2: 20...21)

//getInterceptiveRange(range1: 12...15, range2: 10...20)
//getInterceptiveRange(range1: 5...12, range2: 10...20)
//getInterceptiveRange(range1: 18...23, range2: 10...20)
//getInterceptiveRange(range1: 9...24, range2: 10...20)
//getInterceptiveRange(range1: 2...10, range2: 10...20)
//getInterceptiveRange(range1: 20...21, range2: 10...20)




//final class BrowserStackDemoUITests: XCTestCase {
//
//
//override func setUpWithError() throws {
//continueAfterFailure = false
//}
//
//
//override func tearDownWithError() throws {
//// Put teardown code here. This method is called after the invocation of each test method in the class.
//}
//
//
//    func testValue(){
//        XCTAssertEqual("dsf", "df")
//    }
//
//}
//BrowserStackDemoUITests().testValue()


// RunLoop in Swift
func setupRunLoop() {
    let thread = Thread {
        autoreleasepool {
            let runLoop = RunLoop.current
            runLoop.add(NSMachPort(), forMode: .default)
            runLoop.run()
        }
    }
    thread.start()
}


import Foundation

// Define a Sendable struct
struct MyData: Sendable {
    var name: String
}

// Define a class that is not inherently safe for concurrent access
class NonSendableClass {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func increment() {
        value += 1
    }
}

// Mark NonSendableClass as @unchecked Sendable
extension NonSendableClass: @unchecked Sendable {}

// A function that performs an asynchronous task
func performTask(data: MyData, nonSendable: NonSendableClass) async {
    // Simulate a delay
    await Task.sleep(1_000_000_000) // Sleep for 1 second

    // Safely access Sendable data
    print("Data name: \(data.name)")
    
    // Accessing NonSendableClass (with caution)
    nonSendable.increment()
    print("NonSendableClass value: \(nonSendable.value)")
}

// Main code
let data = MyData(name: "Hello")
let nonSendableInstance = NonSendableClass(value: 10)

// Create a Task to perform the operation
Task {
    await performTask(data: data, nonSendable: nonSendableInstance)
}

// Keep the program running to see the async output
RunLoop.current.run()


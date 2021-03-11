import UIKit

func wait(delay: UInt32, completion: () -> Void) {
    sleep(delay)
    completion()
}

wait(delay: 2,completion: {
    print ("Finished Waiting for 2 seconds, outside any group")
})

// effectively this happens after 3 seconds
wait(delay: 1) {
    print("1 second delay finished, outside any group")
}

// As this stands, the dispatch group will only begin running after an intial wait of 3 seconds. This is as we are running on the same thread / queue.
let waitingGroup = DispatchGroup()

waitingGroup.enter()
wait(delay: 1) {
    print("1 second delay finished inside the waitingGroup")
    waitingGroup.leave()
}

waitingGroup.enter()
wait(delay: 2) {
    print("1 second delay finished inside the waitingGroup")
    waitingGroup.leave()
}

waitingGroup.notify(queue: .main) {
    print("done")
}


let testGroup = DispatchGroup()

DispatchQueue.global(qos: .userInteractive).async {
    testGroup.enter()
}

DispatchQueue.global(qos: .background).async {
    testGroup.leave()
}

testGroup.notify(queue: .main) {
    print("done")
}

import UIKit

func printAnArray<T>(arr:[T]) {
    print ("Your Array is:")
    arr.forEach({ element in
        print (element)
    })
}

printAnArray(arr: [1,2,3])


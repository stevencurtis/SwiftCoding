
import Foundation

func print(address o: UnsafeRawPointer ) {
    print(String(format: "%p", Int(bitPattern: o)))
}

var array1: [Int] = [0, 1, 2, 3]
var array2 = array1

//Print with just assign
print(address: array1) //0x600000078de0
print(address: array2) //0x600000078de0
//Let's mutate array2 to see what's
array2.append(4)

print(address: array2) //0x6000000aa100

//Output
//0x600000078de0 array1 address
//0x600000078de0 array2 address before mutation
//0x6000000aa100 array2 address after mutation

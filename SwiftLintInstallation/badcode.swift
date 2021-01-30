let foo: NSArray = NSArray(array: [5, 6, 7])
let bar = foo as? [Int]
print(bar?.reduce(0, +))

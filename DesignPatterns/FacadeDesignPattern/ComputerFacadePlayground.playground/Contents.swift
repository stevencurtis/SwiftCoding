import UIKit

private class CPU {
    func freeze() { }
    func jump(position: Int64) { }
    func execute() { }
}

private class Memory {
    func load(position: Int64, data: NSData) { }
}

private class Drive {
    func read(position: Int64, data: NSData) -> NSData? { return nil }
}

class Computer {
    private let BOOT_ADDRESS: Int64 = 95
    private let cpu = CPU()
    private let memory = Memory()
    private let hdd = Drive()
    func start() {
        self.cpu.freeze()
        self.memory.load(position: BOOT_ADDRESS, data: NSData())
        self.cpu.jump(position: BOOT_ADDRESS)
        self.cpu.execute()
    }
}

let computer = Computer()
computer.start()

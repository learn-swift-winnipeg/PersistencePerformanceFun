import Foundation

extension DispatchTime {
    public func timeInterval(to other: DispatchTime) -> TimeInterval {
        let nanosecondsPerSecond: Double = 1_000_000_000
        let selfTime = TimeInterval(self.uptimeNanoseconds) / nanosecondsPerSecond
        let otherTime = TimeInterval(other.uptimeNanoseconds) / nanosecondsPerSecond
        
        return otherTime - selfTime
    }
}

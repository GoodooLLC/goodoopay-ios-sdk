import Foundation


public enum PaymentStatus: String, CaseIterable {
    case success
    case failed
    case cancelled
    case pending
}

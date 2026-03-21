import Foundation

public struct PaymentResult {
    public var status: PaymentStatus
    public var transactionId: String?
    public var amount: Double?
    public var timestamp: Date?
    public var errorMessage: String?

    public var isSuccess: Bool { status == .success }
    public var isFailed: Bool { status == .failed }
    public var isCancelled: Bool { status == .cancelled }
    public var isPending: Bool { status == .pending }

    public init(
        status: PaymentStatus,
        transactionId: String? = nil,
        amount: Double? = nil,
        timestamp: Date? = nil,
        errorMessage: String? = nil
    ) {
        self.status = status
        self.transactionId = transactionId
        self.amount = amount
        self.timestamp = timestamp
        self.errorMessage = errorMessage
    }

    public static func fromMap(_ map: [String: Any]) -> PaymentResult {
        let statusStr = (map["status"] as? String)?.lowercased() ?? "failed"
        let status: PaymentStatus = switch statusStr {
        case "success": .success
        case "failed": .failed
        case "cancelled": .cancelled
        case "pending": .pending
        default: .failed
        }
        let amount = (map["amount"] as? NSNumber)?.doubleValue
        let ts = map["timestamp"] as? NSNumber
        let timestamp = ts.map { Date(timeIntervalSince1970: $0.doubleValue / 1000.0) }
        return PaymentResult(
            status: status,
            transactionId: map["transactionId"] as? String,
            amount: amount,
            timestamp: timestamp,
            errorMessage: map["errorMessage"] as? String
        )
    }
}

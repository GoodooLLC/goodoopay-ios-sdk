import Foundation

/// Параметры платежа (аналог Android PaymentParams / Flutter PaymentParams).
/// Используется при вызове GoodooPay.startPayment.
public struct PaymentParams {
    public var apiKey: String
    public var ls: String
    public var bank: String?
    public var transactionId: String?
    public var amount: Double
    public var description: String?
    public var availableMethods: [String]

    public init(
        apiKey: String = "",
        ls: String = "",
        bank: String? = nil,
        transactionId: String? = nil,
        amount: Double,
        description: String? = nil,
        availableMethods: [String] = ["bank", "qr"]
    ) {
        self.apiKey = apiKey
        self.ls = ls
        self.bank = bank
        self.transactionId = transactionId
        self.amount = amount
        self.description = description
        self.availableMethods = availableMethods
    }


    public func toMap() -> [String: Any] {
        var map: [String: Any] = [
            "apiKey": apiKey,
            "ls": ls,
            "amount": amount,
            "availableMethods": availableMethods,
        ]
        map["bank"] = bank ?? NSNull()
        map["transactionId"] = transactionId ?? NSNull()
        map["description"] = description ?? NSNull()
        return map
    }
}

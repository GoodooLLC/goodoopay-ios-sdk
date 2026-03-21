import UIKit
import Flutter
import goodoo_pay

final class ViewController: UIViewController {

    private let engine: FlutterEngine

    init(engine: FlutterEngine) {
        self.engine = engine
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.text = "GoodooPay SDK Example"
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "This example demonstrates how to integrate GoodooPay SDK into your iOS application."
        l.font = .systemFont(ofSize: 16)
        l.numberOfLines = 0
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let amountField: UITextField = {
        let t = UITextField()
        t.placeholder = "Amount"
        t.keyboardType = .decimalPad
        t.text = "10.0"
        t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    private let lsField: UITextField = {
        let t = UITextField()
        t.placeholder = "LS (лицевой счёт)"
        t.text = "112197"
        t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    private let bankField: UITextField = {
        let t = UITextField()
        t.placeholder = "Bank"
        t.text = "О! банк"
        t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    private let startButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Start Payment", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private let statusTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Payment Status:"
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let statusLabel: UILabel = {
        let l = UILabel()
        l.text = "No payment initiated"
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let lastResultTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Last Result:"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let lastStatusLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let lastTransactionIdLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(amountField)
        view.addSubview(lsField)
        view.addSubview(bankField)
        view.addSubview(startButton)
        view.addSubview(statusTitleLabel)
        view.addSubview(statusLabel)
        view.addSubview(lastResultTitleLabel)
        view.addSubview(lastStatusLabel)
        view.addSubview(lastTransactionIdLabel)

        startButton.addTarget(self, action: #selector(startPaymentTapped), for: .touchUpInside)

        let padding: CGFloat = 24
        let spacing: CGFloat = 12

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            amountField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24),
            amountField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            amountField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            amountField.heightAnchor.constraint(equalToConstant: 44),

            lsField.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: spacing),
            lsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            lsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            lsField.heightAnchor.constraint(equalToConstant: 44),

            bankField.topAnchor.constraint(equalTo: lsField.bottomAnchor, constant: spacing),
            bankField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            bankField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            bankField.heightAnchor.constraint(equalToConstant: 44),

            startButton.topAnchor.constraint(equalTo: bankField.bottomAnchor, constant: 24),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            startButton.heightAnchor.constraint(equalToConstant: 44),

            statusTitleLabel.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 32),
            statusTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),

            statusLabel.topAnchor.constraint(equalTo: statusTitleLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            lastResultTitleLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            lastResultTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),

            lastStatusLabel.topAnchor.constraint(equalTo: lastResultTitleLabel.bottomAnchor, constant: 8),
            lastStatusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            lastStatusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            lastTransactionIdLabel.topAnchor.constraint(equalTo: lastStatusLabel.bottomAnchor, constant: 4),
            lastTransactionIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            lastTransactionIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
        ])
    }

    @objc private func startPaymentTapped() {
        let amount = Double(amountField.text ?? "") ?? 10.0
        let ls = (lsField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let bank = (bankField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        let params = PaymentParams(
            apiKey: "",
            ls: ls.isEmpty ? "112197" : ls,
            bank: bank.isEmpty ? "О! банк" : bank,
            transactionId: nil,
            amount: amount,
            description: "",
            availableMethods: ["bank", "qr"]
        )

        GoodooPay.startPayment(from: self, engine: engine, params: params) { [weak self] result in
            self?.handlePaymentResult(result)
        }
    }

    private func handlePaymentResult(_ result: PaymentResult) {
        statusLabel.text = "Payment \(result.status.rawValue)"
        lastStatusLabel.text = "Status: \(result.status.rawValue)"
        lastTransactionIdLabel.text = result.transactionId.map { "Transaction ID: \($0)" } ?? ""
    }
}

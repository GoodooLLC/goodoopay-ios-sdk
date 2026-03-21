import Foundation
import Flutter
import UIKit


public enum GoodooPay {

    private static var pendingCompletion: ((PaymentResult) -> Void)?

    /// Запуск экрана оплаты.
    /// - Parameters:
    ///   - presenter: UIViewController, с которого показывается Flutter-экран.
    ///   - engine: заранее сконфигурированный FlutterEngine (с зарегистрированными плагинами).
    ///   - params: параметры платежа (как на Android).
    ///   - completion: колбэк с результатом (PaymentResult).
    public static func startPayment(
        from presenter: UIViewController,
        engine: FlutterEngine,
        params: PaymentParams,
        completion: @escaping (PaymentResult) -> Void
    ) {
        pendingCompletion = completion

        let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            flutterVC.isModalInPresentation = true
        }
        let startChannel = FlutterMethodChannel(
            name: "goodoo_pay_native_start",
            binaryMessenger: flutterVC.binaryMessenger
        )
        let resultChannel = FlutterMethodChannel(
            name: "goodoo_pay_native_result",
            binaryMessenger: flutterVC.binaryMessenger
        )

        resultChannel.setMethodCallHandler { call, result in
            if call.method == "onPaymentResult",
               let map = call.arguments as? [String: Any] {
                let paymentResult = PaymentResult.fromMap(map)
                pendingCompletion?(paymentResult)
                pendingCompletion = nil
                DispatchQueue.main.async {
                    flutterVC.dismiss(animated: true, completion: nil)
                }
            }
            result(nil)
        }

        presenter.present(flutterVC, animated: true) {
            startChannel.invokeMethod("startPayment", arguments: params.toMap())
        }
    }
}

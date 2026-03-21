# GoodooPay SDK

iOS-пакет для интеграции платежного SDK GoodooPay в мобильные приложения.

## Описание

GoodooPay SDK предоставляет готовый платежный UI и API для запуска оплаты через банковские приложения и QR-коды.

### Возможности

- Оплата через банковские приложения (MBank, DemirBank, Optima и др.)
- Генерация и отображение QR-кодов
- Автоматическая проверка статуса платежа
- Готовый UI с состояниями выбора метода, QR и обработки
- Обработка ошибок и валидация параметров

## Подключение в нативном iOS-приложении

Добавьте в `Podfile`:

```ruby
platform :ios, '13.0'

target 'YourApp' do
  use_frameworks!
  pod 'goodoo_pay', '~> 1.0.0'
end
```

Установите pods:

```bash
pod install
```

## Вызов оплаты из Swift

```swift
import UIKit
import Flutter
import goodoo_pay

let params = PaymentParams(
  apiKey: "",
  ls: "000000", // ACCOUNT_FROM_SLK
  bank: "О! банк",
  transactionId: nil,
  amount: 10.0,
  description: "",
  availableMethods: ["bank", "qr"]
)

let engine = FlutterEngine(name: "goodoo_pay_engine")
engine.run()

GoodooPay.startPayment(from: self, engine: engine, params: params) { result in
  if result.isSuccess {
    // success
  } else if result.isFailed {
    // error
  } else if result.isCancelled {
    // cancelled
  }
}
```

## Требования

- Xcode 15+
- CocoaPods
- iOS deployment target 13.0+

## Запуск примера

Пример находится в `example/`.

1. Установите зависимости:

```bash
cd example
pod install
```

2. Откройте workspace в Xcode (не `.xcodeproj`):

```bash
open GoodooPayNativeExample.xcworkspace
```

3. Выберите симулятор или устройство и нажмите Run.


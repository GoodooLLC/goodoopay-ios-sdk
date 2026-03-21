# GoodooPay SDK — нативный iOS пример

Пример встраивания GoodooPay Flutter SDK в нативное iOS-приложение (UIKit). По функционалу соответствует Android-примеру: поля Amount, LS, Bank, кнопка «Start Payment», отображение статуса и Transaction ID.

## Требования

- Xcode 15+
- CocoaPods
- Flutter SDK (для подготовки модуля)

## Подготовка Flutter-модуля

Из **корня репозитория** (`goodoo_pay_flutter/`):

```bash
flutter pub get
```

При необходимости создаётся каталог `.ios/` с podhelper для add-to-app.

## Сборка и запуск примера

1. Установите поды:

   ```bash
   cd native-examples/ios
   pod install
   ```

2. Откройте workspace в Xcode (не проект):

   ```bash
   open GoodooPayNativeExample.xcworkspace
   ```

3. Выберите целевое устройство или симулятор и запустите (Run).

## API (как на Android)

- **GoodooPay.startPayment(from:params:completion:)** — показать экран оплаты.
- **PaymentParams** — параметры (apiKey, ls, bank, amount, description, availableMethods).
- **PaymentResult** — результат (status, transactionId, amount, errorMessage; isSuccess, isFailed, isCancelled).
- **PaymentStatus** — enum: success, failed, cancelled, pending.

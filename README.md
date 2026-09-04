# Fiserv EmFI BaaS SDK Integration Guide for iOS

> Version: Current Release  
> Platform: iOS  
> Library: EmfiBaasSDK

---

# Overview

The **Fiserv EmFI BaaS SDK** provides a secure and seamless user experience for card-management operations within an iOS application.

Supported capabilities include:

- Physical Card Activation
- Card PIN Management
- Virtual Card Viewing
- Apple Wallet Provisioning

The SDK manages UI flows, communication with backend services, and secure handling of card operations while allowing extensive customization to match your application's branding.

---

# Requirements

| Requirement | Version |
|------------|---------|
| iOS | 17.0+ |
| Swift | Latest Stable Version |
| Package Manager | Swift Package Manager (SPM) |
| Device Testing | Physical Device Required for Wallet Provisioning |

---

# Installation

## Add SDK Using Swift Package Manager

In Xcode:

1. Select **File → Add Package Dependencies**.
2. Enter the repository URL.
3. Select the desired branch or version.
4. Add the package to your target.

Repository:

```swift
package(
    url: "https://github.com/PayFare/PayfareiSDK",
    branch: "master"
)
```

---

# SDK Initialization

Initialize the SDK before launching any user flow.

```swift
let cardManager = FiservSDK.initialize(
    userId: userId,
    tokenHandler: {
        return getUserToken()
    },
    environment: .uat,
    viewConfigurator: sdkViewConfigurator
)
```

## Initialization Parameters

| Parameter | Required | Description |
|------------|----------|-------------|
| userId | Yes | Unique identifier of the authenticated user |
| tokenHandler | Yes | Callback used to retrieve or refresh the user token |
| environment | Yes | SDK environment |
| viewConfigurator | No | UI customization configuration |

---

# Environment Configuration

```swift
public enum Environment: String {
    case uat
    case devstudio
    case cert
    case prod
}
```

| Environment | Description |
|------------|-------------|
| uat | User Acceptance Testing |
| devstudio | Development Environment |
| cert | Certification Environment |
| prod | Production Environment |

---

# Supported Flows

```swift
public enum UserFlow {
    case activatePhysicalCard
    case viewVirtualCard(cardIcon: Image?)
    case setCardPIN
    case cardProvisioning(cardIcon: Image?)
}
```

| Flow | Description |
|--------|-------------|
| activatePhysicalCard | Activate physical card |
| setCardPIN | Create or update card PIN |
| viewVirtualCard | Display virtual card details |
| cardProvisioning | Add card to Apple Wallet |

---

# Launching SDK Flows

After SDK initialization, call `launch()` with the desired flow.

```swift
FiservSDK.instance?.launch(
    flow: .activatePhysicalCard,
    sourceViewControllerHandler: { [weak self] viewController in
        self?.present(viewController, animated: true)
    },
    callBackHandler: { result in
        self.handleResult(result)
    },
    errorHandler: { error in
        self.handleError(error)
    }
)
```

## Parameters

| Parameter | Description |
|------------|-------------|
| flow | Desired SDK flow |
| sourceViewControllerHandler | Returns SDK view controllers to present |
| callBackHandler | Receives success and navigation events |
| errorHandler | Receives SDK and API error responses |

---

# Callback Handling

```swift
public enum CallbackResult {
    case error
    case moveBack
    case successActivationCardClosed
    case pinHasBeenChanged
    case virtualCardHasBeenViewed
    case setPinFeatureDisabled
    case viewVirtualCardFeatureDisabled
    case activePhysicalCardFeatureDisabled
    case cardWasProvisioningWithSuccess
}
```

## Callback Events

| Callback | Description |
|-----------|-------------|
| moveBack | User exited the SDK flow |
| successActivationCardClosed | Card activated successfully |
| pinHasBeenChanged | PIN updated successfully |
| virtualCardHasBeenViewed | Virtual card screen displayed and dismissed |
| cardWasProvisioningWithSuccess | Card successfully added to Apple Wallet |
| setPinFeatureDisabled | PIN feature unavailable |
| viewVirtualCardFeatureDisabled | Virtual Card feature unavailable |
| activePhysicalCardFeatureDisabled | Card Activation feature unavailable |

Example:

```swift
private func handleResult(_ result: CallbackResult) {
    switch result {
    case .successActivationCardClosed:
        print("Card activated")

    case .pinHasBeenChanged:
        print("PIN updated")

    case .cardWasProvisioningWithSuccess:
        print("Wallet provisioning successful")

    case .moveBack:
        print("User exited flow")

    default:
        break
    }
}
```

---

# Physical Card Activation Flow

Launch card activation:

```swift
FiservSDK.instance?.launch(
    flow: .activatePhysicalCard,
    sourceViewControllerHandler: { vc in
        self.present(vc, animated: true)
    },
    callBackHandler: handleResult,
    errorHandler: handleError
)
```

### Success Events

- successActivationCardClosed
- moveBack

### Possible Errors

- CARD_ALREADY_ACTIVE
- CARD_ACTIVATION_ERROR

---

# Change PIN Flow

Launch PIN management:

```swift
FiservSDK.instance?.launch(
    flow: .setCardPIN,
    sourceViewControllerHandler: { vc in
        self.present(vc, animated: true)
    },
    callBackHandler: handleResult,
    errorHandler: handleError
)
```

### Success Events

- pinHasBeenChanged
- moveBack

### Possible Errors

- CARD_PIN_ERROR

---

# Virtual Card Flow

Displays:

- PAN
- CVV
- Expiration Date

Launch:

```swift
FiservSDK.instance?.launch(
    flow: .viewVirtualCard(cardIcon: UIImage(named: "card_art")),
    sourceViewControllerHandler: { vc in
        self.present(vc, animated: true)
    },
    callBackHandler: handleResult,
    errorHandler: handleError
)
```

### Success Events

- virtualCardHasBeenViewed
- moveBack

### Possible Errors

- NO_CARD_FOUND
- VC_OTP_NOT_VALIDATED
- VC_TOKEN_EXPIRED
- VC_OTP_ENTER_TIME_EXPIRE
- VIRTUAL_CARD_ERROR

---

# Apple Wallet Provisioning

The SDK supports provisioning payment cards directly into Apple Wallet.

> Important: Apple approval is required before provisioning can be enabled in production.

---

## Prerequisites

- Active Apple Developer Program membership
- Physical iOS device running iOS 17+
- Apple Wallet enabled on device
- Apple approval for Payment Pass Provisioning entitlement

---

## Enable Wallet Capability

1. Open Xcode.
2. Select your application target.
3. Navigate to **Signing & Capabilities**.
4. Add the **Wallet** capability.
5. Verify the entitlement exists:

```xml
com.apple.developer.payment-pass-provisioning
```

---

## Request Apple Entitlement

Request approval through Apple Developer Support before App Store distribution.

Provide:

- Institution name
- Card type (credit/debit/prepaid)
- Issuer information
- Provisioning use case

After approval:

- Regenerate provisioning profiles.
- Download updated profiles.
- Rebuild the application.

---

## Verify Runtime Readiness

```swift
PKAddPaymentPassViewController.canAddPaymentPass()
```

Before launching provisioning ensure:

- Returns `true`
- Wallet is available
- User is logged into iCloud
- Device runs iOS 17+

---

## Launch Provisioning Flow

```swift
FiservSDK.instance?.launch(
    flow: .cardProvisioning(
        cardIcon: UIImage(named: "card_art")
    ),
    sourceViewControllerHandler: { vc in
        self.present(vc, animated: true)
    },
    callBackHandler: handleResult,
    errorHandler: handleError
)
```

### Success Event

- cardWasProvisioningWithSuccess

---

# Error Handling

The SDK automatically manages most user-facing error states while providing callback notifications for application-level handling.

## Standard Errors

| Error | Description |
|---------|-------------|
| VC_OTP_NOT_VALIDATED | Virtual Card OTP failed after maximum attempts |
| VC_TOKEN_EXPIRED | Virtual Card token expired |
| VC_OTP_ENTER_TIME_EXPIRE | OTP expiration reached |
| CARD_ALREADY_ACTIVE | Card already activated |
| NO_CARD_FOUND | No card available |

---

## Dynamic Virtual Card Errors

```swift
VIRTUAL_CARD_ERROR(code, message)
```

| Code | Description |
|--------|-------------|
| 401 | Unauthorized |
| 8022 | Virtual Card unavailable |

---

## Dynamic Card Activation Errors

```swift
CARD_ACTIVATION_ERROR(code, message)
```

| Code | Description |
|--------|-------------|
| 9119 | Card details mismatch |
| 401 | Unauthorized |

---

## Dynamic PIN Errors

```swift
CARD_PIN_ERROR(code, message)
```

| Code | Description |
|--------|-------------|
| 401 | Unauthorized |

---

# Alert View Controller Handling

When invalid credentials or configuration values are provided during initialization, the SDK may return an alert controller instead of a standard flow.

```swift
if viewController is IsAlertViewController {
    present(viewController, animated: true)
}
```

This allows applications to distinguish between:

- Full SDK Flows
- Alert Dialogs

and present them using separate mechanisms if required.

---

# Debug Mode

Debug logging is enabled automatically when using:

```swift
Environment.uat
```

Recommended:

- Enable logging only in testing environments.
- Use `.prod` for release builds.

---

# UI Customization

The SDK supports branding customization through configuration objects.

---

## Colors Customizer

```swift
public struct ColorsCustomizer {
    public var primaryColor: String?
    public var textPrimaryColor: String?
    public var textSecondaryColor: String?
    public var textTertiaryColor: String?
    public var backgroundSecondaryColor: String?
    public var errorColor: String?
    public var primaryButtonTextColor: String?
}
```

Example:

```swift
let colors = ColorsCustomizer(
    primaryColor: "#005252",
    textPrimaryColor: "#191919",
    textSecondaryColor: "#494949",
    errorColor: "#B71000",
    primaryButtonTextColor: "#FFFFFF"
)
```

---

## View Configuration

```swift
public struct SDKViewConfigurator {
    public var customColors: ColorsCustomizer?
    public var cornerButtonRadius: CGFloat?
    public var fontFamilyName: String?
}
```

Example:

```swift
let configurator = SDKViewConfigurator(
    customColors: colors,
    cornerButtonRadius: 12,
    fontFamilyName: "SF Pro Display"
)
```

---

# Best Practices

1. Initialize the SDK once after user authentication.
2. Always provide a valid token through `tokenHandler`.
3. Refresh expired tokens automatically.
4. Validate Apple Wallet readiness before launching provisioning.
5. Handle both callback and error responses.
6. Test provisioning only on physical devices.
7. Use production configuration only after Apple entitlement approval.
8. Keep SDK UI branding consistent with your application.

---

# Support

For environment setup, onboarding, Wallet provisioning approval guidance, or implementation support, contact your Fiserv implementation team.

# FormValidationKit

[![Swift Version](https://img.shields.io/badge/Swift-5.9-orange.svg?style=flat)](https://swift.org)
[![Platforms](https://img.shields.io/badge/iOS-13%2B-blue.svg?style=flat)](https://developer.apple.com/ios/)
[![Swift Package](https://img.shields.io/badge/Swift_Package-✅-brightgreen.svg)](https://swift.org/package-manager/)
[![Build](https://github.com/your-repo/FormValidationKit/actions/workflows/ci.yml/badge.svg)](https://github.com/your-repo/FormValidationKit/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**FormValidationKit** is a lightweight SwiftUI library for **TextField and Form validation**. It provides:

* A simple API to validate individual fields with error messages.
* Easy integration with SwiftUI `Form` for native form validation.
* The ability to **customize error message display** (color, alignment, style).

---

## Installation

### Swift Package Manager

Add the package via URL:

```
https://github.com/your-repo/FormValidationKit.git
```

In Xcode: `File → Swift Packages → Add Package Dependency` → paste the URL.

Then import the library:

```swift
import FormValidationKit
```

---

## Key Concepts

### `ValidationRule`

A validation rule for a field:

```swift
public struct ValidationRule {
    let validate: () -> Bool
    let errorMessage: String?

    public init(validate: @escaping () -> Bool, errorMessage: String?) { ... }
    func evaluate() -> ValidationResult { ... }
}
```

### `ValidationResult`

Validation result:

```swift
public struct ValidationResult: Equatable {
    public let isValid: Bool
    public let errorMessage: String?
}
```

---

## Use Case 1: Custom Form with `TextFormView`

For custom layouts or non-Form views:

```swift
TextFormView { validateAllFields in
    VStack {
        TextField("Email", text: $email)
            .validate([
                ValidationRule(validate: { email.count > 6 }, errorMessage: "Email must be longer than 6 characters")
            ])

        Button("Validate") {
            if validateAllFields() {
                print("Form is valid")
            } else {
                print("Form is invalid")
            }
        }
    }
}
```

* `validateAllFields()` returns `true` if all validations pass.
* You can **customize error messages**:

```swift
TextField("Name", text: $name)
    .validate([ValidationRule(validate: { !name.isEmpty }, errorMessage: "Name is required")]) { message in
        Text(message)
            .font(.caption)
            .foregroundStyle(.purple)
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
```

---

## Use Case 2: Native SwiftUI Form

Retrieve all field validations using the `validateForm` extension:

```swift
Form {
    TextField("Email", text: $email)
        .validate([
            ValidationRule(validate: { email.count > 6 }, errorMessage: "Email too short")
        ])

    TextField("Name", text: $name)
        .validate([
            ValidationRule(validate: { !name.isEmpty }, errorMessage: "Name required")
        ])
}
.validateForm { results in
    validationResults = results
}

Button("Validate") {
    if validationResults.allSatisfy({ $0.isValid }) {
        print("Form is valid")
    } else {
        print("Form is invalid")
    }
}
.disabled(!validationResults.allSatisfy({ $0.isValid }))
```

* Each field can have a **custom error view** or use the default style (red caption text).

---

## Customization

* Customize error message color and alignment via the `errorView` builder.
* Set a fixed height for the error `Text` to prevent layout jumps:

```swift
TextField("Phone", text: $phone)
    .validate([
        ValidationRule(validate: { phone.hasPrefix("+") }, errorMessage: "Must start with +")
    ]) { message in
        Text(message)
            .foregroundStyle(.orange)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(height: 20)
    }
```

---

## Compatibility

* SwiftUI iOS 13+ (for `Form`)
* iOS 15+ for `TextFormView` and `@MainActor` usage

---

## Examples

* `Examples/ValidateTextFieldsSampleView.swift` → Custom form using `TextFormView`.
* `Examples/ValidationFormSample.swift` → Native SwiftUI `Form` using `Form.validateForm`.

---

## Package Structure

```
FormValidationKit/
├─ Package.swift
├─ Sources/
│  └─ FormValidationKit/
│      ├─ Form+Validation.swift
│      ├─ TextField+Validation.swift
│      ├─ ValidationPreferenceKey.swift
│      ├─ ValidationResult.swift
│      └─ ValidationRule.swift
└─ Examples/
   ├─ ValidateTextFieldsSampleView.swift
   └─ ValidationFormSample.swift
```

---

## Unit Tests

Includes a test target `FormValidationKitTests` to validate rules and results:

```swift
func testValidationResult() {
    let rule = ValidationRule(validate: { false }, errorMessage: "fail")
    let result = rule.evaluate()
    XCTAssertFalse(result.isValid)
    XCTAssertEqual(result.errorMessage, "fail")
}
```

Build and test badges reflect the GitHub Actions workflow.

---

## License

MIT License – see LICENSE file.


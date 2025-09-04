
import SwiftUI

@available(iOS 15.0, *)
public extension Form {
    
    func validateForm(_ onValidate: @escaping ([ValidationResult]) -> Void) -> some View {
        self.onPreferenceChange(ValidationPreferenceKey.self) { results in
            onValidate(results)
        }
    }
}

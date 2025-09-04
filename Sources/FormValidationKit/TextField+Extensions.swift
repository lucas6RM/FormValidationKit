
import SwiftUI
import SwiftUICore

@available(iOS 15.0, *)
public extension TextField {
    
    // 1) style par défaut
    @MainActor func validate(_ rules: [ValidationRule]) -> some View {
        self.modifier(ValidationModifier(
            rules: rules,
            errorView: { errorMessage in
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }))
    }
    
    // 2) viewbuilder custom
    @MainActor func validate<ErrorView: View>(_ rules: [ValidationRule],
        @ViewBuilder errorView: @escaping (String) -> ErrorView
    ) -> some View {
        modifier(ValidationModifier(rules: rules, errorView: errorView))
    }
    
    private struct ValidationModifier<ErrorView : View> : ViewModifier  {
        
        let rules: [ValidationRule]
        let errorView: (String) -> ErrorView
        
        func body(content: Content) -> some View {
            let results = rules.map { rule in
                rule.evaluate()
            }
            
            let firstError = results.first { rule in
                !rule.isValid
            }
            
            return VStack(alignment: .trailing, spacing: 10){
                content
                    .preference(
                        key: ValidationPreferenceKey.self,
                        value: [firstError ?? ValidationResult(isValid: true, errorMessage: nil)]
                    )
                
                if let errorMessage = firstError?.errorMessage{
                    errorView(errorMessage)
                    
                }
                
            }
        }
    }

}



import SwiftUICore

@available(iOS 15.0, *)
public struct TextFormView<Content : View> : View {
    @State var validationSeeds : [ValidationResult] = []
    @ViewBuilder var content : (( @escaping () -> Bool)) -> Content
    
    public init(@ViewBuilder content: @escaping (( @escaping () -> Bool)) -> Content) {
            self.content = content
    }
    
    public var body: some View {
        content(validateAllFields)
            .onPreferenceChange(ValidationPreferenceKey.self) { value in
                validationSeeds = value
            }
    }
    
    private func validateAllFields() -> Bool {
        for seed in validationSeeds {
            
            if !seed.isValid { return false }
        }
        return true
    }
    
}

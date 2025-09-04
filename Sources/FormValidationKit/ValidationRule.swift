

public struct ValidationRule {
    let validate: () -> Bool
    let errorMessage: String?
    
    public init(validate: @escaping () -> Bool, errorMessage: String?) {
            self.validate = validate
            self.errorMessage = errorMessage
        }
    
    func evaluate() -> ValidationResult {
        let ok = validate()
        
        return ValidationResult(
            isValid: ok,
            errorMessage: ok ? nil : errorMessage
        )
    }
}

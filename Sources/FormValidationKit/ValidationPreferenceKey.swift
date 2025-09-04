

import SwiftUICore

struct ValidationPreferenceKey : @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: [ValidationResult] = []
 
    static func reduce(value: inout [ValidationResult], nextValue: () -> [ValidationResult]) {
        value += nextValue()
    }
    
    typealias Value = [ValidationResult]
    
}


import SwiftUI
import FormValidationKit


@available(iOS 15.0, *)
struct ValidateTextFieldsSampleView: View {
    @State var email : String = ""
    @State var password : String = ""
    @State var name : String = ""
    @State var phone : String = ""
    
    @State private var isFormValidated : Bool? = nil
    
    
    var body: some View {
        
        TextFormView { validateAllFields in
            
            Text("Custom Form View sample")
                .font(.title)
                .padding(.bottom,100)
            
            VStack(spacing: 50) {
                
                TextField("Email", text: $email)
                    .validate ([
                        ValidationRule(
                            validate: { email.count > 6 },
                            errorMessage: "l'email doit dépasser 6 caractères"
                        )
                    ])
                    .textFieldStyle(.roundedBorder)
                
                TextField("Name", text: $name)
                    .validate ([
                        ValidationRule(
                            validate: { !name.isEmpty },
                            errorMessage: "le nom ne doit pas etre vide"
                        )
                    ],errorView: { errorMessage in
                        Text(errorMessage)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                            .foregroundStyle(.purple)
                        
                    })
                    .textFieldStyle(.roundedBorder)
                
                TextField("phone", text: $phone)
                    .validate ([
                        ValidationRule(
                            validate: { phone.hasPrefix("+") },
                            errorMessage: "le téléphone doit commencer par + "
                        ),
                        ValidationRule(
                            validate: { phone.count > 10 },
                            errorMessage: "le numéro doit faire 10 caractères"
                        ),
                    ])
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
                
                if let isFormValidated {
                    Text(isFormValidated ? "Form Correct" : "Form Wrong")
                        .foregroundStyle(isFormValidated ? .green : .red)
                        .font(.caption)
                } else {
                    Text(" ")
                        .font(.caption)
                }
                
                Button {
                    if validateAllFields() {
                        isFormValidated = true
                    }
                    else {
                        isFormValidated = false
                    }
                    
                } label: {
                    Text("Validate all Textfields")
                        .padding(.all)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(16)
                }
                
            }.padding()
        }
    }
    
}


@available(iOS 15.0, *)
#Preview {
    ValidateTextFieldsSampleView()
}

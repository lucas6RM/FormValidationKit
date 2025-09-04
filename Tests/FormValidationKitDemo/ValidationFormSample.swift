//
//  ValidationFormSample.swift
//  BacASable
//
//  Created by lucas mercier on 04/09/2025.
//

import SwiftUI


@available(iOS 15.0, *)
struct ValidationFormSample: View {
    
    
    @State var email : String = ""
    @State var password : String = ""
    @State var name : String = ""
    @State var phone : String = ""
    
    @State private var validationResults : [ValidationResult] = []
    
    @State private var isFormValidated : Bool? = nil
    
    
    var body: some View {
        
        VStack {
            
            Text("Native Form sample")
                .font(.title)
            
            Form {
                Section {
                    // This Text field uses a default ErrorView
                    TextField("Email", text: $email)
                        .validate ([
                            ValidationRule(
                                validate: { email.count > 6 },
                                errorMessage: "email must be at least 6 characters"
                            ),
                            ValidationRule(
                                validate: { email.contains("@") },
                                errorMessage: "email must contains @"
                            )
                        ]
                        )
                }
                
                Section{
                    // This Text field uses a custom errorView
                    TextField("Name", text: $name)
                        .validate ([
                            ValidationRule(
                                validate: { !name.isEmpty },
                                errorMessage: "name must not be empty"
                            )
                        ],errorView: { errorMessage in
                            Text(errorMessage)
                                .font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .foregroundStyle(.purple)
                            
                        })
                }
                
                Section {
                    TextField("phone", text: $phone)
                        .validate ([
                            ValidationRule(
                                validate: { phone.hasPrefix("+") },
                                errorMessage: "phone must begin with +"
                            ),
                            ValidationRule(
                                validate: { phone.count > 10 },
                                errorMessage: "phone must be at least 10 characters"
                            ),
                        ])
                }
                
            }.validateForm { results in
                validationResults = results
            }
            .padding(.bottom)
        }
        
        if let isFormValidated {
            Text(isFormValidated ? "Form Correct" : "Form Wrong")
                .foregroundStyle(isFormValidated ? .green : .red)
                .font(.caption)
        } else {
            Text(" ")
                .font(.caption)
        }
        
        Button {
            if validationResults.allSatisfy({ $0.isValid}) {
                isFormValidated = true
            }
            else {
                isFormValidated = false
            }
        } label: {
            Text("Validate form")
                .padding()
                .background(.gray.opacity(0.2))
                .cornerRadius(16)
        }
        
        
    }
}


@available(iOS 15.0, *)
#Preview {
    ValidationFormSample()
}

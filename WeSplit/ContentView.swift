//
//  ContentView.swift
//  WeSplit
//
//  Created by Linda Lau on 9/16/22.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused : Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var tip: Double{
        let ratio = Double(tipPercentage) / 100.0
        return checkAmount * ratio
    }
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 2)
        
        let total = (checkAmount + tip) / peopleCount
        
        return total
    }
    
    var body: some View {
        NavigationView {
            Form{
                // Enter check amount
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section{
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                
                Picker("Number of people", selection: $numberOfPeople){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per person:")
                } footer: {
                    VStack(alignment: .leading){
                        Text("Details:")
                        HStack{
                            Text("Sub Total: \t")
                            Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                        HStack{
                            Text("Tip: \t\t\t")
                            Text(tip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                        Divider()
                            .padding([.leading, .trailing])
                        HStack{
                            Text("Total: \t\t")
                            Text(checkAmount + tip, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        }
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

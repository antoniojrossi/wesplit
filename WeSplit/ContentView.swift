//
//  ContentView.swift
//  WeSplit
//
//  Created by Antonio J Rossi on 01/02/2020.
//  Copyright © 2020 Antonio J Rossi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    var totalCheckAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = ","
        let orderAmount = numberFormatter.number(from: checkAmount)?.doubleValue ?? 0
        return orderAmount + (orderAmount / 100 * tipSelection)
    }
    var totalPerPerson: Double {
        let peopleCount = Int(numberOfPeople) ?? 1
        let amountPerPerson = totalCheckAmount / Double(peopleCount)
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do yo want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount for the check")) {
                    Text("\(totalCheckAmount, specifier: "%.2f") €")
                        .foregroundColor(tipPercentages[tipPercentage] > 0 ? .black : .red)
                }
                Section(header: Text("Amount per person")) {
                    Text("\(totalPerPerson, specifier: "%.2f") €")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

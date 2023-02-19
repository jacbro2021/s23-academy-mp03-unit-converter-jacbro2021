//
//  ContentView.swift
//  Unit Converter
//
//  Created by jacob brown on 2/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var input: String = ""
    @State var unit: String = "Meters"
    @State var outputUnitChoice = "Meters"
    @FocusState private var inputFocus: Bool
    let lengthUnits = ["Meters", "Km", "Feet", "Yards", "Miles"]
    let outputUnits = ["Meters", "Km", "Feet", "Yards", "Miles"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Input Value", text: $input)
                            .keyboardType(.decimalPad)
                            .focused($inputFocus)
                        
                        Picker("Input Unit",selection: $unit) {
                            ForEach(lengthUnits, id: \.self) { item in
                                Text(item)
                            }
                        }   .pickerStyle(.segmented)
                    } header: {
                        Text("Input Value and Units")
                            .font(.system(.caption))
                    }
                    
                    Section {
                        Picker("Output Unit", selection: $outputUnitChoice) {
                            ForEach(outputUnits, id: \.self) { item in
                                Text(item)
                            }
                        } .pickerStyle(.segmented)
                    } header: {
                        Text("Output Unit")
                            .font(.system(.caption))
                    }
                    
                    OutputView(input: $input, inputUnit: $unit, outputUnit: $outputUnitChoice)
                }
                
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputFocus = false
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

struct OutputView : View {
    
    @Binding var input: String
    @Binding var inputUnit: String
    @Binding var outputUnit: String
    
    private var doubleInput: Double {
        let x: Double? = Double(input)
        guard let unwrapped = x else {
            return 0.0
        }
        return unwrapped
    }
    
    private var convertedToMeters: Double {
        switch inputUnit {
        case "Km":
            return doubleInput * 1000.0
        case "Feet":
            return doubleInput * 0.3048
        case "Yards":
            return doubleInput * 0.9144
        case "Miles":
            return  doubleInput * 1609.34
        default:
            return doubleInput
        }
    }
    
    private var convertedToOutput: Double {
        switch outputUnit {
        case "Km":
            return convertedToMeters / 1000.0
        case "Feet":
            return convertedToMeters / 0.3048
        case "Yards":
            return convertedToMeters / 0.9144
        case "Miles":
            return  convertedToMeters / 1609.34
        default:
            return convertedToMeters
        }
    }
    var body: some View {
        Section {
            Text("\(convertedToOutput)")
        } header: {
            Text("\(inputUnit) converted to \(outputUnit)")
        }
    }
}

//
//  ContentView.swift
//  Unit Converter
//
//  Created by jacob brown on 2/18/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                NavigationLink(destination: LengthInputView()) {
                    Text("Length Converter")
                }   .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(.blue)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                NavigationLink(destination: TemperatureInputView()) {
                    Text("Temperature Converter")
                }   .padding(.horizontal, 30)
                    .padding(.vertical)
                    .background(.red)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                NavigationLink(destination: TimeInputView()) {
                    Text("Time Converter")
                }   .padding(.horizontal, 60)
                    .padding(.vertical)
                    .background(.orange)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                NavigationLink(destination: VolumeInputView()) {
                    Text("Volume Converter")
                }   .padding(.horizontal, 50)
                    .padding(.vertical)
                    .background(.purple)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                Spacer()
            }   .navigationTitle("Unit Converter")
                .padding(.top, 40)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct LengthInputView : View {
    
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
                    
                    LengthOutputView(input: $input, inputUnit: $unit, outputUnit: $outputUnitChoice)
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

struct LengthOutputView : View {
    
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

struct TemperatureInputView : View {
    
    @State var input: String = ""
    @State var unit: String = "Celsius"
    @State var outputUnitChoice = "Celsius"
    @FocusState private var inputFocus: Bool
    let lengthUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let outputUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    
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
                    
                    TemperatureOutputView(input: $input, inputUnit: $unit, outputUnit: $outputUnitChoice)
                }
                
            }
            .navigationTitle("Temperature Conversion")
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

struct TemperatureOutputView : View {
    
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
    
    private var convertedToCelsius: Double {
        switch inputUnit {
        case "Fahrenheit":
            return (doubleInput - 32) * (5/9)
        case "Kelvin":
            return doubleInput - 273.15
        default:
            return doubleInput
        }
    }
    
    private var convertedToOutput: Double {
        switch outputUnit {
        case "Fahrenheit":
            return (convertedToCelsius * (9/5)) + 32
        case "Kelvin":
            return convertedToCelsius + 273.15
        default:
            return convertedToCelsius
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

struct TimeInputView : View {
    
    @State var input: String = ""
    @State var unit: String = "Seconds"
    @State var outputUnitChoice = "Seconds"
    @FocusState private var inputFocus: Bool
    let lengthUnits = ["Seconds", "Minutes", "Hours", "Days"]
    let outputUnits = ["Seconds", "Minutes", "Hours", "Days"]
    
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
                    
                    TimeOutputView(input: $input, inputUnit: $unit, outputUnit: $outputUnitChoice)
                }
                
            }
            .navigationTitle("Time Conversion")
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

struct TimeOutputView : View {
    
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
    
    private var convertedToSeconds: Double {
        switch inputUnit {
        case "Minutes":
            return doubleInput * 60.0
        case "Hours":
            return doubleInput * 3600.0
        case "Days":
            return doubleInput * 86400.0
        default:
            return doubleInput
        }
    }
    
    private var convertedToOutput: Double {
        switch outputUnit {
        case "Minutes":
            return convertedToSeconds / 60.0
        case "Hours":
            return convertedToSeconds / 3600.0
        case "Days":
            return convertedToSeconds / 86400.0
        default:
            return convertedToSeconds
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

struct VolumeInputView : View {
    
    @State var input: String = ""
    @State var unit: String = "mL"
    @State var outputUnitChoice = "mL"
    @FocusState private var inputFocus: Bool
    let lengthUnits = ["mL", "Liters", "Cups", "Pints", "Gallons"]
    let outputUnits = ["mL", "Liters", "Cups", "Pints", "Gallons"]
    
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
                    
                    VolumeOutputView(input: $input, inputUnit: $unit, outputUnit: $outputUnitChoice)
                }
                
            }
            .navigationTitle("Volume Conversion")
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

struct VolumeOutputView : View {
    
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
    
    private var convertedToML: Double {
        switch inputUnit {
        case "Liters":
            return doubleInput * 1000.0
        case "Cups":
            return doubleInput * 240.0
        case "Pints":
            return doubleInput * 473.16
        case "Gallons":
            return  doubleInput * 3785.41
        default:
            return doubleInput
        }
    }
    
    private var convertedToOutput: Double {
        switch outputUnit {
        case "Liters":
            return convertedToML / 1000.0
        case "Cups":
            return convertedToML / 240.0
        case "Pints":
            return convertedToML / 473.16
        case "Gallons":
            return  convertedToML / 3785.41
        default:
            return convertedToML
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

// CPSC5340 Assignment 2
// BreweryOrderProj
// Joseph Baldwin

import SwiftUI

struct ContentView: View {
    @State private var lagerQuantity = 0
    @State private var ipaQuantity = 0
    @State private var stoutQuantity = 0
    @State private var amberQuantity = 0

    @State private var addTip = false
    @State private var tipPercentage = 15
    @State private var presentConfirmation = false

    private let breweryOrange = Color(
        red: 232/255,
        green: 119/255,
        blue: 34/255
    )

    private var subtotal: Double {
        Double(lagerQuantity) * 6.00
        + Double(ipaQuantity) * 7.00
        + Double(stoutQuantity) * 8.00
        + Double(amberQuantity) * 6.50
    }

    private var tipAmount: Double {
        if addTip {
            return subtotal * Double(tipPercentage) / 100
        }

        return 0
    }

    private var total: Double {
        subtotal + tipAmount
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(spacing: 10) {
                        Image(systemName: "mug.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(breweryOrange)

                        Text("Auburn Brewing Company")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("Learn the ABCs of truly delicious craft beer.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                }

                Section("On Tap") {
                    BeerRow(
                        name: "Tiger Lager",
                        price: 6.00,
                        quantity: $lagerQuantity
                    )

                    BeerRow(
                        name: "Plainsman IPA",
                        price: 7.00,
                        quantity: $ipaQuantity
                    )

                    BeerRow(
                        name: "Samford Stout",
                        price: 8.00,
                        quantity: $stoutQuantity
                    )

                    BeerRow(
                        name: "Toomer's Amber Ale",
                        price: 6.50,
                        quantity: $amberQuantity
                    )
                }

                Section("Leave a Tip") {
                    TipSection(
                        addTip: $addTip,
                        tipPercentage: $tipPercentage
                    )
                }

                Section("Order Summary") {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text("$\(subtotal, specifier: "%.2f")")
                    }

                    if addTip {
                        HStack {
                            Text("Tip (\(tipPercentage)%)")
                            Spacer()
                            Text("$\(tipAmount, specifier: "%.2f")")
                        }
                    }

                    HStack {
                        Text("Total")
                        Spacer()
                        Text("$\(total, specifier: "%.2f")")
                    }
                    .font(.headline)
                    .foregroundStyle(breweryOrange)
                }

                Section {
                    Button {
                        presentConfirmation = true
                    } label: {
                        Text("Confirm Order")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(subtotal == 0)
                }
            }
            .navigationTitle("Brewery Order")
            .sheet(isPresented: $presentConfirmation) {
                ConfirmationView(
                    present: $presentConfirmation,
                    total: total
                )
            }
        }
    }
}

struct BeerRow: View {
    let name: String
    let price: Double

    @Binding var quantity: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(name)
                    .font(.headline)

                Spacer()

                Text("$\(price, specifier: "%.2f")")
                    .foregroundStyle(.secondary)
            }

            Stepper(
                "Quantity: \(quantity)",
                value: $quantity,
                in: 0...10
            )
            .font(.subheadline)
        }
        .padding(.vertical, 6)
    }
}

struct TipSection: View {
    @Binding var addTip: Bool
    @Binding var tipPercentage: Int

    let tipOptions = [10, 15, 20]

    var body: some View {
        VStack(spacing: 12) {
            Toggle("Add a tip", isOn: $addTip)

            if addTip {
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(tipOptions, id: \.self) { percentage in
                        Text("\(percentage)%")
                            .tag(percentage)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ConfirmationView: View {
    @Binding var present: Bool
    let total: Double
    private let breweryOrange = Color(
        red: 232/255,
        green: 119/255,
        blue: 34/255
    )

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(breweryOrange)

            Text("Order Confirmed!")
                .font(.title)
                .fontWeight(.bold)

            Text("Your order total is $\(total, specifier: "%.2f").")
                .multilineTextAlignment(.center)

            Text("Thanks for visiting Auburn Brewing Company!")
                .foregroundStyle(.secondary)

            Button("Dismiss") {
                present = false
            }
            .buttonStyle(.borderedProminent)
            .tint(breweryOrange)
        }
        .padding(24)
    }
}

#Preview {
    ContentView()
}

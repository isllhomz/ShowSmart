import SwiftUI

struct DynamicShowingsInput: View {
    @Binding var bedRooms: Int
    @Binding var bathRooms: Int
    
    @Binding var bedrooms: [ShowingsData]?
    @Binding var bathrooms: [ShowingsData]?
    
    var body: some View {
        VStack {
            Stepper("Number of Bedrooms \(bedRooms)", onIncrement: {
                if bedRooms < 10 {
                    bedRooms += 1
                    updateBedrooms()
                }
            }, onDecrement: {
                if bedRooms > 1 {
                    bedRooms -= 1
                    updateBedrooms()
                }
            })
            
            Stepper("Number of Bathrooms \(bathRooms)", onIncrement: {
                if bathRooms < 10 {
                    bathRooms += 1
                    updateBathrooms()
                }
            }, onDecrement: {
                if bathRooms > 1 {
                    bathRooms -= 1
                    updateBathrooms()
                }
            })
        }
        .padding(.horizontal)
        .onAppear {
            updateBedrooms()
            updateBathrooms()
        }
    }
    
    private func updateBedrooms() {
        bedrooms = (0..<bedRooms).map { _ in ShowingsData(type: "bedroom") }
    }
    
    private func updateBathrooms() {
        bathrooms = (0..<bathRooms).map { _ in ShowingsData(type: "bathroom") }
    }
}

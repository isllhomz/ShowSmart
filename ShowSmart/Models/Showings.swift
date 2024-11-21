import Foundation

struct Showings : Codable {
    let data: [ShowingsData]
}

struct ShowingsData: Identifiable, Codable, Hashable {
    var id: String
    let type : String
    let options : [String: [String]]
    var selected : [String: String]
    
    
    init(id: String = UUID().uuidString, type: String) {
        //bedroom
        if type == "bedroom" {
            self.id = id
            self.type = "Bedroom"
            self.options = [
                "1 Level": ["Lower", "Main", "Upper"],
                "2 Flooring Type": ["Carpet", "Linoleum", "Vinyl Tile", "Laminate", "Tile", "Hardwood"],
                "3 Flooring Condition": ["Poor", "Average", "Good", "Excellent"],
                "4 Lighting Type": ["None", "Pot Lights", "Ceiling Fixtures", "Lamps Only", "Other"],
                "5 # of Closets": ["1", "2", "3", "4", "5+"],
                "6 Main Closet Size": ["Single", "Double", "Walk-In"],
                "7 # of Windows": ["1", "2", "3", "4", "5+"],
                "8 Condition of Windows": ["Poor", "Average", "Good", "Excellent"],
                "9 Ensuite Bath": ["Yes", "No"]
            ]
            self.selected = [
                "1 Level": "",
                "2 Flooring Type": "",
                "3 Flooring Condition": "",
                "4 Lighting Type": "",
                "5 # of Closets": "",
                "6 Main Closet Size": "",
                "7 # of Windows": "",
                "8 Condition of Windows": "",
                "9 Ensuite Bath": ""
            ]
        } else {
            self.id = id
            self.type = "Bathroom"
            self.options = [
                "1 Level": ["Lower", "Main", "Upper"],
                "2 Full/Half": ["Full", "Half"],
                "3 Flooring Type": ["Carpet","Linoleum", "Vinyl Tile", "Laminate", "Tile", "Hardwood"],
                "4 Flooring Condition": ["Poor", "Average", "Good", "Excellent"],
                "5 Lighting Type": ["None","Pot Lights", "Ceiling Fixtures", "Other"],
                "6 Tub or Shower?": ["No", "Tub Only", "Shower Only", "Tub & Shower"],
                "7 Fan or Ventilation?": ["None", "Fan", "HRV"]
            ]
            self.selected = [
                "1 Level": "",
                "2 Full/Half": "",
                "3 Flooring Type": "",
                "4 Flooring Condition": "",
                "5 Lighting Type": "",
                "6 Tub or Shower?": "",
                "7 Fan or Ventilation?": ""
            ]
        }
    }
}


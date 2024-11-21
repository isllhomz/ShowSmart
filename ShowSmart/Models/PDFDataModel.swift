import SwiftUI

class PDFDataModel: Identifiable {
    var id: Int
    var title: String
    var items: [String:String]
    
    init(id: Int, title: String, items: [String : String]) {
        self.id = id
        self.title = title
        self.items = items
    }
    
    class func prepareInitalData() -> [PDFDataModel] {
        return [
            PDFDataModel(id: 1,
                         title: "Exterior",
                         items: ["1 Driveway Type": "",
                                 "2 Garage": "",
                                 "3 Garage Attachment": "",
                                 "4 Shed Material": "",
                                 "5 Shed Size": "",
                                 "6 Driveway Surface": "",
                                 "7 Fence": "",
                                 "8 Fence Condition": "",
                                 "9 Lot Size & Outdoor Space": "",
                                 "10 Roof Appearance": "",
                                 "11 Foundation Appearance": "",
                                 "12 Deck Condition": ""]),
            PDFDataModel(id: 2,
                         title: "Entryway",
                         items: ["1 Coat Closet" : ""]),
            
            PDFDataModel(id: 3,
                         title: "Kitchen",
                         items: [
                             "1 Countertops": "",
                             "2 Cupboards Age": "",
                             "3 Cupboards Condition": "",
                             "4 Flooring Type": "",
                             "5 Flooring Condition": "",
                             "6 Lighting": "",
                             "7 Lighting Type": "",
                             "8 Seating": "",
                             "9 # of Windows": "",
                             "10 Condition of Windows": "",
                             
                         ]),

            
            PDFDataModel(id: 4,
                         title: "Dining Room",
                         items: ["1 Type": "",
                                 "2 Flooring Type": "",
                                 "3 Flooring Condition": ""]),
            PDFDataModel(id: 5,
                         title: "Living Room",
                         items: [
                                 "1 Flooring Type": "",
                                 "2 Flooring Condition": "",
                                 "3 Lighting": "",
                                 "4 # of Windows": "",
                                 "5 Condition of Windows": ""]),
            
            PDFDataModel(id: 6,
                         title: "Systems",
                         items: ["1 Water": "",
                                 "2 Water Filtration": "",
                                 "3 Sewer": "",
                                 "4 Heating Type": "",
                                 "5 Heating Fuel": "",
                                 "6 Electrical Panel": "",
                                 "7 Electrical Service Size": "",
                                 "8 Drain System": ""
                                ])
        ]
    }
    
    class func prepareBedRoomData(numberOfRooms: Int) {
        Constants.pdfData.removeAll(where: {$0.title.contains("Bedroom Room")})
        for index in 0..<numberOfRooms {
            let bedroom = PDFDataModel(id: Constants.pdfData.count + 1,
                                       title: "Bedroom \(index + 1)",
                                       items: ["1 Level": "",
                                               "2 Flooring Type": "",
                                               "3 Flooring Condition": "",
                                               "4 Lighting": "",
                                               "5 Closet Size": "",
                                               "6 # of Windows": "",
                                               "7 Condition of Windows": "",
                                               "8 Ensuite Bath": ""])
            Constants.pdfData.append(bedroom)
            
        }
    }
    
    class func prepareBathRoomData(numberOfRooms: Int) {
        Constants.pdfData.removeAll(where: {$0.title.contains("Bathroom Room")})
        for index in 0..<numberOfRooms {
            let bedroom = PDFDataModel(id: Constants.pdfData.count + 1,
                                       title: "Bathroom \(index + 1)",
                                       items: ["1 Level": "",
                                               "2 Full/Half": "",
                                               "3 Flooring Type": "",
                                               "4 Flooring Condition": "",
                                               "5 Lighting": "",
                                               "6 Tub or Shower": "",
                                               "7 Fan or Ventilation?": ""])
            Constants.pdfData.append(bedroom)
            
        }
    }
    
}

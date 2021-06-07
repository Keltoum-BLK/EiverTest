//
//  Tool.swift
//  MovieDB
//
//  Created by Kel_Jellysh on 07/06/2021.
//

import Foundation
//MARK: Singleton pattern to use methods
class Tool {
    
    static let shared = Tool()
    
    init(){}
    
    //convert optionnal string to date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    //methods to cast optionnal to String
    func getIntToString(id : Int?)-> (String) {
        //convert a Int? to String
        let ID = id.flatMap { String($0) }
        // unwrapped the optional with a guard let syntaxe
        guard let strData = ID else { return "aie" }
        return strData
    }
    
    func getToString(str: String?)-> (String) {
        //convert a Int? to String
        let str = readLine()
        // unwrapped the optional with a guard let syntaxe
        guard let strImage = str  else { return "" }
        return strImage
    }
    
}

//
//  InterestData.swift
//  Unify
//
//  Created by Melvin Asare on 06/10/2021.
//

import Foundation

class InterestData {
    class func InterestArray() -> [Interest] {
        var interestArray = [Interest]()
        interestArray.append(Interest(name: "Sport"))
        interestArray.append(Interest(name: "Football"))
        interestArray.append(Interest(name: "American Football"))
        interestArray.append(Interest(name: "Basketball"))
        interestArray.append(Interest(name: "Tennis"))
        interestArray.append(Interest(name: "Music"))
        interestArray.append(Interest(name: "Rap"))
        interestArray.append(Interest(name: "Hip-hop"))
        interestArray.append(Interest(name: "R&B"))
        interestArray.append(Interest(name: "Slow jams"))
        interestArray.append(Interest(name: "Games"))
        interestArray.append(Interest(name: "Playstation"))
        interestArray.append(Interest(name: "Xbox"))
        interestArray.append(Interest(name: "Switch"))
        interestArray.append(Interest(name: "Anime"))
        interestArray.append(Interest(name: "Reality TV"))
        return interestArray
    }
}

//
//  Sbor.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 12.09.2020.
//

class Sbor {
    var title:String, howMuch:String, desc:String, toCard:String, author:String
    
    init(title:String, howMuch:String, desc:String, toCard:String, author:String) {
        self.title = title
        self.howMuch = howMuch
        self.desc = desc
        self.toCard = toCard
        self.author = author
    }
}

class RegularSbor: Sbor {
    
}

class CelevoySbor: Sbor {
    var data:String?
}

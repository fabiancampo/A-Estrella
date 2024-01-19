//
//  Nodo.swift
//  A-Estrella
//
//  Created on 18/11/23.
//

import Foundation

class Nodo: Equatable {
    
    var col: Int
    var fil: Int
    var piso: Int
    var esPared: Bool = false
    var coste: Float? = nil
    
    init(col: Int, fil: Int, piso: Int) {
        self.col = col
        self.fil = fil
        self.piso = piso
    }
    
    // necesario para compar nodos
    static func ==(lhs: Nodo, rhs: Nodo) -> Bool {
        lhs.col == rhs.col && lhs.fil == rhs.fil && lhs.piso == rhs.piso
    }
    

    
}

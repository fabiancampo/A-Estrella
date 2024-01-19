//
//  Plano.swift
//  A-Estrella
//
//  Created on 18/11/23.
//

import Foundation

class Plano {
    static let min = 0
    static let max_col = 18
    static let max_fil = 8
    static let max_piso = 9
    
    let plano: [[[Nodo]]]
    
    init() {
        var nodos = [[[Nodo]]]()
        
        for col in Plano.min..<Plano.max_col {
            var filas = [[Nodo]]()
            
            for fil in Plano.min..<Plano.max_fil {
                var pisos = [Nodo]()
                
                for piso in Plano.min..<Plano.max_piso {
                    let nodo = Nodo(col: col, fil: fil, piso: piso)
                    pisos.append(nodo)
                }
                filas.append(pisos)
            }
            nodos.append(filas)
        }
        
        plano = nodos
        
        
        /// Colocamos las paredes, empezando por los edificios.
        /// Si estoy en el nivel 8, el dron esta sobrevolando por lo que ese nivel no es pared
        for col in plano {
            for fil in col {
                for elemento in fil {
                    if (elemento.col == 0 || elemento.col == 1 ||
                        elemento.col == 5 || elemento.col == 6 ||
                        elemento.col == 10 || elemento.col == 11 ||
                        elemento.col == 15 || elemento.col == 16
                    ) && (elemento.fil > 0 && elemento.fil < 7) && (elemento.piso < 8) {
                        elemento.esPared = true
                    }
                }
            }
        }
        
        /// Colocamos las paredes del helipuerto y la parte baja del mapa
        for col in plano {
            for fil in col {
                for elemento in fil {
                    if elemento.fil == 0 {
                        elemento.esPared = true
                    }
                }
            }
        }
        
    }
    

}

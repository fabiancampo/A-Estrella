//
//  main.swift
//  A-Estrella
//
//  Created on 18/11/23.
//
///¿Cuáles son las diferencias con las soluciones propuestas por el algoritmo de Backtrack
///de la implementación en Prolog?
///A estrella es mas eficiente debido al menor numero de estados que se visitan y a que cada estado
///solo se expande una vez.
///En la estrategia de Backtrack de prolog se exploran todas las combiaciones. Es importante también hacer
///uso de una heurística admisible.

import Foundation

// iniciamos el plano
var p = Plano()
var nodoObjetivo = p.plano[9][3][2]

///1. Crear un grafo abiertos de exploracion con el nodo inicial
var abiertos = [Nodo]()
var nodoInicial = p.plano[0][0][8]
nodoInicial.coste = 0
abiertos.append(nodoInicial)

///2. Crear una lista cerrados inicialmente vacia
var cerrados = [Nodo]()

var camino = [Nodo]()

///3. CICLO
while abiertos.isEmpty == false {
   
    // Heuristica con distancia manhattan
    // buscamos el nodo con el menor coste en abiertos
    let nodo = abiertos.min {
        let hPrimerNodo = abs($0.col - nodoObjetivo.col) + abs($0.fil - nodoObjetivo.fil) + abs($0.piso - nodoObjetivo.piso)
        let gPrimerNodo = $0.coste ?? 0.0
        let fPrimerNodo = gPrimerNodo + Float(hPrimerNodo)
        
        let hSegundoNodo = abs($1.col - nodoObjetivo.col) + abs($1.fil - nodoObjetivo.fil) + abs($1.piso - nodoObjetivo.piso)
        let gSegundoNodo = $1.coste ?? 0.0
        let fSegundoNodo = gSegundoNodo + Float(hSegundoNodo)
        
        return fPrimerNodo < fSegundoNodo
    }!
   
    abiertos.remove(at: abiertos.firstIndex(of: nodo)!)
    cerrados.append(nodo)
    
    /// 5. Si n es nodo objetivo, salida con exito
    if nodo == nodoObjetivo {
        construirCamino()
        break
    }
    

    /// 6. Expandir
    expandir(nodo)
}

print("El camino es")
for elemento in camino {
    print("[\(elemento.col), \(elemento.fil), \(elemento.piso)] coste: \(elemento.coste!)")
}

// Reconstruye el camino
func construirCamino() {
    camino.append(nodoObjetivo)
    var nodo = nodoObjetivo
    
    while nodo != nodoInicial {
        for sucesor in sucesores(nodo) {
            
            guard sucesor.coste != nil else { continue }
            
            if sucesor.coste! < nodo.coste! {
                camino.append(sucesor)
                nodo = sucesor
                break
            }
        }
    }
}

func expandir(_ nodo: Nodo) {
    
    ///6. expandir el nodo, generando el conjunto M de sucesores
    let sucesores = sucesores(nodo)
    
    for sucesor in sucesores {
        
        // si el nodo que estamos mirando es pared, pasa al
        // siguiente
        guard sucesor.esPared == false else { continue }
        
        var coste: Float = Coste.mover // coste por defecto
        
        // Si el sucesor es un nodo con piso distinto, significa que es un nodo de otro piso, aplicamos el peso de subir o bajar
        if sucesor.piso != nodo.piso {
            if sucesor.piso > nodo.piso {
                coste = Coste.subir
            } else if sucesor.piso < nodo.piso {
                coste = Coste.bajar
            }
        }
        
        // Si el sucesor es el nodo objetivo, le sumamos al coste de moverse el coste de entregar la medicina
        if sucesor == nodoObjetivo {
            coste += Coste.descargar
        }
        
        // si el coste es nil, es que aun no se habia visitado ese nodo.
        // si el coste desde ese nodo es menor al coste del sucesor, significa que es un camino mejor, asi que cambiamos el coste del sucesor
        if sucesor.coste == nil || nodo.coste! + coste < sucesor.coste! {
            sucesor.coste = nodo.coste! + coste
            
            abiertos.append(sucesor)
        }
    }
}


func sucesores(_ nodo: Nodo) -> [Nodo] {
    var sucesores = [Nodo]()
    
    // nodo izquierda
    if nodo.col > Plano.min {
        sucesores.append(p.plano[nodo.col - 1][nodo.fil][nodo.piso])
    }
    
    // nodo derecho
    if nodo.col < Plano.max_col - 1 {
       
        sucesores.append(p.plano[nodo.col + 1][nodo.fil][nodo.piso])
    }
    
    // nodo abajo
    if nodo.fil > Plano.min {
        sucesores.append(p.plano[nodo.col][nodo.fil - 1][nodo.piso])
    }
    
    // nodo arriba
    if nodo.fil < Plano.max_fil - 1{
        sucesores.append(p.plano[nodo.col][nodo.fil + 1][nodo.piso])
    }
    
    // nodo piso de abajo
    if nodo.piso > Plano.min {
        sucesores.append(p.plano[nodo.col][nodo.fil][nodo.piso - 1])
    }
    
    // nodo piso de arriba
    if nodo.piso < Plano.max_piso - 1 {
        sucesores.append(p.plano[nodo.col][nodo.fil][nodo.piso + 1])
    }
    
    return sucesores
}

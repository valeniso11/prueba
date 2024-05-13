import Swift

// string
var ElPrimerString = "Hello World"
print(ElPrimerString)
//Int
var PrimerInt = 20
print(PrimerInt)
// Suma int
PrimerInt += 2
print(PrimerInt)
// Doble
var NumeroDoble = 2.55555
print(NumeroDoble)
// Float
var primeroFloat:Float = 2.55
print(primeroFloat)
// Bool
var booleano = true 
print(booleano)

// IF and Else 

if booleano == true && PrimerInt != 10{
    print("verdadero y distinto de 10")}
else if booleano == true && PrimerInt == 22{
    print("verdadero y 22")
}
else 
    {print("falso")}

// LISTA ------- Siempre mismo tipo de dato ------------
var PrimeraLista = ["Valentin","Isolabella"]
print(PrimeraLista)
PrimeraLista.append("10")
print(PrimeraLista)

var SegundaLista = [10,12,14]
print(SegundaLista)


// Set ------ No ordenado y tampoco elementos duplicados ------- siempre mismo tipo de dato ---------
var PrimerSet:Set = ["Valentin", "Isolabella","Valentin"]
print(PrimerSet)
print(PrimerSet)

// Mapas 
var PrimerMapa = ["Valentin":19, "Pepe":10, "Nicolas": 25]
print(PrimerMapa)
print(PrimerMapa["Valentin"])


// Optional ---- valor que puede ser nulo ----- Se usa con ? int? string?
var PrimerOptional : String? = nil 
print(PrimerOptional)
if PrimerOptional != nil{
    print(PrimerOptional!) // sabiendo q no es null
}
else {
    print("Opcional es nulo")
}

// Desempaquetado de nulo ---- ver q no sea nulo y hacer una opcion 

if let edad = PrimerMapa["Valentin"]
{
    print(edad)
}
else 
    {
        print("No existe el nombre")
    }

// Otro tipo de control de nulo 

print(PrimerMapa["Valenti"] ?? " No existe el nombre ")

// Bucles 
    // for 
for i in PrimerMapa{
    print(i)
}

for i in PrimeraLista {
    print(i)
}

    // while 

var index = 0 
while index < PrimeraLista.count{
    print([PrimeraLista[index]])
    index += 1
}

// Funciones 

func PrimerFuncion() {
   print("hola mundilo")
}

// rango 
(0...50).forEach { _ in PrimerFuncion()}


// Clases ---- Datas -----

class Persona {
    var nombre: String?
    var dni: Int?
}

var Valentin = Persona()
Valentin.nombre = "valentin"
Valentin.dni = 19

print(Valentin.dni ?? "no existe el nombre")


















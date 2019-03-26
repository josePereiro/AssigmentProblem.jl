module AssigmentProblem

using JuMP;
using GLPK;

"""
Problema de asignación. (Vanderbei LP, pg. 227). Dado un conjunto S de m personas, un conjunto D de m tareas, y para cada iS,jD un costo cij de asignar la tarea j a la persona i, el problema de asignación consiste en asignar a cada persona una y solo una tarea, de manera tal que se minimize el costo total. Formule este problema como un problema de programación lineal con enteros. Escriba una función para resolverlo, que tome como entrada una matriz de costos cij arbitraria.
"""

include("BruteForce.jl")
include("LinearProgramming.jl")
include("Common.jl");

end # module
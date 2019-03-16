
"""
Problema de asignación. (Vanderbei LP, pg. 227). Dado un conjunto S de m personas, un conjunto D de m tareas, y para cada iS,jD un costo cij de asignar la tarea j a la persona i, el problema de asignación consiste en asignar a cada persona una y solo una tarea, de manera tal que se minimize el costo total. Formule este problema como un problema de programación lineal con enteros. Escriba una función para resolverlo, que tome como entrada una matriz de costos cij arbitraria.

"""


export brute_force;
function brute_force(costTable::Matrix{Real})
	
	
	
	end # brute_force

function getsub(m::Matrix, rtd::Int, ctd::Int)
    
    sub = Matrix{eltype(m)}(undef,size(m) .- 1);
    
    for d1 in 1:size(m,1)
        for d2 in 1:size(m,2)
            if d1 < rtd
                 if d2 < ctd
                   sub[d1,d2] = m[d1,d2]
                elseif d2 > ctd
                    sub[d1,d2 - 1] = m[d1,d2]
                end
            elseif d1 > rtd
                if d2 < ctd
                   sub[d1 - 1,d2] = m[d1,d2]
                elseif d2 > ctd
                    sub[d1 - 1,d2 - 1] = m[d1,d2]
                end
            end
        end
    end
    
    return sub
end

function copyrow(m::Matrix, dr::Int)
    row = Array{eltype(m)}(undef,size(m,2));
    for ei in 1:size(m,2) row[ei] = m[dr,ei] end 
    row
end


rowsum(m::Matrix, r::Int) = sum(m, dims = 2)[r] 

export get_combinations

function get_combinations(m)
   
   #Stop statement
    if size(m,1) == 1
        return toaa(m);
    end
    
    #Recursion
    combs = [[]];
    pop!(combs);
    for row in 1:size(m,2)
        subcombs = get_combinations(getsub(m,row,1));
        pushfirst_toall!(subcombs,m[row,1])
        push_all!(combs,subcombs);
    end
    return combs;
    
end

function push_all!(to::AbstractArray, from::AbstractArray)
    for row in 1:length(from) 
       push!(to,from[row]) 
    end
end

function pushfirst_toall!(aa, v)
    for row in 1:length(aa) 
       pushfirst!(aa[row],v) 
    end
end

function toaa(m)
    aa = [[zero(eltype(m))]];
    pop!(aa);
    push!(aa,copyrow(m,1));
    aa
end

"""
Problema de asignación. (Vanderbei LP, pg. 227). Dado un conjunto S de m personas, un conjunto D de m tareas, y para cada iS,jD un costo cij de asignar la tarea j a la persona i, el problema de asignación consiste en asignar a cada persona una y solo una tarea, de manera tal que se minimize el costo total. Formule este problema como un problema de programación lineal con enteros. Escriba una función para resolverlo, que tome como entrada una matriz de costos cij arbitraria.

"""

export solve_with_brute_force;
function solve_with_brute_force(m::Matrix{T}):: Vector{Vector{T}} where {T<:Number}
    checkmatrix(m);
    return reverse.(min_reversed_combs(m));
end # brute_force

export get_combinations;
"""
    Returns a Vector{Vector{T}} with all the posible combinations of
     the elements in the matrix m. Only square matrices of Numbers are allowed.
"""
function get_combinations(m::Matrix{T}):: Vector{Vector{T}} where {T<:Number}
    checkmatrix(m);
    return reverse.(possible_reversed_combinatoins(m));
end

function min_reversed_combs(m::Matrix{T}):: Vector{Vector{T}} where {T<:Number}
    
    #Store combinations
    local coms = Vector{Vector{T}}()
    
    #Stop statement
    if size(m) == (1,1)
        push!(coms,[m[1,1]]);
        return coms;
    end
    
    #Recursion block
    rowsCount::Int = size(m,1)
    local subComs::Vector{Vector{T}}
    for r in 1:rowsCount
        
        #Recursion call
        subComs = min_reversed_combs(getsub(m,r,1));
        
        #Adding 
        srowsCount = size(subComs,1);
        for sr in 1:srowsCount
            
            #Adding head
            push!(subComs[sr],m[r][1]);
            
            #Adding subCom
            push!(coms,subComs[sr]);
        end
    end
    
    return get_min_coms(coms);
end

function possible_reversed_combinatoins(m::Matrix{T}):: Vector{Vector{T}} where {T<:Number}
    
    #Store combinations
    local coms = Vector{Vector{T}}()
    
    #Stop statement
    if size(m) == (1,1)
        push!(coms,[m[1,1]]);
        return coms;
    end
    
    #Recursion block
    rowsCount::Int = size(m,1)
    local subComs::Vector{Vector{T}}
    for r in 1:rowsCount
        
        #Recursion call
        subComs = possible_reversed_combinatoins(getsub(m,r,1));
        
        #Adding 
        srowsCount = size(subComs,1);
        for sr in 1:srowsCount
            
            #Adding head
            push!(subComs[sr],m[r][1]);
            
            #Adding subCom
            push!(coms,subComs[sr]);
        end
    end
    
    return coms;
end

function get_min_coms(coms::Vector{Vector{T}}):: typeof(coms) where {T<:Number}
    
    #min combinations
    mincoms = Vector{Vector{T}}();
    
    minsum = typemax(T);
    comsum = zero(T);
    for com in coms
        comsum = sum(com);
        if comsum < minsum
            mincoms = Vector{Vector{T}}();
            minsum = comsum;
        end
        
        if comsum == minsum
           push!(mincoms,com); 
        end
    end
    
    return mincoms;
end


function getsub(m::Matrix{T}, rtd::Int, ctd::Int)::Matrix{T} where {T}
    
    sub = Matrix{T}(undef,size(m) .- 1);
    rowsCount = size(m,1);
    colCount = size(m,2);
    
    for d1 in 1:rowsCount
        for d2 in 1:colCount
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

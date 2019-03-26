
"""
Problema de asignación. (Vanderbei LP, pg. 227). Dado un conjunto S de m personas, un conjunto D de m tareas, y para cada iS,jD un costo cij de asignar la tarea j a la persona i, el problema de asignación consiste en asignar a cada persona una y solo una tarea, de manera tal que se minimize el costo total. Formule este problema como un problema de programación lineal con enteros. Escriba una función para resolverlo, que tome como entrada una matriz de costos cij arbitraria.

"""

export solve_with_linear_programming;
function solve_with_linear_programming(m::Matrix{T}) where {T<:Number}

	#Checking matrix
	checkmatrix(m);
	ml = size(m,1);
	
	#Create model
	local model = Model(with_optimizer(GLPK.Optimizer));

	#Variables
	@variable(model, x[1:ml,1:ml], Bin);

	#Objective
	@objective(model, Min, sum(m[i,j] * x[i,j] for i in 1:ml, j in 1:ml));

	#Constrains
	@constraint(model, [i=1:ml], sum(x[i,j] for j in 1:ml) <= 1);
	@constraint(model, [j=1:ml], sum(x[i,j] for i in 1:ml) >= 1);

	#Optimize
	optimize!(model);

	return pick_results(value.(x),m);
end

function pick_results(bm,m)
	r = Vector{eltype(m)}();
	zer0 = zero(eltype(m));
	for i in 1:length(bm)
		bm[i] != zer0 && push!(r,m[i]);
	end
	return push!(Vector{typeof(r)}(),r);
end
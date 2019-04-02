using AssigmentProblem
using Test

#test matrix
m = [10  2 10 10 10 10;
	  1 10 10 10 10 10;
	 10 10  3 10 10 10;
	 10 10 10 10  5 10;
	 10 10 10  4 10 10;
	 10 10 10 10 10  6];

#small matrix
sm = rand(Int,2,2);

#optimal combination
oc = [1,2,3,4,5,6];

@testset "AssigmentProblem.jl" begin
    println("Test Matrix");
    display(m);
    println();
    print("Possible combinations: ")
    println(factorial(6));
    println("Optimal Combination");
    println(oc);
    println();
    println("Brute Force Solution (test all the posible combinations)");	#Brute force
    solve_with_brute_force(sm);		#Precompiling
    @time bfs = solve_with_brute_force(m)[1]; 	#Solve
    @test bfs == oc 	#Test with optimal
   	println(bfs);   #Print
    println();	
    println("Linear Programming Solution");		#Lineal programming
    solve_with_lineal_programming(sm); 		#precompiling
    @time lps = solve_with_lineal_programming(m)[1];	#solve
    @test lps == oc		#Test with optimal
    println(lps);
    println();


end


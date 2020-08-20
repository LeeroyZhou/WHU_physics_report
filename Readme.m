%% Description
% 1. A MATLAB code for  NSGA-II algorithm (Kalyanmoy Deb, Amrit Pratap, Sameer Agarwal, and T. Meyarivan, " A Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II", 
%    IEEE TRANSACTIONS ON EVOLUTIONARY COMPUTATION, VOL. 6, No. 2, APRIL 2002.) is developed for 9 unconstrained and  5 constrained test problems in this file.
% 2. This code doesn't reserve to claim any rights. 
% 3. Real coded NSGA II with SBX crossover with boundary constraint, polynomial mutation with boundary constraint and constraint handling. 
% 4. Main program of NSGA II which is "Main_NSGA2.m", requires only one input, which is test problem
%    index, 'p' for execution. NSGA II code is tested and verified for 14, two-objectives test problems.
% 5. Anybody can use this code for their application, by developing  their own file to evaluate objective functions and constaints if any as in testcase.m file. 
% 6. For any new test problem (application), the following modifications are sufficient.They are listed down.
%% Problem Dependent variables
% pop_size          % Population size
% no_runs           % Number of runs
% gen_max           % MAx number of generations - stopping criteria
% V                 % Number of design variables
% xl                % lower bound vector
% xu                % upper bound vectorfor 
% etac              % distribution index for crossover
% pm                % Mutation Probability
% etam              % distribution index for mutation / mutation constant
% M		    % Number of objectives

%% Test problem index - variable 'p' ( For More details, see testcase.m')
% 1  - Test case problem 1
% 2  - ZDT1
% 3  - KUR
% 4  - SCH
% 5  - ZDT2
% 6  - Test case problem 2
% 7  - ZDT3
% 8  - ZDT4
% 9  - ZDT6
% 10 - BNH
% 11 - SRN
% 12 - TNK
% 13 - OSY
% 14 - CONSTR

%% Reference:
Kalyanmoy Deb, Amrit Pratap, Sameer Agarwal, and T. Meyarivan, " A Fast and Elitist Multiobjective Genetic Algorithm: NSGA-II", 
%IEEE TRANSACTIONS ON EVOLUTIONARY COMPUTATION, VOL. 6, No. 2, APRIL 2002.
% 

clear all
clc
global V M xl xu etac etam p pop_size pm

%% Description

% 1. This is the main program of NSGA II. It requires only one input, which is test problem
%    index, 'p'. NSGA II code is tested and verified for 14 test problems.
% 2. This code defines population size in 'pop_size', number of design
%    variables in 'V', number of runs in 'no_runs', maximum number of 
%    generations in 'gen_max', current generation in 'gen_count' and number of objectives
%    in 'M'.
% 3. 'xl' and 'xu' are the lower and upper bounds of the design variables.
% 4. Final optimal Pareto soutions are in the variable 'pareto_rank1', with design
%    variables in the coumns (1:V), objectives in the columns (V+1 to V+M),
%    constraint violation in the column (V+M+1), Rank in (V+M+2), Distance in (V+M+3).
%% code starts
M=2;
p=input('Test problem index  :');
pop_size=200;           % Population size
no_runs=1;              % Number of runs
gen_max=300;            % MAx number of generations - stopping criteria
fname='test_case';      % Objective function and constraint evaluation

if (p==13)  % OSY
%if p==13
    pop_size=100; 
    no_runs=10;
end;                   
if (p==2 | p==5 | p==7), gen_max=1000; end;

if p<=9     % Unconstrained test functions
tV=[2;30;3;1;30;4;30;10;10];
V=tV(p);
txl=[-5*ones(1,V);zeros(1,V);-5*ones(1,V);-1000*ones(1,V);zeros(1,V);-1/sqrt(V)*ones(1,V);zeros(1,V); 0 -5*ones(1,V-1);zeros(1,V)]; 
txu=[10*ones(1,V); ones(1,V);5*ones(1,V);1000*ones(1,V);ones(1,V);1/sqrt(V) *ones(1,V);ones(1,V);1 5*ones(1,V-1);ones(1,V)];
xl=(txl(p,1:V));            % lower bound vector
xu=(txu(p,1:V));            % upper bound vectorfor 
etac = 20;                  % distribution index for crossover
etam = 20;                  % distribution index for mutation / mutation constant
else         % Constrained test functions
p1=p-9;
tV=[2;2;2;6;2;2];
V=tV(p1);
txl=[0 0 0 0 0 0;-20 -20 0 0 0 0;0 0 0 0 0 0;0 0 1 0 1 0;0.1 0 0 0 0 0;0 0 0 0 0 0]; 
txu=[5 3 0 0 0 0;20 20 0 0 0 0;pi pi 0 0 0 0;10 10 5 6 5 10;1 5 0 0 0 0;10 10 0 0 0 0];
xl=(txl(p1,1:V));           % lower bound vector
xu=(txu(p1,1:V));           % upper bound vectorfor i=1:NN
etac = 20;                  % distribution index for crossover
etam = 100;                 % distribution index for mutation / mutation constant
end
pm=1/V;                     % Mutation Probability

Q=[];
for run = 1:no_runs
    
%% Initial population 
xl_temp=repmat(xl, pop_size,1);
xu_temp=repmat(xu, pop_size,1);
x = xl_temp+((xu_temp-xl_temp).*rand(pop_size,V));

%% Evaluate objective function
for i =1:pop_size
    i
    x(i,:)
[ff(i,:) err(i,:)] =feval(fname, x(i,:));           % Objective function evaulation 
end
error_norm=normalisation(err);                      % Normalisation of the constraint violation
population_init=[x ff error_norm];
[population front]=NDS_CD_cons(population_init);    % Non domination Sorting on initial population
    
%% Generation Starts
for gen_count=1:gen_max
    gen_count/gen_max
% selection (Parent Pt of 'N' pop size)
parent_selected=tour_selection(population);                     % 10 Tournament selection
%% Reproduction (Offspring Qt of 'N' pop size)
child_offspring  = genetic_operator(parent_selected(:,1:V));    % SBX crossover and polynomial mutation

for ii = 1:pop_size
    ii
[fff(ii,:) err(ii,:)]=feval(fname, child_offspring(ii,:));      % objective function evaluation for offspring
end

error_norm=normalisation(err);                                  
child_offspring=[child_offspring fff error_norm];

%% INtermediate population (Rt= Pt U Qt of 2N size)
population_inter=[population(:,1:V+M+1) ; child_offspring(:,1:V+M+1)];
[population_inter_sorted front]=NDS_CD_cons(population_inter);              % Non domination Sorting on offspring
%% Replacement - N
new_pop=replacement(population_inter_sorted, front);
population=new_pop;
end
new_pop=sortrows(new_pop,V+1);
paretoset(run).trial=new_pop(:,1:V+M+1);
Q = [Q; paretoset(run).trial];                      % Combining Pareto solutions obtained in each run
end

%% Result and Pareto plot
if run==1
plot(new_pop(:,V+1),new_pop(:,V+2),'*')
else                                        
[pareto_filter front]=NDS_CD_cons(Q);               % Applying non domination sorting on the combined Pareto solution set
rank1_index=find(pareto_filter(:,V+M+2)==1);        % Filtering the best solutions of rank 1 Pareto
pareto_rank1=pareto_filter(rank1_index,1:V+M)
plot(pareto_rank1(:,V+1),pareto_rank1(:,V+2),'*')   % Final Pareto plot
end
xlabel('objective function 1')
ylabel('objective function 2')
if p==1
    title(' 1 - Test case 1')
elseif p==2
    title(' 2  - ZDT1')
elseif p==3 
    title(' 3  - KUR')
elseif p==4
    title(' 4  - SCH')
elseif p==5
    title(' 5  - ZDT2')
elseif p==6
    title(' 6  - Test case 3')
elseif p==7
    title(' 7  - ZDT3')
elseif p==8
    title(' 8  - ZDT4')
elseif p==9
    title(' 9  - ZDT6')
elseif p==10
    title(' 10 - BNH')
elseif p==11
    title(' 11 - SRN')
elseif p==12
    title(' 12 - TNK')
elseif p==13
    title(' 13 - OSY')
elseif p==14
    title(' 14 - CONSTR')
end
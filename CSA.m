function [ R0,R1,C1,R2,C2,C0,G,Fitness_G ] = CSA( V )
%% ----------------------------------------
% ----------- Scenario setup ------------
%----------------------------------------
load('Vmeasure.mat');
global Vbat0  
global PULSE
%PULSE =[0.84 1.39 2.1 4.2 8.4 12.6];(23&10'C)
%PULSE =[1.34 2.01 4.019 8.038 12.057];(45'C)
     Vbat0 = V(1:756012);
     PULSE =[0.84 1.39 2.1 4.2 8.4 12.6];
%% --------------------------------------
% ----------- CSA Parameters ------------
%----------------------------------------

NE              =  6;    % number of elements
N               =  100;  % number of crows

iter            =  100;   % number of iterations
iterCount       =  0;     % counter of iterations
AP              =  0.2;
fl1             =  1;
fl2             =  2;
w_max           =  1;
w_min           =  0.1;
APMAX           =  0.3;
APMIN           =  0.05;
flMAX           =  2;
flMIN           =  1;

%  -------------------------------------------
%  ------------ Boundary Settings ------------
%  -------------------------------------------
X_Max           =  [0.1 0.1 1000 0.1 5000 50000];     % [ max search range ]
X_Min           =  [10^-6 0 0 0 0 0];     % [ min search range]

X               =  zeros( N , NE );
V               =  zeros( N , NE );
M               =  zeros( N , NE );
Q               =  zeros( N , NE );
G               =  zeros( iter , NE );
Fitness         =  zeros( N , 1 );
Fitness_M       =  zeros( N , 1 );
Fitness_G       =  zeros( iter , 1 );
w_max           =  1;
w_min	        =  0.1;

%-----------------------------------------
% ------------ Initialization-------------
%-----------------------------------------
     for i = 1 : N 
         for j = 1 : NE
             X(i,j) =  (X_Min(1,j) + (X_Max(1,j)-X_Min(1,j))*rand());
             M(i,j) =  (X_Min(1,j) + (X_Max(1,j)-X_Min(1,j))*rand());
             
         end
     end
     for i = 1 : N  
       Fitness_M(i,1) = Evaluation ( M(i,:) );
     end
 while ( iterCount < iter )
     AP=APMAX-(APMAX-APMIN)*(iterCount/iter);

%-------------------------------------
% ------------ Evaluation ------------
%-------------------------------------
 
   for i = 1 : N  
       Fitness(i,1) = Evaluation ( X(i,:) );
   end

% ----------------------------------------------------------------------
%               Update X and M location & Fitness value
% ----------------------------------------------------------------------

    for j = 1 : N                               % update pBest
           if Fitness_M(j,1) >= Fitness(j,1) 
                  Fitness_M(j,1) = Fitness(j,1);
                  
                  Q(j,:) = X(j,:);
                  X(j,:) = M(j,:);
                  M(j,:) = Q(j,:);
                  
                  
           end
    end
    [value, location] = min(Fitness_M);
    Fitness_G(iterCount+1,1) = value;
    G(iterCount+1,:) = M(location,:);
     

% ---------------------------------------------------
%               Update locations
% ---------------------------------------------------
    
    
  
        for i = 1 : N
            r2=rand();
            if  r2>=AP;
                r1=rand();
                r3=rand();
                X(i,:) = X(i,:)+r1*fl1*(M(i,:)-X(i,:))+r3*fl2*(G(i,:)-X(i,:));
     

                for j = 1 : NE
                    if X(i,j) > X_Max(1,j)
                        X(i,j) = X_Max(1,j);
                    end
                    if X(i,j) < X_Min(1,j)
                        X(i,j) = X_Min(1,j);
                    end
                end
            else
                    for j = 1 : NE
                        X(i,j) =  (X_Min(1,j) + (X_Max(1,j)-X_Min(1,j))*rand());
                    end

            end
        end




% ---------------------------------------------------
%               Next Iteration
% ---------------------------------------------------
disp(['iteration: ',num2str(iterCount+1)]);
disp(['best value ',num2str(Fitness_G(iterCount+1,1))]);
disp(['best setting',num2str(G(iterCount+1,:))]);

iterCount = iterCount + 1;


    
 end
%%
figure;
plot(Fitness_G,'--.r');
hold on ;
xlabel('generation');
ylabel('fitness');
title('convergence history');
axis([0,100,1.5*10^(-3),10^(-2)]); 
grid

%%
R0 = G(100,1);
R1 = G(100,2);
C1 = G(100,3);
R2 = G(100,4);
C2 = G(100,5);
C0 = G(100,6);
end

     
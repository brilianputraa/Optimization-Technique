% Parameters Initialization
iter = input('Iteration Number : ');
in = 3; % Numbers of variable
xup = 10; % Upper threshold of x
xlo = 1; % Lower threshold of x
N = 10; % Domain divider
h = zeros(in,1); % Create zeros matrix of h
as = 20; % Ant Numbers
e = 10e-5; % Error Threshold
eps = 0.2; % Constant for pheromone updating
xopt = zeros(1,in); % Initialize the Row vectors consist of zeros for future storing of x optimal value
tauo = 1; % tau 0
fib = 1000; % temp value for iteration best fitness function
rom = 0.1; % Lower bound of ro
a = 10; % Constant for Global Updating
b = 250; % Constant for Global Updating
Q = 10;
T = 20;
for it = 1 : iter
        fibn = []; % Creating Temp Matrix for saving fitness function of iteration
        count = 0; % For counting S
        form = 'Iterasi ke %d';
        sprintf(form,it)
        % Step 1
            S = 0;
            for i =  1 : in
                h(i) = (xup - xlo)/N; % Get the length of subdomain
            end
            % Step 2
            tau = ones(N, 3); % Initialize pheromone to be constant in this case we choose one
            % Step 3
            for i = 1 : in
                if (max(h(i)) < e) % If the maximum value of h lower than threshold error then iteration stop
                    xopt(i) = (xup + xlo)/2; % The optimal x value
                    break;
                else
                    % Step 4
                    S = 0; % Counter for internal circulation
                    % Step 5
                    while ( S < T )
                        for m = 1 : as
                            q0 = 0.7; % Constant that we determine in range of 0 <= qo <= 1
                            if ( rand(1) <= q0 ) 
                                [jmax,res] = max(tau(:,i)); % Find the max value of j row
                                [j,~] = find(tau(:,i)==jmax)
                                j=j(1);
                            else
                                pij = tau(:,i)/sum(tau(:,i)); % The probability distribution to find j 
                                [jmax,res] = max(pij); % Finding the row that has largest probability
                                [j,~] = find(pij(:)==jmax);
                                j=j(1);
                            end
                            % Step 6
                            % Updating the local pheromone
                            tau(j,i) = (1-eps)*tau(j,i) + eps*tauo
                            tauo = min(tau(:,i)); % Updating tauo
                            % Step 7
                            % Updating the lower threshold of objective domain X for each ant
                            for i =  1 : in
                                xopt(i) = xlo + ((2*j - 1)*h(i))/2; % Get the length of subdomain
                            end                
                        end
                        % Step 8
                        % If all ants complete the solution
                        % Step 9
                        % Calculating Fitness Function
                        ff = 10 - sum((xopt - 5*ones(size(xopt))).^2); % Sphere Function
                        fibn = [fibn ff];
                        [fibmin,~] = min(fibn); % Finding the elements that has lowest fitness function 
                        [~,fibmin] = find(fibn==fibmin);
                        fibm=fibmin(1);
                        fibmin=fibn(fibm); % Got the iteration best
                        % Step 10
                        % Pheromone Global Update
                        del(j,i) = 0;
                        temp = tau(j,i);
                        if (fibmin <= fib) % Necessary Condition for Updating Global value of Pheromone
                            fib = fibmin % Assign the updated fitness value
                            del(j,i) = Q/(as + fib);
                            ins = 1 - (log(it)/log(it+b));
                            ro = max(ins,rom); % Find the evaporation rate 
                            temp = (1 - ro) * tau(j,i) + ro * del (j,i); % Got updated tau
                        end
                        % Step 11
                        if ( tau(j,i) < 0 ) % 0 is lower bound of tau
                             tau(j,i) = 0;
                        elseif ( tau(j,i) > 1 ) % 1 is upper bound of tau
                             tau(j,i) = 1;
                        else
                             tau(j,i) = temp;
                        end
                        % Step 12
                        S = S + 1;
                        if (S >= T) % Back to Step 1
                             [mi,~] = max(tau(j,i));
                             [mi,~] = find(tau(j,i)==mi);
                             mi = mi(1); % Got the arg max of tau
                             delta = 2;
                             xlo = max(xlo, xlo + (mi - delta)* h(i));
                             xup = min(xup, xlo + (mi + delta)* h(i));
                        end
                    end
                end
            end
end
        
    


    
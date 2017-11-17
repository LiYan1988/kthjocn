function [x] = trafficProfile(f, Nele, Tele, lbf, a1, a2)
% Assume 1, 10, 100, 200 Gbps are mice flows, 400 and 1000 are elephants
% Nele is the percentage of elephant numbers
% Tele is the percentage of elephant throughput
% f is the objective, maximize certain type of traffic
% lbf is a number, each traffic type has at least this percentage
    r = (1-Nele)/Nele;
    t = Tele/(1-Tele);
    Aeq = [[1, 1, 1, -r, -r];...
        [t*[50, 100, 200], -400, -1000];...
        ones(1, 5);...
        [0, -a2, 1, 0, 0];...
        [0, 0, 0, -1, a1]];
    beq = [zeros(2, 1); 1; 0; 0];
    lb = lbf*ones(5, 1);
    ub = ones(5, 1);
    options = optimoptions('linprog', 'Algorithm', 'interior-point-legacy');
    [x, fval, exitflag] = linprog(f,[],[],Aeq,beq,lb,ub,options);
    disp(x)
    
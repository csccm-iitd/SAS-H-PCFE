function [mean_obj,sd_obj] = stats_eval_obj(x)

len_vec = [360 360 360 360 360 360 509.12 509.12 509.12 509.12];

mean_A = x;
cov_A = 0.05;
sd_A = cov_A*mean_A;

n_rand = 10;
n_simu = 5000;
rand('seed',50)
A_sim_gen = rand(n_simu,n_rand);

lb_A = mean_A - sqrt(3)*sd_A;
ub_A = mean_A + sqrt(3)*sd_A;

for i = 1:n_rand
    A_simu_range(:,i) = mean_A(i) + sd_A(i)*A_sim_gen(:,i);
end

rho_steel = 0.1;                                                    % in lb/cu.in

for i = 1:n_simu
    
volm_sim(i) = sum(A_simu_range(i,:).*len_vec);

end

wt_sim = rho_steel*volm_sim;                               % total weight


mean_obj = mean(wt_sim);
sd_obj = std(wt_sim);


end
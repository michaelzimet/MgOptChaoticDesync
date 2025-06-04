
%set M=1.5
opt_bvp_chaotic_RHH;
close all
trace1 = thsoln1;
trace2 = thsoln2;
tracetime = tsoln;

M_range = [0.0:0.25:2.5];
in = zeros(length(M_range), length(uopt));
lyap_fit = zeros(1,length(M_range));
power = zeros(1,length(M_range));
lyap_calc = zeros(1,length(M_range));
u2_arr = zeros(1,length(M_range));
std_arr = zeros(1,length(M_range));

%for M in M_range, set M in file below and index j
j=11;
opt_bvp_chaotic_RHH_mult_input;
close all
in(j, :) = uopt;
phase_diff = theta2_soln - theta1_soln;
p = polyfit(tsoln(1:floor(length(tsoln)/2)),log(phase_diff(1:floor(length(tsoln)/2))),1);
lyap_fit(j) = p(1);
power(j) = sum(uopt.^2 * 0.01);
lyap_calc(j) = sum(Zp_RHH(theta).*uopt*0.01)/(T);

EBC_mult;
close all
u2_arr(j)=mean_u_squared;
std_arr(j)=std_u_squared;

%values of umax to plot
if  j==3
    phase_diffC = phase_diff;
    tsolnC=tsoln;
elseif j==7
    phase_diffB = phase_diff;
    tsolnB=tsoln;
elseif j==11
    phase_diffA = phase_diff;
    tsolnA=tsoln;
end

figure(5)
subplot(3,2,1)
plot(t, in(11,:), 'b', t, in(7,:), 'r', t, in(3,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylabel('$u^*(t)$', 'Interpreter','latex')
ylim([-2.5,2.5])

subplot(3,2,2)
plot(tracetime,trace1,'b',tracetime,trace2,'r')
xlabel('$t$', 'Interpreter','latex')
ylabel('$\theta$', 'Interpreter','latex')

subplot(3,2,3)
plot(tsolnA, phase_diffA, 'b', tsolnB, phase_diffB, 'r', tsolnC, phase_diffC, 'g')
xlabel('$t$', 'Interpreter','latex')
ylabel('$\phi$', 'Interpreter','latex')

subplot(3,2,4)
plot(tsolnA, log(phase_diffA), 'b', tsolnB, log(phase_diffB), 'r', tsolnC, log(phase_diffC), 'g')
xlabel('$t$', 'Interpreter','latex')
ylabel('$\log(\phi)$', 'Interpreter','latex')

subplot(3, 2, 5)
scatter(M_range, lyap_calc, 'b', 'filled')
hold on
scatter(M_range, lyap_fit, 'r','filled' )
xlabel('$u_{max}$', 'Interpreter','latex')
ylabel('$\Lambda$', 'Interpreter','latex')

subplot(3,2,6)
scatter(M_range, power, 'b', 'filled')
xlabel('$u_{max}$', 'Interpreter','latex')
ylabel('$\int u^*(t)^2 \, dt$', 'Interpreter','latex')

AddLetters2Plots(figure(5), {'A', 'B','C','D', 'E', 'F'},  'HShift', -0.08, 'VShift', -0.015)

saveas(figure(5), '../Optimal Control Figs/Fig5.eps', 'epsc')

figure(10)
subplot(2, 1, 1)
scatter(M_range, u2_arr)
hold on
errorbar(M_range, u2_arr, std_arr, 'ko-', 'MarkerSize', 8, 'LineStyle', 'None');

xlabel('$u_{max}$', 'Interpreter','latex')
ylabel('$\left\langle \int u(t)^2 \, dt \right\rangle$', 'Interpreter','latex')

saveas(figure(10), '../Optimal Control Figs/Fig10.eps', 'epsc')
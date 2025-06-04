%check large Zd

%set M=0.35
opt_bvp_chaotic_snip;
close all
trace1 = thsoln1;
trace2 = thsoln2;
tracetime = tsoln;

M_range = [0:0.05:0.55];
in = zeros(length(M_range), length(uopt));
lyap_fit = zeros(1,length(M_range));
power = zeros(1,length(M_range));
lyap_calc = zeros(1,length(M_range));


%for M in M_range
j=12;
opt_bvp_chaotic_snip_mult_input;
close all
in(j, :) = uopt;
phase_diff = theta2_soln - theta1_soln;
p = polyfit(tsoln(1:floor(length(tsoln)/2)),log(phase_diff(1:floor(length(tsoln)/2))),1);
lyap_fit(j) = p(1);
power(j) = sum(uopt.^2 * 0.01);
lyap_calc(j) = sum(Zp_snip(theta).*uopt*0.01)/(2*pi);

if  j==5
    phase_diffC = phase_diff;
    tsolnC=tsoln;
elseif j==8
    phase_diffB = phase_diff;
    tsolnB=tsoln;
elseif j==12
    phase_diffA = phase_diff;
    tsolnA=tsoln;
end

figure(3)
subplot(3,2,1)
plot(t, in(12,:), 'b', t, in(8,:), 'r', t, in(5,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylabel('$u^*(t)$', 'Interpreter','latex')
ylim([-0.55 0.55])

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
ylim([0.0 0.8])

AddLetters2Plots(figure(3), {'A', 'B','C','D', 'E', 'F'},  'HShift', -0.08, 'VShift', -0.015)

saveas(figure(3), '../Optimal Control Figs/Fig3.eps', 'epsc')

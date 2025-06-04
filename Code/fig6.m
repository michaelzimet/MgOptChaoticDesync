M_range = [0.2:0.15:0.5];
%M_range_HH = [0.2:0.1:0.4];
%M_range_RHH = [0.5:1.0:2.5];

%
opt_bvp_chaotic_sin;
close all
in1 = zeros(length(M_range), length(uopt));
in2 = zeros(length(M_range), length(uopt));
in3 = zeros(length(M_range), length(uopt));
in4 = zeros(length(M_range), length(uopt));
ts=t;

opt_bvp_chaotic_HH;
close all
in5 = zeros(length(M_range), length(uopt));
in6 = zeros(length(M_range), length(uopt));
t2=t;

opt_bvp_chaotic_RHH;
close all
in7 = zeros(length(M_range), length(uopt));
in8 = zeros(length(M_range), length(uopt));
t3=t;

%set B = 5
%for M in M_range
j=3;
opt_bvp_chaotic_sin;
close all
in1(j, :) = uopt;

%set B = 20
%for M in M_range
j=3;
opt_bvp_chaotic_sin;
close all
in2(j, :) = uopt;

%set B = 5
%for M in M_range
j=3;
opt_bvp_chaotic_snip;
close all
in3(j, :) = uopt;

%set B = 20
%for M in M_range
j=3;
opt_bvp_chaotic_snip;
close all
in4(j, :) = uopt;

%set B = 5
%for M in M_range_HH
j=3;
opt_bvp_chaotic_HH;
close all
in5(j, :) = uopt;

%set B = 20
%for M in M_range_HH
j=3;
opt_bvp_chaotic_HH;
close all
in6(j, :) = uopt;

%set B = 20
%for M in M_range_RHH
j=3;
opt_bvp_chaotic_RHH;
close all
in7(j, :) = uopt;

%set B = 40
%for M in M_range_RHH
j=3;
opt_bvp_chaotic_RHH;
close all
in8(j, :) = uopt;


figure(6)
subplot(4,2,1)
plot(ts, in1(3,:), 'b', ts, in1(2,:), 'r', ts, in1(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.55 0.55])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,2)
plot(ts, in2(3,:), 'b', ts, in2(2,:), 'r', ts, in2(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.55 0.55])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,3)
plot(ts, in3(3,:), 'b', ts, in3(2,:), 'r', ts, in3(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.55 0.55])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,4)
plot(ts, in4(3,:), 'b', ts, in4(2,:), 'r', ts, in4(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.55 0.55])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,5)
plot(t2, in5(3,:), 'b', t2, in5(2,:), 'r', t2, in5(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.45 0.45])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,6)
plot(t2, in6(3,:), 'b', t2, in6(2,:), 'r', t2, in6(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-0.45 0.45])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,7)
plot(t3, in7(3,:), 'b', t3, in7(2,:), 'r', t3, in7(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-2.75 2.75])
ylabel('$u^*(t)$', 'Interpreter','latex')

subplot(4,2,8)
plot(t3, in8(3,:), 'b', t3, in8(2,:), 'r', t3, in8(1,:), 'g')
xlabel('$t$', 'Interpreter','latex')
ylim([-2.75 2.75])
ylabel('$u^*(t)$', 'Interpreter','latex')


AddLetters2Plots(figure(6), {'A', 'B','C','D', 'E', 'F', 'G', 'H'},  'HShift', -0.08, 'VShift', -0.015)

saveas(figure(6), '../Optimal Control Figs/Fig6.eps', 'epsc')


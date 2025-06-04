%NOTE need to start and stop opt_bvp_chaotic_RHH.m first

opt_bvp_chaotic_sin;
close all

figure(1)
subplot(3, 2, 1)
plot(theta, Z_sin(theta), 'LineWidth',1.5)
xlabel('$\theta$', 'Interpreter','latex')
ylabel('$Z(\theta)$', 'Interpreter','latex')
ylim([-0.55 0.55])

subplot(3, 2, 2)
plot(theta, Z_snip(theta), 'LineWidth',1.5)
xlabel('$\theta$', 'Interpreter','latex')
ylabel('$Z(\theta)$', 'Interpreter','latex')
ylim([-0.05 1.05])


subplot(3, 2, 3)
plot(theta, Z_HH(theta), 'LineWidth',1.5)
xlabel('$\theta$', 'Interpreter','latex')
ylabel('$Z(\theta)$', 'Interpreter','latex')
ylim([-0.15 0.25])


subplot(3, 2, 4)
plot(theta, Z_RHH(theta), 'LineWidth',1.5)
xlabel('$\theta$', 'Interpreter','latex')
ylabel('$Z(\theta)$', 'Interpreter','latex')

AddLetters2Plots(figure(1), {'A', 'B','C','D'},  'HShift', -0.08, 'VShift', -0.015)

saveas(figure(1), '../Optimal Control Figs/Fig1.eps', 'epsc')
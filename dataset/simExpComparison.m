warning off;

%% Define table of experiments to visualize
experimentsTable = [28 29 30]; % Vector of experiments numbers

f = 10000; % sampling frequency [Hz]
T = 4; % time of presentation [s]

%% Plot data
h1 = figure;

% Load data
for i=1:numel(experimentsTable)
    [time,output,controlSignal,referenceValue,controlError,extendedStateEstimate] = loadData(experimentsTable(i));
    
    subplot(2,2,1);
    hold on;
    plot(time(1:T*f),output(1:T*f),'LineWidth',1.5,'DisplayName',"Exp "+num2str(experimentsTable(i)));
    
    subplot(2,2,2);
    hold on;
    plot(time(1:T*f),controlError(1:T*f),'LineWidth',1.5,'DisplayName',"Exp "+num2str(experimentsTable(i)));
    
    subplot(2,2,3);
    hold on;
    plot(time(1:T*f),controlSignal(1:T*f),'LineWidth',1.5,'DisplayName',"Exp "+num2str(experimentsTable(i)));
    
    subplot(2,2,4);
    hold on;
    plot(time(1:T*f),extendedStateEstimate(1:T*f,3),'LineWidth',1.5,'DisplayName',"Exp "+num2str(experimentsTable(i)));
end

% Output
subplot(2,2,1);
hold on;
grid on;
plot(time(1:T*f),referenceValue(1:T*f),'k--','LineWidth',1.5,'DisplayName',"Reference");
title('Output');
legend show;
xlabel('$t$[s]','interpreter','latex');
ylabel('$U$[V]','interpreter','latex');


% Control error
subplot(2,2,2);
hold on;
grid on;
title('Control error');
xlabel('$t$[s]','interpreter','latex');
ylabel('$e$[V]','interpreter','latex');

% Control signal
subplot(2,2,3);
hold on;
grid on;
title('Control signal');
xlabel('$t$[s]','interpreter','latex');
ylabel('PWM[%]');

% Total disturbance estimate
subplot(2,2,4);
hold on;
grid on;
title('Total disturbance estimate');
xlabel('$t$[s]','interpreter','latex');
ylabel('$\hat{z}_3$[V/s$^2$]','interpreter','latex');

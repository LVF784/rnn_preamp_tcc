%% RNN FOR NONLINEAR DYNAMIC SYSTEM IDENTIFICATION by LUAN VINÍCIUS FIORIO
clear all
close all
clc

%% Data for identification
csvread('lowgain_sweep_05.csv',21,0);
in_1 = ans(1.97e05:end,2);
out_1 = ans(1.97e05:end,3);

%% Data treatment
t_raw = ans(:,1);
in_raw = [in_1];
out_raw = [out_1];

t_r = resample(t_raw,1,15);
in_r = resample(in_raw,1,15);
out_r = resample(out_raw,1,15);

in2 = in_r(50:end,1)';
Yd2 = out_r(50:end,1)';

in_valid1 = in2;
yd_valid1 = Yd2;

%% Network parameters
en = 2;         %Number of inputs (1 = only input; 2 = input + bias)
hl = 7;         %Number of neurons on the 1st hidden layer
hl2 = hl;       %Number of neurons on the 2nd hidden layer
activ = 1;      %Activation function (1 = logistic, else = tanh)
out = 2;        %Activation function in output (1 = linear; 2 = def. above)
eta = 0.05;     %Learning rate parameter
em = 10;        %Initial error to begin while
k = 0;          %Initial epoch to begin while
h = 30;         %BPTT's depth for truncation
p = 29;         %Length for standard deviation
dpv = 10;       %Initial standard deviation to begin while
u = 1;          %Auxiliar variable

%Stopping criteria
eps = 1e-10;    %Minimum desired MSE
iter_max = 1e3; %Maximum number of iterations (per full data)
dpv_max = 5e-4; %Maximum desired standard deviation

%Data normalization
if activ==1
    in = (1*(in2) - min(in2))/(max(in2)-min(in2))+0.01;
    Yd = (1*(Yd2) - min(Yd2))/(max(Yd2)-min(Yd2));
    
    in_valid = (1*(in_valid1) - min(in_valid1))/(max(in_valid1)-min(in_valid1))+0.01;
    yd_valid = (1*(yd_valid1) - min(yd_valid1))/(max(yd_valid1)-min(yd_valid1));
else
    in = (2*(in2) - min(in2))/(max(in2)-min(in2))-0.5;
    Yd = (2*(Yd2) - min(Yd2))/(max(Yd2)-min(Yd2))-0.5;
end

%Initial weights according to Xavier initialization for tanh (and similar)
for y = 1:hl
    for x = 1:en
        W1(x,y) = (2*rand(1)-1)*eta*sqrt(1/(hl+1));
    end
end

for y = 1:hl2
    for x = 1:hl
        Wl(x,y) = (2*rand(1)-1)*eta*sqrt(1/(hl+1));
    end
end

for y = 1:hl
    for x = 1:2
        Wr(x,y) = (2*rand(1)-1)*eta*sqrt(1/(hl+1));
    end
end

for y = 1:1
    for x = 1:hl
        W2(x,y) = (2*rand(1)-1)*eta*sqrt(1/(hl+1));
    end
end

input = zeros(1,h);
target = zeros(1,h);

%% RNN training procedure
while((em>eps) && (k<iter_max) && (dpv>dpv_max))
    for a = 1:length(in)
        %Enter the "r" realm
        input(1,h) = in(1,a);
        target(1,h) = Yd(1,a);
                    
        rnn_feedforward     %Runs the feedforward network        
        rnn_bptt            %Truncated backprop through time
        rnn_weightupdate    %Weight update by steepest descent

        Yout(1,a) = Yout(1,h);

        %Shift of input and target values
        for r = h-1:-1:1
            input(1,r) = input(1,r+1);
            target(1,r) = target(1,r+1);
        end

        error = abs(Yd(1,a) - Yout(1,a));
        sqe = error*error';
        mse_out(a) = sqe;       
    end

    k = k + 1;
    mse = sum(mse_out)/(length(in));
    p_erro(k) = mse;
    em = mse;
    
    rnn_valid
    for a = 1:length(in_valid)
        errorv = abs(yd_valid(a) - Youtv(a));
        sqev = errorv*errorv';
        mse_outv(a) = sqev;
    end
    msev = sum(mse_outv)/(length(in_valid));
    emv = msev;
    p_errov(k) = msev;
        
    if u==k   
        if k<p
            sprintf('Iteration num. %d \n training MSE of %i \n valid MSE of %i',k, em, emv)        
        end
        if u==1
            u = u+p;            
        else
            u = u+p+1;
        end
        
        if k>p
            j = 1;
            for i = k-p:k
                p_errovd(j) = p_errov(i);
                j = j+1;
            end
            
            meanv = mean(p_errovd);
            for m = 1:size(p_errovd)
                sum1 = sum((p_errovd(m) - meanv).^2);
            end
            
            dpv = sqrt(sum1./length(p_errovd(1,:)));
            
            if k>p
                sprintf('Iteration num. %d \n training MSE of %i \n valid MSE of %i \n Standard deviation of validation MSE: %i',k, em, emv, dpv)
            end
        end
    end
end

%% Training output plot
figure(1)
clf
title('Training Output vs Desired output');
xlabel('Sample'); ylabel('Value');
hold on
plot(Yd,'-k')
plot(Yout,'-r')
hold off
grid on
legend('Desired Output','Training Output');

%% Validation output plot
figure(2)
clf
title('Network Output After Training vs Desired output');
xlabel('Sample'); ylabel('Value');
hold on
plot(yd_valid,'-k')
plot(Youtv,'-r')
hold off
grid on
legend('Desired Output','Network Output');

%% Saving model and results     
fname = 'name_to_save.mat';
save(fname,'Youtv','emv','Yout1','em','W1','Wr','W2','Wl','p_erro','p_errov','in','Yd','in_valid','yd_valid');

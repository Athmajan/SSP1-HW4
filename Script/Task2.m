%Task 2

clear all;
close all;

M = 2;
A = 1;
variance = 0.001; 
fo = 1/4; 
phase = pi/3; 
Iteration = 10;
n = -M:1:M;

freq_estimation = zeros(1,Iteration); 
phase_estimation = zeros(1,Iteration);

for i=1:Iteration
    wn = sqrt(variance)*randn(1,2*M+1); % Zero Mean Additive White Gaussian noice N(0, var)
    xn = A*cos(2*pi*fo*n + phase) + wn; % Signal
 
    if(i == 1)
        freq_estimation(i) = fo; % Initial Frequency Estimate 
        phase_estimation(i) = phase; % Initial Phase Estimate
    else
        for y=-M:1:M
            freq_estimation(i) = freq_estimation(i) + y*xn(y+M+1)*sin(2*pi*freq_estimation(i-1)*y + phase_estimation(i-1)); %Frequency Accumilate
            phase_estimation(i) = phase_estimation(i) + xn(y+M+1)*sin(2*pi*freq_estimation(i-1)*y + phase_estimation(i-1)); %Phase Accumilate
        end

        freq_estimation(i) = freq_estimation(i-1) - freq_estimation(i)*3/(4*pi*(M^3)); % substract from estimate of Previous Iteration
        phase_estimation(i) = phase_estimation(i-1) - phase_estimation(i)/M; % substract from estimate of Previous Iteration
    end 
end
subplot(1,2,1); 
plot([1:Iteration],freq_estimation,'color',[1,0,0]); 
xlabel('No.of Iteration'); 
ylabel('Frequency'); 
title('Estimation of Frequency');

subplot(1,2,2); 
plot([1:Iteration],phase_estimation,'b'); 
xlabel('No.of Iteration'); 
ylabel('Phase');
title('Estimation of Phase');
clc;
clear;
close all;

% 1. Load dataset
T = readtable('data.csv');
x = T.Births;
x = x(:);
% 2. User-defined values
fs = input('Enter sampling frequency: ');
N = input('Enter filter order (even number): ')
disp('1. Low-pass  2. High-pass  3. Band-pass  4. Band-stop');
type = input('Choose filter type: ');

if type == 1
    fc = input('Enter cutoff frequency: ');
    Wn = fc/(fs/2);
    ft = 'low';
elseif type == 2
    fc = input('Enter cutoff frequency: ');
    Wn = fc/(fs/2);
    ft = 'high';

    elseif type == 3
    f1 = input('Enter lower cutoff: ');
    f2 = input('Enter upper cutoff: ');
    Wn = [f1 f2]/(fs/2);
    ft = 'bandpass';
else
    f1 = input('Enter lower cutoff: ');
    f2 = input('Enter upper cutoff: ');
    Wn = [f1 f2]/(fs/2);
    ft = 'stop';
end

A = input('Enter Chebyshev attenuation: ');
B = input('Enter Kaiser beta: ');

% Seven windows
w{1} = rectwin(N+1);
w{2} = hann(N+1);
w{3} = hamming(N+1);
w{4} = blackman(N+1);
w{5} = triang(N+1);
w{6} = chebwin(N+1,A);
w{7} = kaiser(N+1,B);
names = {'Rectangular','Hann','Hamming','Blackman', ...
         'Triangular','Chebyshev','Kaiser'};
  % Apply filters and display results
y = zeros(length(x),1);
     
for i = 1:7

    % Design FIR filter
    b = fir1(N,Wn,ft,w{i});

    % Filter input signal
    filtered_signal = filter(b,1,x);

    % Display frequency response
    figure;
    freqz(b,1,1024,fs);
    title([names{i},' Frequency Response']);

    % Display filtered output
    figure;
    plot(filtered_signal);
    title([names{i},' Filtered Output']);
    xlabel('Sample Number');
    ylabel('Amplitude');
    grid on;

end

function [coeffs] = morlet_wavelet(thedat,sr,freqs)

% Performs Morlet Wavelet Decomposition
%
% Syntax:
% [coeffs] = morlet_wavelet(thedat,sr,freqs);%
%
% coeffs        morlet wavelet decomposition coefficients
% thedat        the data (signal) to be decomposed
% sr            sampling frequency in Hz
% freqs         frequency vector used to specify sampling in the frequency
%               domain
%
% 
% Example:
% coeffs = morlet_wavelet(signal, 1000, [1:5:150]);
% will produce the morlet wavelet decomposed values of the signal 
% sampled at 1000Hz, for the frequencies from 1 to 150HZ, with a 5Hz step
%
% Written by Theo Zanos, 2006

z0 = 5;
    
    isodd = mod(length(thedat),2)==1;
    if isodd
        thedat = thedat(1:end-1);
    end
    if size(thedat,1)==1
        thedat = thedat';
    end
    fftd = fft(thedat);
    coeffs = zeros(length(thedat),length(freqs));
    
    
    
    for ii = 1:length(freqs)
        x = [0:length(thedat)/2,-length(thedat)/2+1:-1]';
        x = x*freqs(ii)/sr;
        morletwavelet = (cos(2*pi*x) + 1i*sin(2*pi*x)).* ...
            exp(-2*x.^2*pi^2/z0^2) - exp(-z0^2/2-2*x.^2*pi^2/z0^2);
        coeffs(:,ii) = ifft(fftd.*fft(morletwavelet));
        %display(['frequency: ' num2str(ii)]);
    end
    coeffs = coeffs';
    if isodd
        coeffs = [coeffs,coeffs(:,end)];
    end
end
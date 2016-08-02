%% Resonance tests
% Experiments performed in the Corey lab on 8/1/16 using two photodiodes
% that had an image of the probe along the center-line separating them.
% Lateral resonance assessed using a single bessel filtered step. 

% Ch1 = step command Ch2 = strain guage (axial resonance) Ch3 = photodiode
% (difference, lateral resonance)
close all;
cwd = pwd;

% used the stimfit package to verify experimental sampling rate
%stf.get_sampling_interval() = 0.006 --> 6us/sample:
fs = 1/0.000006;

% The 500hz power is likely due to something on the rig, it was easy to
% modify by de-cluttering or moving things around. The first lateral mode
% jumped out even with low snr (lamp was acting up).

%% higher snr, rev1 probe
abf = abfload(fullfile(cwd,'carbide_probe_rev1_0000.abf'));

figure;
pwelch(abf(:,3),2^14,[],[],fs);

[pxx,f] = pwelch(abf(:,3),2^14,[],[],fs);

figure('Color',[1 1 1])
plot(f,10*log10(pxx))
axis([0 10e3 ylim])
xlabel('Frequency Hz')
ylabel('Magnitude dB')
title('Rev 1 Probe resonance')
box off
% roughly 3.7kHz resonance

%% low snr but still valid rec, rev2 probe
abf = abfload(fullfile(cwd,'carbide_probe_rev2_0002.abf'));

figure;
pwelch(abf(:,3),2^14,[],[],fs);

[pxx,f] = pwelch(abf(:,3),2^14,[],[],fs);

figure('Color',[1 1 1])
plot(f,10*log10(pxx))
axis([0 10e3 ylim])
xlabel('Frequency Hz')
ylabel('Magnitude dB')
title('Rev 2 Probe resonance')
box off
% lowish snr but also appears to have 3.7kHz resonance

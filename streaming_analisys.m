clear all
close all

shaper_out = load("shaper_electronics_streaming_tb.txt");
amp_truth = load("amp_truth.txt");

shaper_out = shaper_out(5:10e4)/(2^15);

figure;
plot(amp_truth);
hold on;
plot(shaper_out);
hold off;
legend("Truth Amplitude","Shaper output")
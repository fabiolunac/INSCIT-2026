clc
close all
clear

Hz = load("Hz.mat").Hz;

for i = 1:length(Hz)
  fprintf('Seção %d — Ordem: %d\n', i, length(Hz{1,i}.Denominator)-1);
  fprintf('  Numerador:   '); disp(Hz{1,i}.Numerator);                                                        
  fprintf('  Denominador: '); disp(Hz{1,i}.Denominator);                                                      
end  


Hz_quant_combined = Hz{1,7}.Numerator + Hz{1,8}.Numerator + Hz{1,9}.Numerator;

fprintf('Hz Final: '); disp(Hz_quant_combined);


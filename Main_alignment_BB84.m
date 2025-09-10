%% FUNCTION NAME: Main
% Main entry point function for key rate calculation.
% Please find manual for detailed explanations on the functions and the software structure.
%
% The user can start the program by choosing a preset to run or modifying a custum preset.
% Each preset contains three functions 
% 'setDescription', 'setParameters', and 'setOptions', 
% where respectively the protocol/channel description files, protocol parameters, 
% and software/solver options are inputted.
%%

% format long
% clear all;
% close all;
% clc;

%%%%%%%%%%%%%%%%%%%%% Setting MATLAB Library Path %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %automatically set path for each run
% %please modify installation directories accordingly
% %DO NOT AUTO SET PATH IF YOUR MATLAB HAS OTHER LIBRARIY DEPENDENCIES IN THE PATH!
% %(OR IT WILL CLEAR ALL OTHER DEPENDENCY PATHS)
% restoredefaultpath;
% addpath(genpath('~/cvx_2.2.2'))
% addpath(genpath('~/mosek'))
% 
% addpath(genpath('.')) %add current software directory and all subfolders
% % %Windows path example
% % addpath(genpath('C:\cvx2')) %cvx
% % addpath(genpath('C:\Program Files\Mosek\9.0\toolbox\R2015a')) %external mosek
% % %Mac/Linux path example
% % addpath(genpath('~/cvx'))
% % addpath(genpath('~/mosek'))

%%%%%%%%%%%%%%%%%%%%% Setting User Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%choose a preset test case, or use custom setting (where user can fill in protocol/solver/parameter/options independently)
%available options: 
%1.'pmBB84_asymptotic'
%2.'pmBB84_finite'
%3.'pmBB84WCP_decoy'
%4.'MDIBB84_asymptotic'
%5.'MDIBB84_finite'
%6.'MDIBB84WCP_decoy' (can use parallel toolbox; decoy analysis might take a few minutes)
%7.'DMCVQKD_asymptotic'
%8.(archived) 'pmBB84Simple_asymptotic'
%9.(archived) 'MDIBB84Simple_asymptotic'
%10.(archived) 'MDIBB84Simple_finite'
%11. any custom setting (can be composed based upon templatePreset)


[protocolDescription,channelModel,leakageEC,parameters,solverOptions]=pmBB84WCP_decoy_alignment();

%%%%%%%%%%%%%%%%%%%%% Run Main Iteration %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%call main iteration function
results=mainIteration(protocolDescription,channelModel,leakageEC,parameters,solverOptions);

%%%%%%%%%%%%%%%%%%%%% Output Results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%save the results to file
save('output_alignment_BB84.mat','results','parameters');

%%
% %can also load a previous session's result to plot it
% %(can comment out main iteration above to skip computation)
load('output_alignment_BB84.mat','results','parameters')

plotResults(results,parameters,'none')

Y1 = [results.lowerBound];
Y2 = [results.upperBound];
Y3 = [results.FWBound];
parameters_scan = struct2cell(parameters.scan);
X = asin(sqrt(parameters_scan{1}));
handleF=figure(1);
% set(handleF,'Position',[800,600,800,600]);
plot(X,log10(Y2),'x--',X,log10(Y1),'+-');

XAXISL=xlabel('Alice misalignment angle (radians)');

YAXISL=ylabel('log_{10}R');
LEGENDL = legend('upper bound','lower bound');
% axis([0 210 -8 -2])
XAXISL.FontSize = 20;
YAXISL.FontSize = 20;
LEGENDL.FontSize = 20;
set(gca,'FontSize',18)
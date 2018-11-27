function [xGA, fval, fvalHistory] = problem_1

% Specify objective function
objFctHandle = @f_1;

% Define parameter names, ranges and quantization:

% 1. column: parameter names
% 2. column: parameter ranges
% 3. column: parameter quantizations
% 4. column: initial values (optional)

paramDefCell = {
	'parameter1', [-5.11 5.12], 0.01
	'parameter2', [-5.11 5.12], 0.01
    'parameter3', [-5.11 5.12], 0.01
};

fvalHistory = [];

% Set initial parameter values in struct objFctParams 
a = -5.11;
b = 5.12;
objFctParams.parameter1 =  (b-a).*rand+a;
objFctParams.parameter2 = (b-a).*rand+a;
objFctParams.parameter3 = (b-a).*rand+a;


% Set single additional function parameter
objFctSettings = 100;

% Get default DE parameters
DEParams = getdefaultparams;

% Set number of population members (often 10*D is suggested) 
DEParams.NP = 30;

% Do not use slave processes here. If you want to, set feedSlaveProc to 1 and
% run startmulticoreslave.m in at least one additional Matlab session.
DEParams.feedSlaveProc = 0;

% Set times
DEParams.maxiter  = 100;
DEParams.maxtime  = 500; % in seconds
DEParams.maxclock = [];

% Set display options
DEParams.infoIterations = 1;
DEParams.infoPeriod     = 10; % in seconds

% Do not send E-mails
emailParams = [];

% Set random state in order to always use the same population members here
setrandomseed(1);

% Start differential evolution
[bestmem, bestval, bestFctParams, nrOfIterations, resultFileName,bestvalhist] = differentevolution(...
	DEParams, paramDefCell, objFctHandle, objFctSettings, objFctParams, emailParams); %#ok

disp(' ');
disp('Best parameter set returned by function differentialevolution:');
disp(bestFctParams);

% Continue optimization by loading result file
%{
if DEParams.saveHistory
  
  disp(' ');
  disp(textwrap2(sprintf(...
    'Now continuing optimization by loading result file %s.', resultFileName)));
  disp(' ');
  
  DEParams.maxiter = 100;
  DEParams.maxtime = 60; % in seconds

  [bestmem, bestval, bestFctParams,nrOfIterations] = differentevolution(...
    DEParams, paramDefCell, objFctHandle, objFctSettings, objFctParams, emailParams, ...
    resultFileName); %#ok
  
  %disp(' ');
  %disp('Best parameter set returned by function differentialevolution:');
  %disp(bestFctParams);
  
  xGA = [bestFctParams.parameter1,bestFctParams.parameter2,bestFctParams.parameter3];
  fval = bestval;
  fvalHistory = 0;

%}

xGA = [bestFctParams.parameter1,bestFctParams.parameter2,bestFctParams.parameter3];
fval = bestval;
fvalHistory = bestvalhist;
end


function varargout = pe(model, data, varargin)
%PE Computes the prediction error for an identified model.
%
%  E = PE(MODEL, DATA, K)
%     computes the error in prediction of the output of identified model
%     MODEL K time instants into future using input-output data history
%     from DATA. The prediction error is computed for the time span covered
%     by DATA.
%
%     MODEL is an identified model such as an IDPOLY or IDSS model. If model
%     is originally unavailable, you can estimate one using commands
%     such as AR, ARMAX, POLYEST and N4SID on DATA.
%
%     DATA is an IDDATA object containing a record of measured input and
%     output values. If MODEL is a time series model (no input signals),
%     DATA must be specified as an IDDATA object with no inputs or a double
%     matrix of past (already observed) time series values.
%
%     K is the prediction horizon, a positive integer denoting a multiple
%     of data sample time. Old outputs up to time t-K are used to predict
%     the output at time instant t. All relevant inputs (times t, t-1, t-2,
%     ..) are used. K = Inf leads to the computation of simulation error.
%     (Default K = 1).
%
%     The output argument E is the prediction error data returned as an
%     IDDATA object. If DATA contains multiple experiments, so will E. The
%     time span of output values in E is same as that of the observed data
%     set DATA.
%
%  E = PE(MODEL, DATA, ..., OPTIONS)
%     specifies options affecting handling of data offsets and other
%     options controlling the prediction error calculation algorithm. See
%     peOptions for more information.
%
% [E, X0E, MPRED] = PE(MODEL, DATA,...)
%     returns the estimated values of initial states X0E and a predictor
%     system MPRED. X0E is returned only for state-space systems. MPRED is
%     a dynamic system whose simulation using [DATA.OutputData,
%     DATA.InputData] as input signal yields YP as the response (using
%     initial states X0E for state space models) such that E.OutputData =
%     DATA.OutputData - YP. For discrete-time data (time domain data or
%     frequency domain data with Ts>0), MPRED is a discrete-time system,
%     even if MODEL is continuous-time. If DATA is multiexperiment, MPRED
%     is an array of Ne systems, where Ne = number of data experiments.
%
%  When called with no output arguments, PE(...) shows a plot of the
%  prediction error.
%
% See also PEOPTIONS, PREDICT, RESID, IDPARAMETRIC/SIM, LSIM, COMPARE, AR,
% ARX, N4SID, IDDATA, IDPAR.

%  Author(s): Rajiv Singh
%  Copyright 2010-2013 The MathWorks, Inc.
narginchk(2,6)
modelname = inputname(1);

% check if data/model order is reversed
if isa(data,'DynamicSystem') && (isnumeric(model) || isa(model,'frd') || isa(model,'iddata'))
   datat = data; data = model; model = datat;
   modelname = inputname(2);
end

if isempty(model.Name), model.Name = modelname; end
no = nargout;
try
   [e, varargout{2:no}] = pe_(model, data, varargin{:});
catch E
   throw(E)
end

if no==0
   model = copyDataMetaData(model, e, true);
   utidplot(model,e,'Prediction Error')
else
   if isnumeric(data) && isa(e,'iddata')
      e = pvget(e,'OutputData');
      if isscalar(e), e = e{1}; end
   end
   varargout{1} = e;
end

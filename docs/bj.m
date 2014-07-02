function sys = bj(varargin)
%BJ  Estimate Box-Jenkins polynomial model using time domain data.
%
%  M = BJ(Z, [nb nc nd nf nk])
%    estimates a Box-Jenkins model represented by:
%       y(t) = [B(q)/F(q)] u(t-nk) +  [C(q)/D(q)]e(t)
%    where:
%       nb = order of B polynomial + 1 (Ny-by-Nu matrix)
%       nf = order of F polynomial     (Ny-by-Nu matrix)
%       nc = order of C polynomial     (column vector of Ny entries)
%       nd = order of D polynomial     (column vector of Ny entries)
%       nk = input delay (in number of samples, Ny-by-Nu matrix)
%       (Nu = number of inputs;  Ny = number of outputs)
%
%    The estimated model, M, is delivered as an @idpoly object. M contains
%    the estimated values for A, B, and C polynomials along with their
%    covariances and structure information.
%
%    Z is the time-domain estimation data given as an IDDATA object. Type
%    "help iddata" for more information. You cannot use frequency-domain
%    data for estimation of BJ models. nb, nc, nd, nf and nk are the
%    polynomial orders associated with the BJ model.
%
%  M = BJ(Z, [nb nc nd nf nk], 'Name1', Value1, 'Name2', Value2,...)
%    specifies additional attributes of the model structure as name-value
%    pairs. Specify as one or more of the following:
%    'InputDelay': Specify input delay as a double vector of length equal
%                  to number of inputs. Entries must be nonnegative
%                  integers denoting the delay as multiples of sample
%                  time.
%      'ioDelay': Input-to-output delay (double matrix). Specify as an
%                 Ny-by-Nu matrix of nonnegative integers denoting the
%                 delays as multiples of sample time. Useful as a
%                 replacement for "nk" order - max(nk-1,0) lags can be
%                 factored out as "ioDelay" value.
%   'IntegrateNoise': Add integrator to noise channel. Logical vector of
%                 length Ny. Default: false(Ny,1). Setting IntegrateNoise
%                 to true (for a particular output) results in models of
%                 structure:
%                         B(q)                 C(q)      
%                 y(t) = ------ u(t-nk) +  ----------- e(t)
%                         F(q)             (1-q^-1)D(q)
%                 where 1/(1-q^-1) is the integrator in the noise channel
%                 e(t).
%
%  M = BJ(Z, [nb nc nd nf nk], ..., OPTIONS)
%    specifies estimation options that configure the estimation objective,
%    initial conditions and numerical search method to be used for
%    estimation. Use the "bjOptions" command to create the option set
%    OPTIONS.
%
%  M = BJ(Z, M0)
%  M = BJ(Z, M0, OPTIONS)
%    uses the IDPOLY model M0 to configure the initial parameterization of
%    the resulting model M. M0 must be a model of BJ structure (only B, C,
%    D and F polynomials must be active). M0 may be created using the
%    IDPOLY constructor or could be the result of a previous estimation.
%    The initial model argument, M0, may be followed by estimation options
%    to configure estimation options. If OPTIONS is not specified and M0
%    was created by estimation, the options are taken from M0.Report.OptionsUsed.
%
%   Continuous Time Model Estimation 
%   This command cannot be used for estimating continuous-time models. Some
%   alternatives are to estimate a continuous-time transfer function using
%   TFEST command or a state-space model using the SSEST command. You can
%   also estimate a discrete-time BJ model followed by its transformation
%   to continuous-time using the D2C command.
%
%   See also BJOPTIONS, TFEST, ARX, ARMAX, IV4, SSEST, OE, POLYEST, IDPOLY,
%   IDDATA, DYNAMICSYSTEM/D2C, IDPARAMETRIC/FORECAST, IDPARAMETRIC/SIM,
%   COMPARE.

%   Lennart Ljung 10-10-86
%   Copyright 1986-2011 The MathWorks, Inc.

narginchk(2,Inf)

% Set estimation data name.
I = find(cellfun(@(x)isa(x,'iddata') || isa(x,'frd'),varargin(1:2)));
if ~isempty(I) && isempty(varargin{I(1)}.Name);
   varargin{I(1)}.Name = inputname(I(1));
end

% Validate input arguments and create a template system if required.
try
   [sys, EstimData, Orders] = validatePEMInputs('bj',varargin{:});
catch E
   throw(E)
end

Options = getDefaultOptions(sys);
Disp = ~strcmpi(Options.Display,'off');
if Disp
   W = Options.ProgressWindow;
   Str = ctrlMsgUtils.message('Ident:estimation:msgDispPolyest1','BJ');
   idDisplayEstimationInfo('Intro',{Str, ' '},W);
end

%% Perform estimation.
try
   sys = pem_(sys, EstimData, Orders);
catch E
   if Disp
      S{1} = sprintf('<font color="red">%s</font>',E.message);
      S{2} = ctrlMsgUtils.message('Ident:estimation:msgAbortEstimation');
      idDisplayEstimationInfo('Error',S,W);
   end
   throw(E)
end
if Disp, W.STOP = true; end

%% Reconcile metadata between model and data.
sys = copyEstimationDataMetaData(sys, EstimData);
Report = sys.Report; Report.Method = 'BJ'; sys = setReport(sys, Report);

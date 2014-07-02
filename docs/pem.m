function [sys, varargout] = pem(varargin)
%PEM Compute the prediction error estimate of a linear or nonlinear model.
%
%   MODEL = PEM(DATA,Mi)  
%   updates the parameters of a model Mi to fit a given estimation data.
%   The returned model is obtained by updating the values of free
%   parameters of Mi using the prediction error minimization algorithm. Mi
%   is any linear or nonlinear model object (idtf, idss, idnlarx, idnlgrey
%   etc) with finite parameter values. DATA is estimation data expressed as
%   an iddata object or an idfrd object. The input-output dimensions of
%   DATA must match that of Mi. Frequency domain data can be used only when
%   the model Mi is linear.
%
%   For black box estimations (when specifying only the model orders or
%   using an initial model with NaN-valued parameters), use dedicated,
%   model type specific estimation commands such as SSEST (for idss
%   models), TFEST (for idtf models), POLYEST (for idpoly models),
%   PROCEST (for process models), NLARX (for idnlarx models) and NLHW (for
%   idnlhw models).
%
%   PEM is the only estimator of nonlinear grey box models. For other model
%   structures, the functionality of PEM can also be achieved by their own
%   dedicated estimators. For example, the task of updating the parameters
%   of a state-space model with well defined parameters can be carried by
%   SSEST. Hence, with the exception of idnlgrey models, you don't need to
%   use PEM.      
%
%   MODEL = PEM(DATA,Mi,Options)
%   uses the option set Options to configure the estimation algorithm
%   settings, handling of estimation focus, initial conditions and data
%   offsets. This syntax is available for linear models only. Options must
%   be created appropriately for individual model types:
%   - For idss models, Options must be configured using SSESTOPTIONS.
%   - For idtf models, use TFESTOPTIONS.
%   - For idproc models, use PROCESTOPTIONS.
%   - For idpoly models, use POLYESTOPTIONS.
%   - For idgrey models, use GREYESTOPTIONS.
%
%   See also IDTF, IDPOLY, IDSS, IDGREY, IDPROC, ARMAX, OE, BJ, N4SID,
%   SSEST, TFEST, PROCEST, GREYEST, NLHW, NLARX, RESID, COMPARE, IDFILT,
%   IDDATA, IDFRD, TFESTOPTIONS, PROCESTOPTIONS, POLYESTOPTIONS,
%   GREYESTOPTIONS SSESTOPTIONS.

%	L. Ljung 10-1-86, 7-25-94, Rajiv Singh, 05-19-2010
%  Copyright 1986-2011 The MathWorks, Inc.

narginchk(1,Inf)

%% Bypass model method call
if nargin>1 && (isa(varargin{2},'idgrey') || isa(varargin{2},'idnlmodel') ...
      || isa(varargin{2},'idtf') || isa(varargin{2},'idarx'))
   varargin = [varargin(2), varargin(1), varargin(3:end)];
   [sys, varargout{1:nargout-1}] = pem(varargin{:});
   return
end

%% Parse inputs and convert orders, if specified, into a model template.

% Set estimation data name.
if nargin==1, varargin{2} = 'best'; end

I = find(cellfun(@(x)isa(x,'iddata') || isa(x,'frd'),varargin(1:2)));
if ~isempty(I) && isempty(varargin{I(1)}.Name);
   varargin{I(1)}.Name = inputname(I(1));
end

% Validate input arguments.
try
   [sys, EstimData, Orders] = validatePEMInputs('pem',varargin{:});
catch E
   throw(E)
end

Options = getDefaultOptions(sys);
Disp = ~strcmpi(Options.Display,'off');
if Disp
   W = Options.ProgressWindow;
   switch class(sys)
      case 'idproc'
         Str = ctrlMsgUtils.message('Ident:estimation:msgDispProcest1');
      case 'idss'
         Str = ctrlMsgUtils.message('Ident:estimation:msgDispSsest1');
      case 'idpoly'
         Type = getType(sys); Type = upper(Type{1});
         if strncmp(Type,'G',1)
            Type = 'Polynomial';
         end
         Str = ctrlMsgUtils.message('Ident:estimation:msgDispPolyest1',Type);
   end
   idDisplayEstimationInfo('Intro',{Str,' '},W);
end

%% Perform estimation.
try
   [sys, varargout{1:nargout-1}] = pem_(sys, EstimData, Orders);
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

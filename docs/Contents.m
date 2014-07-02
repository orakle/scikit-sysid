% System Identification Toolbox
% Version 9.0 (R2014a) 27-Dec-2013
%
% General.
%   identpref        - Set System Identification Toolbox preferences.
%   InputOutputModel - Overview of input/output model objects.
%   DynamicSystem    - Overview of dynamic system objects.
%   lti              - Overview of linear time-invariant system objects.
%   idlti            - Overview of identified linear models.
%   idnlmodel        - Overview of identified, nonlinear dynamic models.
%
% Graphical User Interface.
%   ident            - System Identification Tool (interactive identification and analysis)
%   midprefs         - Specify a directory for start-up information.
%
% Data analysis and processing.
%   iddata           - Construct an input-output data object.
%   idfrd            - Construct a frequency response data object.
%   iddata/detrend   - Remove trends from data sets.
%   delayest         - Estimate the time delay (dead time) from data.
%   iddata/feedback  - Investigate feedback effects in data sets.
%   getTrend         - Offsets and linear trends of data sets. 
%   iddata/fft       - Transform data from time to frequency domain.
%   iddata/ifft      - Transform data from frequency to time domain.
%   iddata/getexp    - Retrieve separate experiment(s) from multiple-experiment
%                      iddata objects.
%   iddata/advice    - Advice about a data set.
%   iddata/merge     - Merge several data experiments.
%   nkshift          - Shift data sequences for delays.
%   iddata/plot      - Plot input-output data.
%   iddata/resample  - Resample data by decimation and interpolation.
%   iddata/isnlarx   - Test if a nonlinear ARX model is better than a linear.
%   misdata          - Estimate and replace missing input and output data.
%   idfilt           - Filter data through Butterworth filters.
%   idinput          - Generates input signals for identification.
%   iddata/isreal    - Check if a data set contains real data.
%
% Nonparametric estimation.
%   cra              - Compute impulse response by correlation analysis.
%   etfe             - Empirical Transfer Function Estimate and Periodogram.
%   impulseest       - Direct estimation of impulse response as FIR filter.
%   spa              - Spectral analysis.
%   spafdr           - Spectral analysis with frequency dependent resolution.
%
% Linear model identification.
%   tfest            - Transfer function model estimation.
%   ssest            - State-space model estimation.
%   procest          - Process model estimation.
%   ar               - AR-models of signals using various approaches.
%   armax            - Prediction error estimate of an ARMAX model.
%   arx              - LS-estimate of ARX-models.
%   arxRegul         - ARX regularization scaling and weighting data.
%   oe               - Prediction error estimate of an output-error model.
%   bj               - Prediction error estimate of a Box-Jenkins model.
%   polyest          - Prediction error estimate of a generic polynomial model.
%   greyest          - Parameter estimation for a linear grey-box model.
%   ivar             - IV-estimates for the AR-part of a scalar time series.
%   iv4              - Approximately optimal IV-estimates for ARX-models.
%   n4sid            - State-space model estimation using a subspace method.
%   ssregest         - State-space model estimation by reduction of regularized ARX mdoels.
%   pem              - Update the parameters of a linear or nonlinear model structure.
%   init             - Initialize (randomize) the parameters of a model.
%   getpar           - Get parameter atrributes of linear models.
%   setpar           - Set parameter atrributes of linear models.
%   idpar            - Parameter configuration for structured estimation 
%                      of initial states and input levels.
%
% Nonlinear model identification.
%   nlarx            - Identify a Nonlinear ARX model.
%   nlhw             - Identify a Hammerstein-Wiener model.
%   pem              - Estimate nonlinear grey-box model parameters.
%
% Model structure creation.
%   idtf             - Create transfer functions with identifiable parameters.
%   idproc           - Create simple continuous-time process models with identifiable parameters.
%   idss             - Create state-space models with identifiable parameters.
%   idpoly           - Create linear polynomial models with identifiable parameters.
%   idfrd            - Create frequency response data models.
%   idgrey           - Create user-parameterized (grey-box) linear models.
%   idnlarx          - Create nonlinear ARX models.
%   idnlgrey         - Create nonlinear user-parameterized models.
%   idnlhw           - Create nonlinear Hammerstein-Wiener type models.
%  
% Model data extraction.
%   tfdata           - Numerators and denominators and their standard deviations.
%   zpkdata          - Zero/pole/gain and their standard deviations.
%   idssdata         - State-space matrices and their standard deviations.
%   polydata         - Polynomials corresponding to idpoly structure and their  
%                      standard deviations.
%   frdata           - Frequency response data and its covariance.
%   get              - Properties of model object.
%   getpvec          - Model parameters and their standard deviations.
%   getcov           - Parameter covariance of a linear model.
%
% Model conversion.
%   c2d              - Continuous to discrete conversion.
%   d2c              - Discrete to continuous conversion.
%   d2d              - Resample discrete-time model.
%   ss2ss            - State coordinate transformation.
%   canon            - Canonical forms of state-space models.
%   ssform           - State space model structure configuration.
%   chgFreqUnit      - Change frequency units in IDFRD model.
%   chgTimeUnit      - Change time units of models.                      
%   noise2meas       - Represent noise component as input-output model. 
%   noisecnv         - Append noise inputs to measured inputs.
%   balred           - State-space model order reduction.
%   idnlarx/findop   - Find idnlarx model's operating point.
%   idnlhw/findop    - Find idnlhw model's operating point.
%   data2state       - Map past input-output values to states of an idnlarx model.
%   linapp           - Linear approximation of nonlinear model for a given input.
%   linearize        - Linearization of nonlinear models about an operating point.
%   ss,tf,zpk,frd    - Transformations to numeric LTI models of Control System Toolbox.
%   Most Control System Toolbox conversion routines also apply to the 
%   identified linear models of System Identification Toolbox.
%
% Simulation and prediction.
%   idParametric/forecast - Forecast the response of identified model N steps.
%   predict          - Prediction over the observed sample range.
%   pe               - Compute prediction errors.
%   idParametric/sim - Simulate a model with user-defined inputs.
%   idParametric/simsd    - Monte Carlo simulations of identified linear models.
%   slident               - Simulink library for recursive estimation and simulation.
%
% Uncertainty analysis.
%   simsd            - Monte Carlo simulations of linear models.
%   rsample          - Random sampling of linear models.
%   getcov           - Parameter covariance of a linear model.
%   setcov           - Modify parameter covariance data of a linear model.
%   translatecov     - Translate covariance data across model transformations.
%   present          - Model display with parameter standard deviations.
%   showConfidence   - View confidence regions on bode, step, impulse, pole-zero
%                      map and nyquist plots of linear models. 
%
% Model analysis and validation.
%   compare          - Compare simulated/predicted output with measured output.
%   pe               - Prediction errors.
%   predict          - N-step ahead prediction over observed sample range.
%   forecast         - Forecast the response of identified model N steps.
%   resid            - Compute and test the residuals associated with a model.
%   sim              - Model response and its uncertainty to user-defined input signal.
%   bode             - Bode plot of linear models (with uncertainty region).
%   step             - Step response of linear and nonlinear models (with uncertainty region).
%   impulse          - Impulse response of linear models (with uncertainty region).
%   nyquist          - Nyquist diagram of linear models (with uncertainty region).
%   iopzmap          - Zeros and poles of a linear model (with uncertainty regions).
%   idnlarx/plot     - Plot response of a Nonlinear ARX model's characteristics.
%   freqresp         - Frequency response over a frequency grid.
%   evalfr           - Evaluate frequency response at given frequency.
%   idnlhw/plot      - Plot response of a Hammerstein-Wiener model's characteristics.
%   findstates       - Initial states estimation for state-space models.
%   goodnessOfFit    - Goodness of fit measures for comparing data.
%   absorbDelay      - Replace delays by poles at z=0 or phase shift.
%   nparams          - Number of model parameters.
%   isstable         - True for linear models with stable dynamics.
%   idParametric/advice   - Advice about an estimated model.
%   idParametric/spectrum - Noise spectrum of time series models (with uncertainty regions).
%   DynamicSystem/view    - View linear model responses (requires Control System Toolbox)
%
% Model structure selection.
%   aic              - Compute Akaike's information criterion.
%   fpe              - Compute final prediction criterion.
%   arxstruc         - Loss functions for families of ARX-models.
%   selstruc         - Select model structures according to various criteria.
%   struc            - Generate typical structure matrices for ARXSTRUC.
%
% Recursive parameter estimation.
%   rarx             - Compute estimates recursively for an ARX model.
%   rarmax           - Compute estimates recursively for an ARMAX model.
%   rbj              - Compute estimates recursively for a BOX-JENKINS model.
%   roe              - Compute estimates recursively for an output error model.
%   rpem             - Compute estimates recursively for a general model.
%   rplr             - Compute estimates recursively for a general model.
%   segment          - Segment data and track abruptly changing systems.
%
% Nonlinearity representation. 
%   customnet        - Custom nonlinearity estimator.
%   deadzone         - Dead zone nonlinearity estimator.
%   linear           - Linear estimator.
%   neuralnet        - Neural network nonlinearity estimator 
%                      (requires Neural Network Toolbox).
%   poly1d           - One-dimensional polynomial estimator.
%   pwlinear         - Piecewise linear nonlinearity estimator.
%   saturation       - Saturation nonlinearity estimator. 
%   sigmoidnet       - Sigmoid network nonlinearity estimator.
%   treepartition    - Tree partition nonlinearity estimator.
%   unitgain         - Unit gain nonlinearity estimator.
%   wavenet          - Wavelet network nonlinearity estimator.
%   idnlfun/evaluate - Evaluate nonlinearity.
%   idnlfun/initreset - Reset initialization of nonlinearity estimators.
%
% Regressor and parameter management for nonlinear models.
%   idnlarx/addreg   - Add custom regressors to a nonlinear ARX model.
%   customreg        - Create custom regressors for a nonlinear ARX model.
%   idnlarx/getreg   - Get regressors of a nonlinear ARX model.
%   idnlgrey/getinit - Get initial states of a nonlinear grey-box model.
%   idnlgrey/setinit - Get initial states of a nonlinear grey-box model.
%   idnlgrey/getpar  - Get parameters of a nonlinear grey-box model.
%   idnlgrey/setpar  - Set parameters of a nonlinear grey-box model.
%   idnlarx/polyreg  - Create polynomial-type custom regressors.
%   getpvec          - Get a vectorized list of model parameters.
%   idnlarx/getDelayInfo - Get maximum delay in each input-output channel.
%
% Bookkeeping and display facilities.
%   present          - Detailed display of identified models.
%   get, set         - Getting and setting the model and data object properties.
%   getpvec,setpvec  - Get and set vectorized list of model parameters.
%   idprops          - Information on nonlinear model properties.
%
% Demonstrations.
%   Type "demo toolbox system" for a list of available examples.

%   Copyright 1986-2013 The MathWorks, Inc.

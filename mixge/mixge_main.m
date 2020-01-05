function out = mixge_main(Y,G,varargin)

%out = mist(Y, G, Parameters)
%   Y is a N by k matrix of phenotypes
%   G is a N by p matrix of genotypes
%   Parameters is an optional structure with the following possible fields:
%       Parameters.Z can be [ones(p,1)] or user defined p by q matrix of characteristics (intercept will be automatically added)
%       Parameters.W can be [ones(p,1)] or user defined p by 1 vecotr of weights
%       Parameters.X can be [ones(N,1)] or user defined N by m matrix of covariates (intercept will be automatically added)
%       Parameters.E can be [null] or user defined N by 1 vector of environment

% assign useful values based on input
Y = double(Y);
N = size(Y,1);
k = size(Y,2);
if isequal(unique(Y),[0;1])
    y_type = 'logit';
else
    y_type = 'continuous';
end
G = double(G);
p = size(G,2);

%Parameters
Z = ones(p,1);
Wvec = ones(p,1);
X = ones(N,1);
environment = 0;
if ~isempty(varargin)
    Parameters = varargin{1};
    if isfield(Parameters,'Z')
        Z = double([Parameters.Z,ones(p,1)]);
    end
    if isfield(Parameters,'W')
        Wvec = double(Parameters.W);
    end
    if isfield(Parameters,'X')
        X = double([Parameters.X,ones(N,1)]);
    end
    if isfield(Parameters,'E')
        E = double(Parameters.E);
        environment = 1;
    end
end
q = size(Z,2);
GZ = G*Z;

% set up Xtilda and Ctilda for pi
if ~environment
    Xtilda = X;
    Ctilda = GZ;
else
    Xtilda = [X,E,GZ];
    EGZ = diag(E) * GZ;
    Ctilda = EGZ;
end

% Upi
if strcmp(y_type,'continuous')
    Btilda = Xtilda \ Y;
    Rtilda = Y - Xtilda * Btilda;
elseif strcmp(y_type,'logit')
    Btilda = zeros(size(Xtilda,2),k);
    for i = 1:k
        Btilda(:,i) = glmfit(Xtilda,Y(:,i),'binomial','constant','off');
    end
    exp_Xtilda_Btilda = exp(Xtilda * Btilda);
    miutilda = exp_Xtilda_Btilda ./ (1 + exp_Xtilda_Btilda);
    Rtilda = Y - miutilda;
end
Upi = Ctilda' * (Rtilda);

% Ppi
if strcmp(y_type,'continuous')
    sigsqtilda = sum((Rtilda).^2)/(N-size(Xtilda,2));
    Ipi = Ctilda' * (eye(N) - Xtilda*(Xtilda'*Xtilda)^-1*Xtilda') * Ctilda;
    Spi = sum((Ipi^-1) * Upi .* Upi, 1) ./ sigsqtilda;
elseif strcmp(y_type,'logit')
    sigsqtilda = miutilda .* (1 - miutilda);
    Spi = zeros(1,k);
    for i = 1:k
        D = diag(sigsqtilda(:,i));
        DXtilda = D * Xtilda;
        Ipi = Ctilda' * (D - DXtilda*(Xtilda'*DXtilda)^-1*DXtilda') * Ctilda;
        Spi(i) = Upi(:,i)' * (Ipi^-1) * Upi(:,i);
    end
end
Ppi = 1 - chi2cdf(Spi,q);

% create weight matrix
W = diag(Wvec);
sqrtW = sqrt(W);

% set up Xhat and Chat for skat
if ~environment
    Xhat = X;
    Chat = G;
else
    Xhat = [X,E];
    Chat = diag(E) * G;
end

% Sskat
if strcmp(y_type,'continuous')
    Bhat = Xhat \ Y;
    Rhat = Y - Xhat * Bhat;
    Sskat = sum((Chat*W*Chat') * Rhat .* Rhat);
elseif strcmp(y_type,'logit')
    Bhat = zeros(size(Xhat,2),k);
    for i = 1:k
        Bhat(:,i) = glmfit(Xhat,Y(:,i),'binomial','constant','off');
    end
    exp_Xhat_Bhat = exp(Xhat * Bhat);
    miuhat = exp_Xhat_Bhat ./ (1 + exp_Xhat_Bhat);
    Rhat = Y - miuhat;
    Sskat = 0.5 * sum((Chat*W*Chat') * Rhat .* Rhat);
end

% Pskat
ChatsqrtW = Chat * sqrtW;
if strcmp(y_type,'continuous')
    sigsq_hat = sum((Rhat).^2)/(N-size(Xhat,2));
    P = (eye(N) - Xhat*(Xhat'*Xhat)^-1*Xhat');
    lambda = eig(ChatsqrtW'*P*ChatsqrtW) * sigsq_hat;
elseif strcmp(y_type,'logit')
    sigsq_hat = miuhat .* (1 - miuhat);
    lambda = zeros(p,k);
    for i = 1:k
        D = diag(sigsq_hat(:,i));
        DXhat = D * Xhat;
        P = D - DXhat * (Xhat'*DXhat)^-1 * DXhat';
        lambda(:,i) = eig(ChatsqrtW'*P*ChatsqrtW);
    end
    lambda = 0.5 * lambda;
end
Pskat = liu(Sskat, lambda);

% set up Xhat and Chat for tausq
if ~environment
    Xhat = [X,GZ];
    Chat = G;
else
    Xhat = [X,E,GZ,EGZ];
    Chat = diag(E) * G;
end

% Stausq
if strcmp(y_type,'continuous')
    Bhat = Xhat \ Y;
    Rhat = Y - Xhat * Bhat;
    Stausq = sum((Chat*W*Chat') * Rhat .* Rhat);
elseif strcmp(y_type,'logit')
    Bhat = zeros(size(Xhat,2),k);
    for i = 1:k
        Bhat(:,i) = glmfit(Xhat,Y(:,i),'binomial','constant','off');
    end
    exp_Xhat_Bhat = exp(Xhat * Bhat);
    miuhat = exp_Xhat_Bhat ./ (1 + exp_Xhat_Bhat);
    Rhat = Y - miuhat;
    Stausq = 0.5 * sum((Chat*W*Chat') * Rhat .* Rhat);
end

% Ptausq
ChatsqrtW = Chat * sqrtW;
if strcmp(y_type,'continuous')
    sigsq_hat = sum((Rhat).^2)/(N-size(Xhat,2));
    P = (eye(N) - Xhat*(Xhat'*Xhat)^-1*Xhat');
    lambda = eig(ChatsqrtW'*P*ChatsqrtW) * sigsq_hat;
elseif strcmp(y_type,'logit')
    sigsq_hat = miuhat .* (1 - miuhat);
    lambda = zeros(p,k);
    for i = 1:k
        D = diag(sigsq_hat(:,i));
        DXhat = D * Xhat;
        P = D - DXhat * (Xhat'*DXhat)^-1 * DXhat';
        lambda(:,i) = eig(ChatsqrtW'*P*ChatsqrtW);
    end
    lambda = 0.5 * lambda;
end
Ptausq = liu(Stausq, lambda);

% p-combine
Pfisher = 1 - chi2cdf(-2*log(Ppi)-2*log(Ptausq),4);
Ptippett = 1 - (1 - min([Ppi;Ptausq])).^2;

% output
out.Ppi = Ppi;
out.Pskat = Pskat;
out.Ptausq = Ptausq;
out.Pfisher = Pfisher;
out.Ptippett = Ptippett;

end

kS2T = 0.004; % (slow) transition from ST to UT
kT2S = 0; % (??) transition from UT to ST
kD2S = 0.004; % (??) transition from UD to SD.
kS2D = 0; % (slow) transition from SD to UD
kHs  = 0; % (slow) hydrolysis from ST to SD. This determines the slower time constant
kTs  = 50; % fast ATP binding--determines mantATP loading rate
kH   = 50; % fast hydrolysis step UT to UD
kT   = 0.025; % (slow) This determines the faster time constant
k = [kS2T, kT2S, kD2S, kS2D, kHs, kTs, kH, kT];

% Ordering of states
% fST = f(1);
% fUT = f(2);
% fUD = f(3); 
% fSD = f(4);

% setting up and solving linear steady-state problem
A = [-kS2T-kHs, +kT2S,     0,     +kTs;
     +kS2T,    -kH-kT2S,  +kT,      0;
         0,      +kH,   -kD2S-kT, +kS2D;
        +1,      +1,      +1,     +1];
b = [0; 0; 0; 1];

% initial label concentration
p = A\b
% everything starts in SD now!
f0 = [0 0 0 1]

% The label kinetic problem - all states are equally labeled
% p = [1 1 1 1]';
% chase starts at time 0
[t,f] = ode15s(@dfdt4,[-10 800],f0,[],p,k);

label = f*p;
figure(1); clf; plot(t,label./max(label)); axis([-10 800 0 1])
figure(2); clf; semilogy(t,label); grid; set(gca,'Xlim',[0 800])
figure(3); plot(t, f(:, 1)*p(1),t, f(:, 2)*p(2),t, f(:, 3)*p(3),t, f(:, 4)*p(4));
legend('ST','UT','UD','SD')

%%
figure(1); clf; plot(t,label); axis([0 800 0 1])
hold on; plot(t,0.45*exp(-0.0275.*t)+0.55*exp(-0.0030*t), 'r--')

figure(2); clf; semilogy(t,label); grid
hold on; plot(t,0.45*exp(-0.0275.*t)+0.55*exp(-0.0030*t), 'r:', LineWidth=2)
% figure(4); semilogy(t,0.25*exp(-0.01.*t)+0.75*exp(-0.001*t))
figure(3); plot(t, f(:, 1),t, f(:, 2),t, f(:, 3),t, f(:, 4));
legend('ST','UT','UD','SD')



function g = dfdt4(t,f,p,k)

% p = [pST, pUT, pUD, pSD], the steady-state probs.
% k = [kS2T, kT2S, kD2S, kS2D, kHs, kTs, kH, kT], the rate constants

fST = f(1);
fUT = f(2);
fUD = f(3); 
fSD = f(4);
pST = p(1);
pUT = p(2);
pUD = p(3); 
pSD = p(4);
kS2T = k(1);
kT2S = k(2);
kD2S = k(3);
kS2D = k(4);
kHs  = k(5);
kTs  = k(6);
kH   = k(7);
kT   = k(8);
isChase  = t > 0;

dfST = (-(kS2T+kHs)*fST*pST + kT2S*fUT*pUT + kTs*1*pSD*(~isChase))/pST;
% dfST = (-(kS2T+kHs)*fST*pST + kT2S*fUT*pUT + kTs*fSD*pSD*(~isChase))/pST;
dfUT = (+kS2T*fST*pST - (kH+kT2S)*fUT*pUT + kT*1*pUD*(~isChase) )/pUT;
% dfUT = (+kS2T*fST*pST - (kH+kT2S)*fUT*pUT + kT*fUD*pUD*(~isChase) )/pUT;

dfUD = (+kH*fUT*pUT - (kD2S+kT)*fUD*pUD + kS2D*fSD*pSD)/pUD;
dfSD = (+kD2S*fUD*pUD -(kTs+kS2D)*pSD*fSD + kHs*fST*pST )/pSD;

g = [dfST; dfUT; dfUD; dfSD];
end
function [r,rn] = bisect_method(fun,a,b,tol,nmax)
%{
This Matlab function finds, if possible, a root for the one variable, 
continuous function fun on the interval [a,b]. Bisection method runs until
|bn-an|<2*tol or nmax iterations are reached. 

Inputs: 
fun - (function or function handle) one variable function 
a,b - (double) interval for root finding is [a,b]
tol - (double) target accuracy / tolerance for the algorithm
nmax - (int) max number of iterations

Outputs:
r   - (double) final estimate for the root
rn  - (double array) vector of iterates xn (used mainly for convergence /
testing purposes). 

APPM 4650
Instructor: Eduardo Corona
%}

an = a; bn = b; n=0; 
xn = (an+bn)/2; 
rn(n+1)=xn;  
fprintf('\n Bisection method with nmax=%d and tol=%e\n',nmax,tol); 

% The code cannot work if fun(a) and fun(b) have the same sign. In this
% case, the code displays an error message, outputs empty answers and
% exits. 
if fun(a)*fun(b)>=0
    fprintf('\n Interval is inadequate, f(a)*f(b)>=0. Try again \n')
    display(fun(a)*fun(b)); 
    r=[]; rn=[]; 
else

   fprintf('\n|--n--|--an--|--bn--|----xn----|-|bn-an|--|---|f(xn)|---|')
    
while n<=nmax
   %print and pause. Remove or comment out pause if you want the code to go faster. 
   fprintf('\n|--%d--|%1.4f|%1.4f|%1.8f|%1.8f|%1.8f|',n,an,bn,xn,bn-an,abs(fun(xn)));  
   hold on; 
   plot([an bn],fun([an bn]),'ok');
   plot(xn,fun(xn),'xk'); 
   pause; 
   
   % If the estimate is approximately a root, get out of while loop
   if (bn-an)<2*tol 
       %(break is an instruction that gets out of the while loop)
       break;  
   end
   
   % If fun(an)*fun(xn)<0, pick left interval, update bn
   if fun(an)*fun(xn)<0
      bn=xn;     
   else
      %else, pick right interval, update an
      an=xn;  
   end
   
   % update midpoint xn, increase n. 
   n=n+1; 
   xn = (an+bn)/2; 
   rn(n+1)=xn;
end

% Set root estimate to xn. 
r=xn; 

end

end
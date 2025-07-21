f = @(x) (3/4*x-(x-1).^2);
% (9/4*x-(x-1).^2+100)

x=-10:0.01:10;

N=9; % number of iterations (~max 15)
P=0.02; % animation speed (~0.02-0.2)

a=-10; 
b=10; 
alpha=0.01;

%%% Animation
[~, argmax] = max(f(x));
top = x(argmax);
plot(x,f(x),"Color",'w');
axis off
axis tight
hold on
limxa=a;
limxb = 2*top-limxa;
lims=f(a);
limst = (5*f(top)-lims)/4;
xlim([limxa limxb])
ylim([lims limst])
pause(P)
%%% fibonacci sequence generation
fibo = ones(N+1,1);
for i=3:N+1
    fibo(i)=fibo(i-1)+fibo(i-2);
end

%%% main comparation loop
for j=1:N
    plot(a,f(a),'.','Color','r',MarkerSize=12);
    plot(b,f(b),'.','Color','b',MarkerSize=12);
    pause(P)
    plot((a:0.01:b),f((a:0.01:b)));
    pause(P/2)
    for lim_ab = 1:40
        lims = (1-alpha)*lims+alpha*f(a);
        limst = (5*f(top)-lims)/4;
        limxa = (1-alpha)*limxa + alpha*a;
        limxb = 2*top-limxa;
        
        xlim([limxa limxb])
        ylim([lims limst])
        drawnow
    end
    d=abs(b-a);
    a_1=b-(fibo(N-j+1)/fibo(N-j+2))*d;
    b_1=a+(fibo(N-j+1)/fibo(N-j+2))*d;
    if f(a_1)<=f(b_1)
        a=a_1;
    else
        b=b_1;
    end
end
plot(top,f(top),'o','Color','g',MarkerSize=3);
pause(2);
while limxa>-10 || lims-f(x(1))>0.1
    if limxa>-10
        limxa = limxa - 0.1;
        limxb = 2*top-limxa;
    end
    if lims>=f(x(1))
        lims = (0.7)*lims - abs(0.3*f(x(1)));
    end
    xlim([limxa limxb])
    ylim([lims limst])
    drawnow
end
pause(P*5)
hold off

%%%% Simple gradient descent animation - Jan Fridrich
Cmap=load("FrCmap2.mat");
% Settings
I=80; % plot size
P=9; % number of descents
N = 50; % number of iterations 
h=1e-5; % differentiation step size
param=0.1; % descent step size

f_z = @(x,y) (200*sin(x/25*pi) + y.^2); % function to be minimized
% other functions to try out: (x.^2 + y.^2), 
[x,y] = meshgrid(-I/2:I/2-1,-I/2:I/2-1); 
z = f_z(x,y);
%%% main surface plot
s=surf(x,y,z);
s.EdgeColor = 'none';
s.FaceAlpha=0.9;
colormap(Cmap.FRCmap2);
shading interp
axis tight
lighting gouraud
hold on
d=9;
for b = 1:P
    x_ = -I/2+b*I/P-I/16;
    y_ = I/2-I/5*rand;
    
    for i=1:N
        % Symmetric partial derivative
        x_ = x_ - param*((f_z(x_+h,y_)-f_z(x_-h,y_))/(2*h));
        y_ = y_ - param*((f_z(x_,y_+h)-f_z(x_,y_-h))/(2*h));
        % Point plot
        p=plot3(x_,y_,f_z(x_,y_));
        p.LineStyle = ":";
        p.Color = "white";
        p.Marker = ".";
        p.MarkerSize=6;
        axis off
        d=d+1;
        view([(d)/20 70])
        drawnow
        pause(0.02)
    end
end
hold off
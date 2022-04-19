clear all;
data = load('mydata.mat').data;
t = double(data.t); % timestamps [s]
x_init = double(data.x_init) % initial x position [m]
y_init = double(data.y_init) % initial y position [m]
th_init = double(data.th_init) % initial theta position [rad]

%input signal

v = double(data.v)% translational velocity input [m/s]
om = double(data.om)% rotational velocity input [rad/s]

% bearing and range measurements, LIDAR constants

b = double(data.b)% bearing to each landmarks center in the frame attached to the laser [rad]
r = double(data.r)% range measurements [m]
l = double(data.l)% x,y positions of landmarks [m]
d = double(data.d)% distance between robot center and laser rangefinder [m]

v_var = 0.01; % translation velocity variance
om_var = 0.01; % rotational velocity variance
r_var = 0.1; % range measurements variance
b_var = 0.1; % bearing measurement variance
Qkm = 0.1 % Process noise covariance
Rk = 0 % measurement noise covariance
x_est = zeros(3, length(v)); % estimated states, x, y, and theta
P_est = zeros( 3, 3, length(v)); % state covariance matrices
x_est(:,1) = zeros(3, 1); % initial state
P_est(:,:,1) = diag([0, 0, 0]); % initial state covariance
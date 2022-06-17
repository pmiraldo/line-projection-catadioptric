function draw_image_curve_Axial_Cone( ... 
    A, B, C, c, H,...
    s, q, ...
    plot_size, line_color, density...
    )

arguments
    A double
    B double
    C double
    c double
    H (3,3) double
    s (3,1) double
    q (3,1) double
    plot_size (1,4) double = zeros(1,4)
    line_color (1,3) double = zeros(1,3)
    density double = 150
end

warning('off')
s_1 = s(1); s_2 = s(2); s_3 = s(3);
q_1 = q(1); q_2 = q(2); q_3 = q(3);

h1_1 = H(1,1); h1_2 = H(1,2); h1_3 = H(1,3);
h2_1 = H(2,1); h2_2 = H(2,2); h2_3 = H(2,3);
h3_1 = H(3,1); h3_2 = H(3,2); h3_3 = H(3,3);
if c(1) ~= 0
    disp('ERR: c_1 must be 0')
    exit()
end
c_2 = c(2); c_3 = c(3);

cnu1 = h2_2*h3_3 - h2_3*h3_2;
cnu2 = h1_3*h3_2 - h1_2*h3_3;
cnu3 = h1_2*h2_3 - h1_3*h2_2;
cnv1 = h2_3*h3_1 - h2_1*h3_3;
cnv2 = h1_1*h3_3 - h1_3*h3_1;
cnv3 = h1_3*h2_1 - h1_1*h2_3;
cd1 = h2_1*h3_2 - h2_2*h3_1;
cd2 = h1_2*h3_1 - h1_1*h3_2;
cd3 = h1_1*h2_2 - h1_2*h2_1;

c_uv1 = q_2^2*s_3^2 + q_3^2*s_2^2 + c_3^2*s_2^2 - 2*c_3*q_3*s_2^2 - 2*A*c_3^2*s_2^2 + 4*A*q_1^2*s_2^2 + 4*A*q_2^2*s_1^2 + 2*A*q_2^2*s_3^2 + 2*A*q_3^2*s_2^2 + A^2*c_3^2*s_2^2 + A^2*q_2^2*s_3^2 + A^2*q_3^2*s_2^2 + 2*c_3*q_2*s_2*s_3 - 2*q_2*q_3*s_2*s_3 + 2*A^2*c_3*q_3*s_2^2 - 8*A*q_1*q_2*s_1*s_2 - 4*A*q_2*q_3*s_2*s_3 - 2*A^2*c_3*q_2*s_2*s_3 - 2*A^2*q_2*q_3*s_2*s_3;
c_uv2 = 4*c_3*q_3*s_1*s_2 - 2*q_1*q_2*s_3^2 - 2*q_3^2*s_1*s_2 - 2*c_3*q_1*s_2*s_3 - 2*c_3*q_2*s_1*s_3 - 2*c_3^2*s_1*s_2 + 2*q_1*q_3*s_2*s_3 + 2*q_2*q_3*s_1*s_3 + 4*A*c_3^2*s_1*s_2 - 4*A*q_1*q_2*s_3^2 - 4*A*q_3^2*s_1*s_2 - 2*A^2*c_3^2*s_1*s_2 - 2*A^2*q_1*q_2*s_3^2 - 2*A^2*q_3^2*s_1*s_2 + 4*A*q_1*q_3*s_2*s_3 + 4*A*q_2*q_3*s_1*s_3 + 2*A^2*c_3*q_1*s_2*s_3 + 2*A^2*c_3*q_2*s_1*s_3 - 4*A^2*c_3*q_3*s_1*s_2 + 2*A^2*q_1*q_3*s_2*s_3 + 2*A^2*q_2*q_3*s_1*s_3;
c_uv3 = 2*q_1*q_3*s_2^2 - 2*c_3*q_1*s_2^2 + 2*q_2^2*s_1*s_3 + 2*c_3*q_2*s_1*s_2 - 2*q_1*q_2*s_2*s_3 - 2*q_2*q_3*s_1*s_2 - 4*A*q_1*q_3*s_2^2 - 4*A*q_2^2*s_1*s_3 + 2*A^2*c_3*q_1*s_2^2 + 2*A^2*q_1*q_3*s_2^2 + 2*A^2*q_2^2*s_1*s_3 + 4*A*q_1*q_2*s_2*s_3 + 4*A*q_2*q_3*s_1*s_2 - 2*A^2*c_3*q_2*s_1*s_2 - 2*A^2*q_1*q_2*s_2*s_3 - 2*A^2*q_2*q_3*s_1*s_2;
c_uv4 = q_1^2*s_3^2 + q_3^2*s_1^2 + q_2^2*s_3^2 + q_3^2*s_2^2 + c_3^2*s_1^2 + c_3^2*s_2^2 - 2*c_3*q_3*s_1^2 - 2*c_3*q_3*s_2^2 - 2*A*c_3^2*s_1^2 - 2*A*c_3^2*s_2^2 + 8*A*q_1^2*s_2^2 + 8*A*q_2^2*s_1^2 + 2*A*q_1^2*s_3^2 + 2*A*q_3^2*s_1^2 + 2*A*q_2^2*s_3^2 + 2*A*q_3^2*s_2^2 + A^2*c_3^2*s_1^2 + A^2*c_3^2*s_2^2 + A^2*q_1^2*s_3^2 + A^2*q_3^2*s_1^2 + A^2*q_2^2*s_3^2 + A^2*q_3^2*s_2^2 + 2*c_3*q_1*s_1*s_3 + 2*c_3*q_2*s_2*s_3 - 2*q_1*q_3*s_1*s_3 - 2*q_2*q_3*s_2*s_3 + 2*A^2*c_3*q_3*s_1^2 + 2*A^2*c_3*q_3*s_2^2 - 16*A*q_1*q_2*s_1*s_2 - 4*A*q_1*q_3*s_1*s_3 - 4*A*q_2*q_3*s_2*s_3 - 2*A^2*c_3*q_1*s_1*s_3 - 2*A^2*c_3*q_2*s_2*s_3 - 2*A^2*q_1*q_3*s_1*s_3 - 2*A^2*q_2*q_3*s_2*s_3;
c_uv5 = 2*q_2*q_3*s_1^2 - 2*c_3*q_2*s_1^2 + 2*q_1^2*s_2*s_3 + 2*c_3*q_1*s_1*s_2 - 2*q_1*q_2*s_1*s_3 - 2*q_1*q_3*s_1*s_2 - 4*A*q_2*q_3*s_1^2 - 4*A*q_1^2*s_2*s_3 + 2*A^2*c_3*q_2*s_1^2 + 2*A^2*q_2*q_3*s_1^2 + 2*A^2*q_1^2*s_2*s_3 + 4*A*q_1*q_2*s_1*s_3 + 4*A*q_1*q_3*s_1*s_2 - 2*A^2*c_3*q_1*s_1*s_2 - 2*A^2*q_1*q_2*s_1*s_3 - 2*A^2*q_1*q_3*s_1*s_2;
c_uv6 = q_1^2*s_2^2 + q_2^2*s_1^2 + 2*A*q_1^2*s_2^2 + 2*A*q_2^2*s_1^2 + 4*A*q_2^2*s_3^2 + 4*A*q_3^2*s_2^2 + A^2*q_1^2*s_2^2 + A^2*q_2^2*s_1^2 - 2*q_1*q_2*s_1*s_2 - 4*A*q_1*q_2*s_1*s_2 - 8*A*q_2*q_3*s_2*s_3 - 2*A^2*q_1*q_2*s_1*s_2;
c_uv7 = 4*c_3*q_3*s_1*s_2 - 2*q_1*q_2*s_3^2 - 2*q_3^2*s_1*s_2 - 2*c_3*q_1*s_2*s_3 - 2*c_3*q_2*s_1*s_3 - 2*c_3^2*s_1*s_2 + 2*q_1*q_3*s_2*s_3 + 2*q_2*q_3*s_1*s_3 + 4*A*c_3^2*s_1*s_2 - 4*A*q_1*q_2*s_3^2 - 4*A*q_3^2*s_1*s_2 - 2*A^2*c_3^2*s_1*s_2 - 2*A^2*q_1*q_2*s_3^2 - 2*A^2*q_3^2*s_1*s_2 + 4*A*q_1*q_3*s_2*s_3 + 4*A*q_2*q_3*s_1*s_3 + 2*A^2*c_3*q_1*s_2*s_3 + 2*A^2*c_3*q_2*s_1*s_3 - 4*A^2*c_3*q_3*s_1*s_2 + 2*A^2*q_1*q_3*s_2*s_3 + 2*A^2*q_2*q_3*s_1*s_3;
c_uv8 = 2*q_1*q_3*s_2^2 - 2*c_3*q_1*s_2^2 + 2*q_2^2*s_1*s_3 + 2*c_3*q_2*s_1*s_2 - 2*q_1*q_2*s_2*s_3 - 2*q_2*q_3*s_1*s_2 - 4*A*q_1*q_3*s_2^2 - 4*A*q_2^2*s_1*s_3 + 2*A^2*c_3*q_1*s_2^2 + 2*A^2*q_1*q_3*s_2^2 + 2*A^2*q_2^2*s_1*s_3 + 4*A*q_1*q_2*s_2*s_3 + 4*A*q_2*q_3*s_1*s_2 - 2*A^2*c_3*q_2*s_1*s_2 - 2*A^2*q_1*q_2*s_2*s_3 - 2*A^2*q_2*q_3*s_1*s_2;
c_uv9 = 8*A*q_1*q_3*s_2*s_3 - 8*A*q_3^2*s_1*s_2 - 8*A*q_1*q_2*s_3^2 + 8*A*q_2*q_3*s_1*s_3;
c_uv10 = q_1^2*s_3^2 + q_3^2*s_1^2 + c_3^2*s_1^2 - 2*c_3*q_3*s_1^2 - 2*A*c_3^2*s_1^2 + 4*A*q_1^2*s_2^2 + 4*A*q_2^2*s_1^2 + 2*A*q_1^2*s_3^2 + 2*A*q_3^2*s_1^2 + A^2*c_3^2*s_1^2 + A^2*q_1^2*s_3^2 + A^2*q_3^2*s_1^2 + 2*c_3*q_1*s_1*s_3 - 2*q_1*q_3*s_1*s_3 + 2*A^2*c_3*q_3*s_1^2 - 8*A*q_1*q_2*s_1*s_2 - 4*A*q_1*q_3*s_1*s_3 - 2*A^2*c_3*q_1*s_1*s_3 - 2*A^2*q_1*q_3*s_1*s_3;
c_uv11 = 2*q_2*q_3*s_1^2 - 2*c_3*q_2*s_1^2 + 2*q_1^2*s_2*s_3 + 2*c_3*q_1*s_1*s_2 - 2*q_1*q_2*s_1*s_3 - 2*q_1*q_3*s_1*s_2 - 4*A*q_2*q_3*s_1^2 - 4*A*q_1^2*s_2*s_3 + 2*A^2*c_3*q_2*s_1^2 + 2*A^2*q_2*q_3*s_1^2 + 2*A^2*q_1^2*s_2*s_3 + 4*A*q_1*q_2*s_1*s_3 + 4*A*q_1*q_3*s_1*s_2 - 2*A^2*c_3*q_1*s_1*s_2 - 2*A^2*q_1*q_2*s_1*s_3 - 2*A^2*q_1*q_3*s_1*s_2;
c_uv12 = q_1^2*s_2^2 + q_2^2*s_1^2 + 2*A*q_1^2*s_2^2 + 2*A*q_2^2*s_1^2 + 4*A*q_1^2*s_3^2 + 4*A*q_3^2*s_1^2 + A^2*q_1^2*s_2^2 + A^2*q_2^2*s_1^2 - 2*q_1*q_2*s_1*s_2 - 4*A*q_1*q_2*s_1*s_2 - 8*A*q_1*q_3*s_1*s_3 - 2*A^2*q_1*q_2*s_1*s_2;

c_uivi1 = c_uv1*cnu1^4 + c_uv10*cnv1^4 + c_uv6*cd1^2*cnu1^2 + c_uv12*cd1^2*cnv1^2 + c_uv4*cnu1^2*cnv1^2 + c_uv3*cd1*cnu1^3 + c_uv11*cd1*cnv1^3 + c_uv2*cnu1^3*cnv1 + c_uv7*cnu1*cnv1^3 + c_uv5*cd1*cnu1^2*cnv1 + c_uv8*cd1*cnu1*cnv1^2 + c_uv9*cd1^2*cnu1*cnv1;
c_uivi2 = c_uv3*cd2*cnu1^3 + c_uv11*cd2*cnv1^3 + 4*c_uv1*cnu1^3*cnu2 + c_uv2*cnu1^3*cnv2 + c_uv7*cnu2*cnv1^3 + 4*c_uv10*cnv1^3*cnv2 + 2*c_uv6*cd1*cd2*cnu1^2 + 2*c_uv12*cd1*cd2*cnv1^2 + 3*c_uv3*cd1*cnu1^2*cnu2 + 2*c_uv6*cd1^2*cnu1*cnu2 + c_uv5*cd1*cnu1^2*cnv2 + c_uv5*cd2*cnu1^2*cnv1 + c_uv8*cd1*cnu2*cnv1^2 + c_uv8*cd2*cnu1*cnv1^2 + c_uv9*cd1^2*cnu1*cnv2 + c_uv9*cd1^2*cnu2*cnv1 + 3*c_uv11*cd1*cnv1^2*cnv2 + 2*c_uv12*cd1^2*cnv1*cnv2 + 3*c_uv2*cnu1^2*cnu2*cnv1 + 2*c_uv4*cnu1*cnu2*cnv1^2 + 2*c_uv4*cnu1^2*cnv1*cnv2 + 3*c_uv7*cnu1*cnv1^2*cnv2 + 2*c_uv9*cd1*cd2*cnu1*cnv1 + 2*c_uv5*cd1*cnu1*cnu2*cnv1 + 2*c_uv8*cd1*cnu1*cnv1*cnv2;
c_uivi3 = c_uv3*cd3*cnu1^3 + c_uv11*cd3*cnv1^3 + 4*c_uv1*cnu1^3*cnu3 + c_uv2*cnu1^3*cnv3 + c_uv7*cnu3*cnv1^3 + 4*c_uv10*cnv1^3*cnv3 + 2*c_uv6*cd1*cd3*cnu1^2 + 2*c_uv12*cd1*cd3*cnv1^2 + 3*c_uv3*cd1*cnu1^2*cnu3 + 2*c_uv6*cd1^2*cnu1*cnu3 + c_uv5*cd1*cnu1^2*cnv3 + c_uv5*cd3*cnu1^2*cnv1 + c_uv8*cd1*cnu3*cnv1^2 + c_uv8*cd3*cnu1*cnv1^2 + c_uv9*cd1^2*cnu1*cnv3 + c_uv9*cd1^2*cnu3*cnv1 + 3*c_uv11*cd1*cnv1^2*cnv3 + 2*c_uv12*cd1^2*cnv1*cnv3 + 3*c_uv2*cnu1^2*cnu3*cnv1 + 2*c_uv4*cnu1*cnu3*cnv1^2 + 2*c_uv4*cnu1^2*cnv1*cnv3 + 3*c_uv7*cnu1*cnv1^2*cnv3 + 2*c_uv9*cd1*cd3*cnu1*cnv1 + 2*c_uv5*cd1*cnu1*cnu3*cnv1 + 2*c_uv8*cd1*cnu1*cnv1*cnv3;
c_uivi4 = c_uv6*cd1^2*cnu2^2 + c_uv6*cd2^2*cnu1^2 + c_uv12*cd1^2*cnv2^2 + c_uv12*cd2^2*cnv1^2 + 6*c_uv1*cnu1^2*cnu2^2 + c_uv4*cnu1^2*cnv2^2 + c_uv4*cnu2^2*cnv1^2 + 6*c_uv10*cnv1^2*cnv2^2 + 3*c_uv3*cd1*cnu1*cnu2^2 + 3*c_uv3*cd2*cnu1^2*cnu2 + c_uv5*cd1*cnu2^2*cnv1 + c_uv5*cd2*cnu1^2*cnv2 + c_uv8*cd1*cnu1*cnv2^2 + c_uv8*cd2*cnu2*cnv1^2 + c_uv9*cd2^2*cnu1*cnv1 + c_uv9*cd1^2*cnu2*cnv2 + 3*c_uv11*cd1*cnv1*cnv2^2 + 3*c_uv11*cd2*cnv1^2*cnv2 + 3*c_uv2*cnu1*cnu2^2*cnv1 + 3*c_uv2*cnu1^2*cnu2*cnv2 + 3*c_uv7*cnu1*cnv1*cnv2^2 + 3*c_uv7*cnu2*cnv1^2*cnv2 + 4*c_uv6*cd1*cd2*cnu1*cnu2 + 2*c_uv9*cd1*cd2*cnu1*cnv2 + 2*c_uv9*cd1*cd2*cnu2*cnv1 + 4*c_uv12*cd1*cd2*cnv1*cnv2 + 2*c_uv5*cd1*cnu1*cnu2*cnv2 + 2*c_uv5*cd2*cnu1*cnu2*cnv1 + 2*c_uv8*cd1*cnu2*cnv1*cnv2 + 2*c_uv8*cd2*cnu1*cnv1*cnv2 + 4*c_uv4*cnu1*cnu2*cnv1*cnv2;
c_uivi5 = 2*c_uv6*cd2*cd3*cnu1^2 + 2*c_uv12*cd2*cd3*cnv1^2 + 3*c_uv3*cd2*cnu1^2*cnu3 + 3*c_uv3*cd3*cnu1^2*cnu2 + 2*c_uv6*cd1^2*cnu2*cnu3 + c_uv5*cd2*cnu1^2*cnv3 + c_uv5*cd3*cnu1^2*cnv2 + c_uv8*cd2*cnu3*cnv1^2 + c_uv8*cd3*cnu2*cnv1^2 + c_uv9*cd1^2*cnu2*cnv3 + c_uv9*cd1^2*cnu3*cnv2 + 3*c_uv11*cd2*cnv1^2*cnv3 + 3*c_uv11*cd3*cnv1^2*cnv2 + 2*c_uv12*cd1^2*cnv2*cnv3 + 12*c_uv1*cnu1^2*cnu2*cnu3 + 3*c_uv2*cnu1^2*cnu2*cnv3 + 3*c_uv2*cnu1^2*cnu3*cnv2 + 2*c_uv4*cnu2*cnu3*cnv1^2 + 2*c_uv4*cnu1^2*cnv2*cnv3 + 3*c_uv7*cnu2*cnv1^2*cnv3 + 3*c_uv7*cnu3*cnv1^2*cnv2 + 12*c_uv10*cnv1^2*cnv2*cnv3 + 4*c_uv6*cd1*cd2*cnu1*cnu3 + 4*c_uv6*cd1*cd3*cnu1*cnu2 + 2*c_uv9*cd1*cd2*cnu1*cnv3 + 2*c_uv9*cd1*cd2*cnu3*cnv1 + 2*c_uv9*cd1*cd3*cnu1*cnv2 + 2*c_uv9*cd1*cd3*cnu2*cnv1 + 2*c_uv9*cd2*cd3*cnu1*cnv1 + 4*c_uv12*cd1*cd2*cnv1*cnv3 + 4*c_uv12*cd1*cd3*cnv1*cnv2 + 6*c_uv3*cd1*cnu1*cnu2*cnu3 + 2*c_uv5*cd1*cnu1*cnu2*cnv3 + 2*c_uv5*cd1*cnu1*cnu3*cnv2 + 2*c_uv5*cd1*cnu2*cnu3*cnv1 + 2*c_uv5*cd2*cnu1*cnu3*cnv1 + 2*c_uv5*cd3*cnu1*cnu2*cnv1 + 2*c_uv8*cd1*cnu1*cnv2*cnv3 + 2*c_uv8*cd1*cnu2*cnv1*cnv3 + 2*c_uv8*cd1*cnu3*cnv1*cnv2 + 2*c_uv8*cd2*cnu1*cnv1*cnv3 + 2*c_uv8*cd3*cnu1*cnv1*cnv2 + 6*c_uv11*cd1*cnv1*cnv2*cnv3 + 6*c_uv2*cnu1*cnu2*cnu3*cnv1 + 4*c_uv4*cnu1*cnu2*cnv1*cnv3 + 4*c_uv4*cnu1*cnu3*cnv1*cnv2 + 6*c_uv7*cnu1*cnv1*cnv2*cnv3;
c_uivi6 = c_uv6*cd1^2*cnu3^2 + c_uv6*cd3^2*cnu1^2 + c_uv12*cd1^2*cnv3^2 + c_uv12*cd3^2*cnv1^2 + 6*c_uv1*cnu1^2*cnu3^2 + c_uv4*cnu1^2*cnv3^2 + c_uv4*cnu3^2*cnv1^2 + 6*c_uv10*cnv1^2*cnv3^2 + 3*c_uv3*cd1*cnu1*cnu3^2 + 3*c_uv3*cd3*cnu1^2*cnu3 + c_uv5*cd1*cnu3^2*cnv1 + c_uv5*cd3*cnu1^2*cnv3 + c_uv8*cd1*cnu1*cnv3^2 + c_uv9*cd3^2*cnu1*cnv1 + c_uv8*cd3*cnu3*cnv1^2 + c_uv9*cd1^2*cnu3*cnv3 + 3*c_uv11*cd1*cnv1*cnv3^2 + 3*c_uv11*cd3*cnv1^2*cnv3 + 3*c_uv2*cnu1*cnu3^2*cnv1 + 3*c_uv2*cnu1^2*cnu3*cnv3 + 3*c_uv7*cnu1*cnv1*cnv3^2 + 3*c_uv7*cnu3*cnv1^2*cnv3 + 4*c_uv6*cd1*cd3*cnu1*cnu3 + 2*c_uv9*cd1*cd3*cnu1*cnv3 + 2*c_uv9*cd1*cd3*cnu3*cnv1 + 4*c_uv12*cd1*cd3*cnv1*cnv3 + 2*c_uv5*cd1*cnu1*cnu3*cnv3 + 2*c_uv5*cd3*cnu1*cnu3*cnv1 + 2*c_uv8*cd1*cnu3*cnv1*cnv3 + 2*c_uv8*cd3*cnu1*cnv1*cnv3 + 4*c_uv4*cnu1*cnu3*cnv1*cnv3;
c_uivi7 = c_uv3*cd1*cnu2^3 + c_uv11*cd1*cnv2^3 + 4*c_uv1*cnu1*cnu2^3 + c_uv2*cnu2^3*cnv1 + c_uv7*cnu1*cnv2^3 + 4*c_uv10*cnv1*cnv2^3 + 2*c_uv6*cd1*cd2*cnu2^2 + 2*c_uv12*cd1*cd2*cnv2^2 + 3*c_uv3*cd2*cnu1*cnu2^2 + 2*c_uv6*cd2^2*cnu1*cnu2 + c_uv5*cd1*cnu2^2*cnv2 + c_uv5*cd2*cnu2^2*cnv1 + c_uv8*cd1*cnu2*cnv2^2 + c_uv8*cd2*cnu1*cnv2^2 + c_uv9*cd2^2*cnu1*cnv2 + c_uv9*cd2^2*cnu2*cnv1 + 3*c_uv11*cd2*cnv1*cnv2^2 + 2*c_uv12*cd2^2*cnv1*cnv2 + 3*c_uv2*cnu1*cnu2^2*cnv2 + 2*c_uv4*cnu1*cnu2*cnv2^2 + 2*c_uv4*cnu2^2*cnv1*cnv2 + 3*c_uv7*cnu2*cnv1*cnv2^2 + 2*c_uv9*cd1*cd2*cnu2*cnv2 + 2*c_uv5*cd2*cnu1*cnu2*cnv2 + 2*c_uv8*cd2*cnu2*cnv1*cnv2;
c_uivi8 = 2*c_uv6*cd1*cd3*cnu2^2 + 2*c_uv12*cd1*cd3*cnv2^2 + 3*c_uv3*cd1*cnu2^2*cnu3 + 3*c_uv3*cd3*cnu1*cnu2^2 + 2*c_uv6*cd2^2*cnu1*cnu3 + c_uv5*cd1*cnu2^2*cnv3 + c_uv5*cd3*cnu2^2*cnv1 + c_uv8*cd1*cnu3*cnv2^2 + c_uv8*cd3*cnu1*cnv2^2 + c_uv9*cd2^2*cnu1*cnv3 + c_uv9*cd2^2*cnu3*cnv1 + 3*c_uv11*cd1*cnv2^2*cnv3 + 3*c_uv11*cd3*cnv1*cnv2^2 + 2*c_uv12*cd2^2*cnv1*cnv3 + 12*c_uv1*cnu1*cnu2^2*cnu3 + 3*c_uv2*cnu1*cnu2^2*cnv3 + 3*c_uv2*cnu2^2*cnu3*cnv1 + 2*c_uv4*cnu1*cnu3*cnv2^2 + 2*c_uv4*cnu2^2*cnv1*cnv3 + 3*c_uv7*cnu1*cnv2^2*cnv3 + 3*c_uv7*cnu3*cnv1*cnv2^2 + 12*c_uv10*cnv1*cnv2^2*cnv3 + 4*c_uv6*cd1*cd2*cnu2*cnu3 + 4*c_uv6*cd2*cd3*cnu1*cnu2 + 2*c_uv9*cd1*cd2*cnu2*cnv3 + 2*c_uv9*cd1*cd2*cnu3*cnv2 + 2*c_uv9*cd1*cd3*cnu2*cnv2 + 2*c_uv9*cd2*cd3*cnu1*cnv2 + 2*c_uv9*cd2*cd3*cnu2*cnv1 + 4*c_uv12*cd1*cd2*cnv2*cnv3 + 4*c_uv12*cd2*cd3*cnv1*cnv2 + 6*c_uv3*cd2*cnu1*cnu2*cnu3 + 2*c_uv5*cd1*cnu2*cnu3*cnv2 + 2*c_uv5*cd2*cnu1*cnu2*cnv3 + 2*c_uv5*cd2*cnu1*cnu3*cnv2 + 2*c_uv5*cd2*cnu2*cnu3*cnv1 + 2*c_uv5*cd3*cnu1*cnu2*cnv2 + 2*c_uv8*cd1*cnu2*cnv2*cnv3 + 2*c_uv8*cd2*cnu1*cnv2*cnv3 + 2*c_uv8*cd2*cnu2*cnv1*cnv3 + 2*c_uv8*cd2*cnu3*cnv1*cnv2 + 2*c_uv8*cd3*cnu2*cnv1*cnv2 + 6*c_uv11*cd2*cnv1*cnv2*cnv3 + 6*c_uv2*cnu1*cnu2*cnu3*cnv2 + 4*c_uv4*cnu1*cnu2*cnv2*cnv3 + 4*c_uv4*cnu2*cnu3*cnv1*cnv2 + 6*c_uv7*cnu2*cnv1*cnv2*cnv3;
c_uivi9 = 2*c_uv6*cd1*cd2*cnu3^2 + 2*c_uv12*cd1*cd2*cnv3^2 + 3*c_uv3*cd1*cnu2*cnu3^2 + 3*c_uv3*cd2*cnu1*cnu3^2 + 2*c_uv6*cd3^2*cnu1*cnu2 + c_uv5*cd1*cnu3^2*cnv2 + c_uv5*cd2*cnu3^2*cnv1 + c_uv8*cd1*cnu2*cnv3^2 + c_uv8*cd2*cnu1*cnv3^2 + c_uv9*cd3^2*cnu1*cnv2 + c_uv9*cd3^2*cnu2*cnv1 + 3*c_uv11*cd1*cnv2*cnv3^2 + 3*c_uv11*cd2*cnv1*cnv3^2 + 2*c_uv12*cd3^2*cnv1*cnv2 + 12*c_uv1*cnu1*cnu2*cnu3^2 + 3*c_uv2*cnu1*cnu3^2*cnv2 + 3*c_uv2*cnu2*cnu3^2*cnv1 + 2*c_uv4*cnu1*cnu2*cnv3^2 + 2*c_uv4*cnu3^2*cnv1*cnv2 + 3*c_uv7*cnu1*cnv2*cnv3^2 + 3*c_uv7*cnu2*cnv1*cnv3^2 + 12*c_uv10*cnv1*cnv2*cnv3^2 + 4*c_uv6*cd1*cd3*cnu2*cnu3 + 4*c_uv6*cd2*cd3*cnu1*cnu3 + 2*c_uv9*cd1*cd2*cnu3*cnv3 + 2*c_uv9*cd1*cd3*cnu2*cnv3 + 2*c_uv9*cd1*cd3*cnu3*cnv2 + 2*c_uv9*cd2*cd3*cnu1*cnv3 + 2*c_uv9*cd2*cd3*cnu3*cnv1 + 4*c_uv12*cd1*cd3*cnv2*cnv3 + 4*c_uv12*cd2*cd3*cnv1*cnv3 + 6*c_uv3*cd3*cnu1*cnu2*cnu3 + 2*c_uv5*cd1*cnu2*cnu3*cnv3 + 2*c_uv5*cd2*cnu1*cnu3*cnv3 + 2*c_uv5*cd3*cnu1*cnu2*cnv3 + 2*c_uv5*cd3*cnu1*cnu3*cnv2 + 2*c_uv5*cd3*cnu2*cnu3*cnv1 + 2*c_uv8*cd1*cnu3*cnv2*cnv3 + 2*c_uv8*cd2*cnu3*cnv1*cnv3 + 2*c_uv8*cd3*cnu1*cnv2*cnv3 + 2*c_uv8*cd3*cnu2*cnv1*cnv3 + 2*c_uv8*cd3*cnu3*cnv1*cnv2 + 6*c_uv11*cd3*cnv1*cnv2*cnv3 + 6*c_uv2*cnu1*cnu2*cnu3*cnv3 + 4*c_uv4*cnu1*cnu3*cnv2*cnv3 + 4*c_uv4*cnu2*cnu3*cnv1*cnv3 + 6*c_uv7*cnu3*cnv1*cnv2*cnv3;
c_uivi10 = c_uv3*cd1*cnu3^3 + c_uv11*cd1*cnv3^3 + 4*c_uv1*cnu1*cnu3^3 + c_uv2*cnu3^3*cnv1 + c_uv7*cnu1*cnv3^3 + 4*c_uv10*cnv1*cnv3^3 + 2*c_uv6*cd1*cd3*cnu3^2 + 2*c_uv12*cd1*cd3*cnv3^2 + 3*c_uv3*cd3*cnu1*cnu3^2 + 2*c_uv6*cd3^2*cnu1*cnu3 + c_uv5*cd1*cnu3^2*cnv3 + c_uv5*cd3*cnu3^2*cnv1 + c_uv8*cd1*cnu3*cnv3^2 + c_uv8*cd3*cnu1*cnv3^2 + c_uv9*cd3^2*cnu1*cnv3 + c_uv9*cd3^2*cnu3*cnv1 + 3*c_uv11*cd3*cnv1*cnv3^2 + 2*c_uv12*cd3^2*cnv1*cnv3 + 3*c_uv2*cnu1*cnu3^2*cnv3 + 2*c_uv4*cnu1*cnu3*cnv3^2 + 2*c_uv4*cnu3^2*cnv1*cnv3 + 3*c_uv7*cnu3*cnv1*cnv3^2 + 2*c_uv9*cd1*cd3*cnu3*cnv3 + 2*c_uv5*cd3*cnu1*cnu3*cnv3 + 2*c_uv8*cd3*cnu3*cnv1*cnv3;
c_uivi11 = c_uv1*cnu2^4 + c_uv10*cnv2^4 + c_uv6*cd2^2*cnu2^2 + c_uv12*cd2^2*cnv2^2 + c_uv4*cnu2^2*cnv2^2 + c_uv3*cd2*cnu2^3 + c_uv11*cd2*cnv2^3 + c_uv2*cnu2^3*cnv2 + c_uv7*cnu2*cnv2^3 + c_uv5*cd2*cnu2^2*cnv2 + c_uv8*cd2*cnu2*cnv2^2 + c_uv9*cd2^2*cnu2*cnv2;
c_uivi12 = c_uv3*cd3*cnu2^3 + c_uv11*cd3*cnv2^3 + 4*c_uv1*cnu2^3*cnu3 + c_uv2*cnu2^3*cnv3 + c_uv7*cnu3*cnv2^3 + 4*c_uv10*cnv2^3*cnv3 + 2*c_uv6*cd2*cd3*cnu2^2 + 2*c_uv12*cd2*cd3*cnv2^2 + 3*c_uv3*cd2*cnu2^2*cnu3 + 2*c_uv6*cd2^2*cnu2*cnu3 + c_uv5*cd2*cnu2^2*cnv3 + c_uv5*cd3*cnu2^2*cnv2 + c_uv8*cd2*cnu3*cnv2^2 + c_uv8*cd3*cnu2*cnv2^2 + c_uv9*cd2^2*cnu2*cnv3 + c_uv9*cd2^2*cnu3*cnv2 + 3*c_uv11*cd2*cnv2^2*cnv3 + 2*c_uv12*cd2^2*cnv2*cnv3 + 3*c_uv2*cnu2^2*cnu3*cnv2 + 2*c_uv4*cnu2*cnu3*cnv2^2 + 2*c_uv4*cnu2^2*cnv2*cnv3 + 3*c_uv7*cnu2*cnv2^2*cnv3 + 2*c_uv9*cd2*cd3*cnu2*cnv2 + 2*c_uv5*cd2*cnu2*cnu3*cnv2 + 2*c_uv8*cd2*cnu2*cnv2*cnv3;
c_uivi13 = c_uv6*cd2^2*cnu3^2 + c_uv6*cd3^2*cnu2^2 + c_uv12*cd2^2*cnv3^2 + c_uv12*cd3^2*cnv2^2 + 6*c_uv1*cnu2^2*cnu3^2 + c_uv4*cnu2^2*cnv3^2 + c_uv4*cnu3^2*cnv2^2 + 6*c_uv10*cnv2^2*cnv3^2 + 3*c_uv3*cd2*cnu2*cnu3^2 + 3*c_uv3*cd3*cnu2^2*cnu3 + c_uv5*cd2*cnu3^2*cnv2 + c_uv5*cd3*cnu2^2*cnv3 + c_uv8*cd2*cnu2*cnv3^2 + c_uv8*cd3*cnu3*cnv2^2 + c_uv9*cd3^2*cnu2*cnv2 + c_uv9*cd2^2*cnu3*cnv3 + 3*c_uv11*cd2*cnv2*cnv3^2 + 3*c_uv11*cd3*cnv2^2*cnv3 + 3*c_uv2*cnu2*cnu3^2*cnv2 + 3*c_uv2*cnu2^2*cnu3*cnv3 + 3*c_uv7*cnu2*cnv2*cnv3^2 + 3*c_uv7*cnu3*cnv2^2*cnv3 + 4*c_uv6*cd2*cd3*cnu2*cnu3 + 2*c_uv9*cd2*cd3*cnu2*cnv3 + 2*c_uv9*cd2*cd3*cnu3*cnv2 + 4*c_uv12*cd2*cd3*cnv2*cnv3 + 2*c_uv5*cd2*cnu2*cnu3*cnv3 + 2*c_uv5*cd3*cnu2*cnu3*cnv2 + 2*c_uv8*cd2*cnu3*cnv2*cnv3 + 2*c_uv8*cd3*cnu2*cnv2*cnv3 + 4*c_uv4*cnu2*cnu3*cnv2*cnv3;
c_uivi14 = c_uv3*cd2*cnu3^3 + c_uv11*cd2*cnv3^3 + 4*c_uv1*cnu2*cnu3^3 + c_uv2*cnu3^3*cnv2 + c_uv7*cnu2*cnv3^3 + 4*c_uv10*cnv2*cnv3^3 + 2*c_uv6*cd2*cd3*cnu3^2 + 2*c_uv12*cd2*cd3*cnv3^2 + 3*c_uv3*cd3*cnu2*cnu3^2 + 2*c_uv6*cd3^2*cnu2*cnu3 + c_uv5*cd2*cnu3^2*cnv3 + c_uv5*cd3*cnu3^2*cnv2 + c_uv8*cd2*cnu3*cnv3^2 + c_uv8*cd3*cnu2*cnv3^2 + c_uv9*cd3^2*cnu2*cnv3 + c_uv9*cd3^2*cnu3*cnv2 + 3*c_uv11*cd3*cnv2*cnv3^2 + 2*c_uv12*cd3^2*cnv2*cnv3 + 3*c_uv2*cnu2*cnu3^2*cnv3 + 2*c_uv4*cnu2*cnu3*cnv3^2 + 2*c_uv4*cnu3^2*cnv2*cnv3 + 3*c_uv7*cnu3*cnv2*cnv3^2 + 2*c_uv9*cd2*cd3*cnu3*cnv3 + 2*c_uv5*cd3*cnu2*cnu3*cnv3 + 2*c_uv8*cd3*cnu3*cnv2*cnv3;
c_uivi15 = c_uv1*cnu3^4 + c_uv10*cnv3^4 + c_uv6*cd3^2*cnu3^2 + c_uv12*cd3^2*cnv3^2 + c_uv4*cnu3^2*cnv3^2 + c_uv3*cd3*cnu3^3 + c_uv11*cd3*cnv3^3 + c_uv2*cnu3^3*cnv3 + c_uv7*cnu3*cnv3^3 + c_uv5*cd3*cnu3^2*cnv3 + c_uv8*cd3*cnu3*cnv3^2 + c_uv9*cd3^2*cnu3*cnv3;

vi_ = plot_size(3):1:plot_size(4);
point_to_plot = zeros(2*2*numel(vi_),2);
item_point_to_plot = 1;
for vi = vi_
    coeffs_ui = [ c_uivi1, c_uivi3 + c_uivi2*vi, c_uivi6 + c_uivi5*vi + c_uivi4*vi^2, c_uivi10 + c_uivi9*vi + c_uivi7*vi^3 + c_uivi8*vi^2, c_uivi15 + c_uivi14*vi + c_uivi11*vi^4 + c_uivi12*vi^3 + c_uivi13*vi^2 ];
    ui_ = roots(coeffs_ui);
    ui_(imag(ui_) ~= 0) = [];

    for iter = 1: numel(ui_)
        ui = ui_(iter);
        point_to_plot(item_point_to_plot,:) = [ui,vi];
        item_point_to_plot = item_point_to_plot + 1;
    end
end

ui_ = plot_size(3):1:plot_size(4);
for ui = ui_
    coeffs_vi = [ c_uivi11, c_uivi12 + c_uivi7*ui, c_uivi13 + c_uivi8*ui + c_uivi4*ui^2, c_uivi14 + c_uivi9*ui + c_uivi2*ui^3 + c_uivi5*ui^2, c_uivi15 + c_uivi10*ui + c_uivi1*ui^4 + c_uivi3*ui^3 + c_uivi6*ui^2 ];
    vi_ = roots(coeffs_vi);
    vi_(imag(vi_) ~= 0) = [];

    for iter = 1: numel(vi_)
        vi = vi_(iter);
        point_to_plot(item_point_to_plot,:) = [ui,vi];
        item_point_to_plot = item_point_to_plot + 1;
    end
end

point_to_plot( all(~point_to_plot,2), : ) = [];
plot(point_to_plot(:,1),point_to_plot(:,2),'o','Color', line_color, 'MarkerSize',1);

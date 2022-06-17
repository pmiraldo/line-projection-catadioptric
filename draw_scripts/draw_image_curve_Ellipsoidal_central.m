function draw_image_curve_Ellipsoidal_central( ... 
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
k = -(A*c_3^2)/(2*(A - 1));

cnu1 = h2_2*h3_3 - h2_3*h3_2;
cnu2 = h1_3*h3_2 - h1_2*h3_3;
cnu3 = h1_2*h2_3 - h1_3*h2_2;
cnv1 = h2_3*h3_1 - h2_1*h3_3;
cnv2 = h1_1*h3_3 - h1_3*h3_1;
cnv3 = h1_3*h2_1 - h1_1*h2_3;
cd1 = h2_1*h3_2 - h2_2*h3_1;
cd2 = h1_2*h3_1 - h1_1*h3_2;
cd3 = h1_1*h2_2 - h1_2*h2_1;

c_uv1 = c_3^4*q_1^2*s_2^2 + c_3^4*q_2^2*s_1^2 - k^2*q_2^2*s_3^2 - k^2*q_3^2*s_2^2 + 2*c_3^2*k*q_1^2*s_2^2 + 2*c_3^2*k*q_2^2*s_1^2 - 2*c_3^4*q_1*q_2*s_1*s_2 + 2*k^2*q_2*q_3*s_2*s_3 - 4*c_3^2*k*q_1*q_2*s_1*s_2;
c_uv2 = 2*k^2*q_1*q_2*s_3^2 + 2*k^2*q_3^2*s_1*s_2 - 2*k^2*q_1*q_3*s_2*s_3 - 2*k^2*q_2*q_3*s_1*s_3;
c_uv3 = 2*k^2*q_1*q_3*s_2^2 + 2*k^2*q_2^2*s_1*s_3 + 2*c_3^2*k*q_1*q_3*s_2^2 + 2*c_3^2*k*q_2^2*s_1*s_3 - 2*k^2*q_1*q_2*s_2*s_3 - 2*k^2*q_2*q_3*s_1*s_2 - 2*c_3^2*k*q_1*q_2*s_2*s_3 - 2*c_3^2*k*q_2*q_3*s_1*s_2;
c_uv4 = c_3^4*q_1^2*s_2^2 + c_3^4*q_2^2*s_1^2 - k^2*q_1^2*s_3^2 - k^2*q_3^2*s_1^2 + 2*c_3^2*k*q_1^2*s_2^2 + 2*c_3^2*k*q_2^2*s_1^2 - 2*c_3^4*q_1*q_2*s_1*s_2 + 2*k^2*q_1*q_3*s_1*s_3 - 4*c_3^2*k*q_1*q_2*s_1*s_2;
c_uv5 = 2*k^2*q_2*q_3*s_1^2 + 2*k^2*q_1^2*s_2*s_3 + 2*c_3^2*k*q_2*q_3*s_1^2 + 2*c_3^2*k*q_1^2*s_2*s_3 - 2*k^2*q_1*q_2*s_1*s_3 - 2*k^2*q_1*q_3*s_1*s_2 - 2*c_3^2*k*q_1*q_2*s_1*s_3 - 2*c_3^2*k*q_1*q_3*s_1*s_2;
c_uv6 = 2*k^2*q_1*q_2*s_1*s_2 - k^2*q_2^2*s_1^2 - k^2*q_1^2*s_2^2;

c_uivi1 = c_uv6*cd1^2 + c_uv1*cnu1^2 + c_uv4*cnv1^2 + c_uv3*cd1*cnu1 + c_uv5*cd1*cnv1 + c_uv2*cnu1*cnv1;
c_uivi2 = 2*c_uv6*cd1*cd2 + c_uv3*cd1*cnu2 + c_uv3*cd2*cnu1 + c_uv5*cd1*cnv2 + c_uv5*cd2*cnv1 + 2*c_uv1*cnu1*cnu2 + c_uv2*cnu1*cnv2 + c_uv2*cnu2*cnv1 + 2*c_uv4*cnv1*cnv2;
c_uivi3 = 2*c_uv6*cd1*cd3 + c_uv3*cd1*cnu3 + c_uv3*cd3*cnu1 + c_uv5*cd1*cnv3 + c_uv5*cd3*cnv1 + 2*c_uv1*cnu1*cnu3 + c_uv2*cnu1*cnv3 + c_uv2*cnu3*cnv1 + 2*c_uv4*cnv1*cnv3;
c_uivi4 = c_uv6*cd2^2 + c_uv1*cnu2^2 + c_uv4*cnv2^2 + c_uv3*cd2*cnu2 + c_uv5*cd2*cnv2 + c_uv2*cnu2*cnv2;
c_uivi5 = 2*c_uv6*cd2*cd3 + c_uv3*cd2*cnu3 + c_uv3*cd3*cnu2 + c_uv5*cd2*cnv3 + c_uv5*cd3*cnv2 + 2*c_uv1*cnu2*cnu3 + c_uv2*cnu2*cnv3 + c_uv2*cnu3*cnv2 + 2*c_uv4*cnv2*cnv3;
c_uivi6 = c_uv6*cd3^2 + c_uv1*cnu3^2 + c_uv4*cnv3^2 + c_uv3*cd3*cnu3 + c_uv5*cd3*cnv3 + c_uv2*cnu3*cnv3;

vi_ = plot_size(3):1:plot_size(4);
point_to_plot = zeros(2*2*numel(vi_),2);
item_point_to_plot = 1;
for vi = vi_
    coeffs_ui = [ c_uivi1, c_uivi3 + c_uivi2*vi, c_uivi6 + c_uivi5*vi + c_uivi4*vi^2 ];
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
    coeffs_vi = [ c_uivi4, c_uivi5 + c_uivi2*ui, c_uivi6 + c_uivi3*ui + c_uivi1*ui^2 ];
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

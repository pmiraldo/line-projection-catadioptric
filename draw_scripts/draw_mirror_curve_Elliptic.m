function draw_mirror_curve_Elliptic(...
    A, B, C, ...
    c, s, q, ...
    plot_set ...
    )

arguments
    A double
    B double
    C double
    c (3,1) double
    s (3,1) double
    q (3,1) double
    plot_set.zmin double = -inf
    plot_set.zmax double = inf
    plot_set.xymax double = 1.0
    plot_set.line_color (1,3) double = [1,0,0]
end

if c(1) ~= 0
    disp('ERR: c_1 must be 0')
    exit()
end
c_2 = c(2);
c_3 = c(3);

s_1 = s(1); s_2 = s(2); s_3 = s(3);
q_1 = q(1); q_2 = q(2); q_3 = q(3);

zmin = plot_set.zmin;
zmax = plot_set.zmax;
xymax = plot_set.xymax;
line_color = plot_set.line_color;

item_point_to_plot = 1;
t = [0;c_2;c_3];

c_xy1 = 4*s_2;
c_xy2 = -4*s_1;
c_xy3 = 4*q_2*s_1 - 4*q_1*s_2 - 4*c_2*s_1;
c_xy4 = 8*s_2;
c_xy5 = -8*c_2*s_2;
c_xy6 = 2*B^2*s_2 - 4*B*c_2*s_3;
c_xy7 = -8*s_1;
c_xy8 = 8*q_2*s_1 - 8*q_1*s_2;
c_xy9 = -2*B^2*s_1;
c_xy10 = 3*B^2*q_2*s_1 - 3*B^2*q_1*s_2 - B^2*c_2*s_1 + 4*B*c_2*q_1*s_3 - 4*B*c_2*q_3*s_1 - 4*B*c_3*q_1*s_2 + 4*B*c_3*q_2*s_1;
c_xy11 = 4*s_2;
c_xy12 = -8*c_2*s_2;
c_xy13 = 2*B^2*s_2 - 4*B*c_2*s_3;
c_xy14 = 8*B*c_2*q_2*s_3 - 4*B^2*c_2*s_2 - 8*B*c_2*q_3*s_2;
c_xy15 = B^3*q_2*s_3 - B^3*c_3*s_2 - B^3*c_2*s_3 - B^3*q_3*s_2 + 4*B^2*c_3*q_2*s_3 - 4*B^2*c_3*q_3*s_2;
c_xy16 = -4*s_1;
c_xy17 = 4*c_2*s_1 - 4*q_1*s_2 + 4*q_2*s_1;
c_xy18 = -2*B^2*s_1;
c_xy19 = 3*B^2*c_2*s_1 - 3*B^2*q_1*s_2 + 3*B^2*q_2*s_1 - 4*B*c_2*q_1*s_3 + 4*B*c_2*q_3*s_1 - 4*B*c_3*q_1*s_2 + 4*B*c_3*q_2*s_1;
c_xy20 = B^3*c_3*s_1 - B^3*q_1*s_3 + B^3*q_3*s_1 + 4*B^2*c_2*q_1*s_2 - 4*B^2*c_2*q_2*s_1 - 4*B^2*c_3*q_1*s_3 + 4*B^2*c_3*q_3*s_1;
c_xy21 = B^3*c_2*q_1*s_3 - B^3*c_2*q_3*s_1 + B^3*c_3*q_1*s_2 - B^3*c_3*q_2*s_1;

y_ = -xymax:.1:xymax;
point_to_plot = zeros(2*2*numel(y_), 3);

for y = y_

    poly_x = [ c_xy1, c_xy3 + c_xy2*y, c_xy6 + c_xy5*y + c_xy4*y^2, c_xy10 + c_xy9*y + c_xy7*y^3 + c_xy8*y^2, c_xy15 + c_xy14*y + c_xy11*y^4 + c_xy12*y^3 + c_xy13*y^2, c_xy21 + c_xy20*y + c_xy16*y^5 + c_xy17*y^4 + c_xy18*y^3 + c_xy19*y^2 ];

    x_ = roots(poly_x);
    x_(imag(x_) ~= 0) = [];
    if isempty(x_), continue, end

    for iter = 1: numel(x_)
        x = x_(iter);

        if A == 0
            z1 = -(x^2+y^2)/B;
            z2 = Inf;
        else
            z1 = -(B - (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A);
            z2 = -(B + (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A); 
        end

        r = [x;y;z1];
        vi = r - t;
        n = [x;y;B/2 + A*z1]; n = n/norm(n);
        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);
        dist1 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);

        r = [x;y;z2];
        vi = r - t;
        n = [x;y;B/2 + A*z2]; n = n/norm(n);
        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);
        dist2 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);

        if abs(dist1) < .1 && z1 < zmax && z1 > zmin
            point_to_plot(item_point_to_plot,:) = [x,y,z1];
            item_point_to_plot = item_point_to_plot + 1;
        end
        if abs(dist2) < .1  && z2 < zmax && z2 > zmin
            point_to_plot(item_point_to_plot,:) = [x,y,z2];
            item_point_to_plot = item_point_to_plot + 1;
        end
    end

end

x_ = -xymax:.1:xymax;

for x = x_

    poly_y = [ c_xy16, c_xy17 + c_xy11*x, c_xy18 + c_xy12*x + c_xy7*x^2, c_xy19 + c_xy13*x + c_xy4*x^3 + c_xy8*x^2, c_xy20 + c_xy14*x + c_xy2*x^4 + c_xy5*x^3 + c_xy9*x^2, c_xy21 + c_xy15*x + c_xy1*x^5 + c_xy3*x^4 + c_xy6*x^3 + c_xy10*x^2 ];

    y_ = roots(poly_y);
    y_(imag(y_) ~= 0) = [];
    if isempty(y_), continue, end

    for iter = 1: numel(y_)
        y = y_(iter);

        if A == 0
            z1 = -(x^2+y^2)/B;
            z2 = Inf;
        else
            z1 = -(B - (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A);
            z2 = -(B + (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A); 
        end

        r = [x;y;z1];
        vi = r - t;
        n = [x;y;B/2 + A*z1]; n = n/norm(n);
        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);
        dist1 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);

        r = [x;y;z2];
        vi = r - t;
        n = [x;y;B/2 + A*z2]; n = n/norm(n);
        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);
        dist2 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);

        if abs(dist1) < .1 && z1 < zmax && z1 > zmin
            point_to_plot(item_point_to_plot,:) = [x,y,z1];
            item_point_to_plot = item_point_to_plot + 1;
        end
        if abs(dist2) < .1  && z2 < zmax && z2 > zmin
            point_to_plot(item_point_to_plot,:) = [x,y,z2];
            item_point_to_plot = item_point_to_plot + 1;
        end
    end

end

point_to_plot( all(~point_to_plot,2), : ) = [];
plot3(point_to_plot(:,1),point_to_plot(:,2),point_to_plot(:,3),'o','Color', line_color, 'MarkerSize',1);

end

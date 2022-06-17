function curve_mirror(model_name, monomials, coeff, values,  coeffs_x, coeffs_y)

arguments
    model_name char
    monomials cell
    coeff cell
    values cell
    coeffs_x (1,:) sym
    coeffs_y (1,:) sym
end

cd('draw_scripts')
file = ['draw_mirror_curve_', model_name];
disp(['<strong>Saving polynomial curve in the mirror</strong> -- file: ', file])

fid_output = fopen([file,'.m'], 'wt');


fprintf(fid_output, ['function ', file, '(...\n']);
% fprintf(fid_output, '    A, B, C, c_3, s_1, s_2, s_3, q_1, q_2, q_3, zmin, zmax, xymax, line_color)\n');
fprintf(fid_output, '    A, B, C, ...\n');
fprintf(fid_output, '    c, s, q, ...\n');
fprintf(fid_output, '    plot_set ...\n');
fprintf(fid_output, '    )\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'arguments\n');
fprintf(fid_output, '    A double\n');
fprintf(fid_output, '    B double\n');
fprintf(fid_output, '    C double\n');
fprintf(fid_output, '    c (3,1) double\n');
fprintf(fid_output, '    s (3,1) double\n');
fprintf(fid_output, '    q (3,1) double\n');
fprintf(fid_output, '    plot_set.zmin double = -inf\n');
fprintf(fid_output, '    plot_set.zmax double = inf\n');
fprintf(fid_output, '    plot_set.xymax double = 1.0\n');
fprintf(fid_output, '    plot_set.line_color (1,3) double = [1,0,0]\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'if c(1) ~= 0\n');
fprintf(fid_output, "    disp('ERR: c_1 must be 0')\n");
fprintf(fid_output, '    exit()\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, 'c_2 = c(2);\n');
fprintf(fid_output, 'c_3 = c(3);\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 's_1 = s(1); s_2 = s(2); s_3 = s(3);\n');
fprintf(fid_output, 'q_1 = q(1); q_2 = q(2); q_3 = q(3);\n');
if strcmp(model_name,'Hyperboloidal_central'), fprintf(fid_output, 'k = -2/A + 2;\n'); end
if strcmp(model_name,'Ellipsoidal_central'), fprintf(fid_output, 'k = -(A*c_3^2)/(2*(A - 1));\n'); end
fprintf(fid_output, '\n');
fprintf(fid_output, 'zmin = plot_set.zmin;\n');
fprintf(fid_output, 'zmax = plot_set.zmax;\n');
fprintf(fid_output, 'xymax = plot_set.xymax;\n');
fprintf(fid_output, 'line_color = plot_set.line_color;\n');
%
fprintf(fid_output, '\n');
fprintf(fid_output, 'item_point_to_plot = 1;\n');
fprintf(fid_output, 't = [0;c_2;c_3];\n');
fprintf(fid_output, '\n');
for int = 1 : numel(coeff)
    to_plot = [coeff{int}, ' = ', char(values{int}), ';'];
    fprintf(fid_output, '%s\n', to_plot);
end
fprintf(fid_output, '\n');
fprintf(fid_output, 'y_ = -xymax:.1:xymax;\n');
fprintf(fid_output, 'point_to_plot = zeros(2*2*numel(y_), 3);\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'for y = y_\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    poly_x = [ ');
for iter = 1 : numel(coeffs_x)
    if iter == 1
        fprintf(fid_output, '%s', coeffs_x(iter));
    else
        fprintf(fid_output, ', %s', coeffs_x(iter));
    end
end
fprintf(fid_output, ' ];\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    x_ = roots(poly_x);\n');
fprintf(fid_output, '    x_(imag(x_) ~= 0) = [];\n');
fprintf(fid_output, '    if isempty(x_), continue, end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    for iter = 1: numel(x_)\n');
fprintf(fid_output, '        x = x_(iter);\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '        if A == 0\n');
fprintf(fid_output, '            z1 = -(x^2+y^2)/B;\n');
fprintf(fid_output, '            z2 = Inf;\n');
fprintf(fid_output, '        else\n');
fprintf(fid_output, '            z1 = -(B - (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A);\n');
fprintf(fid_output, '            z2 = -(B + (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A); \n');       
fprintf(fid_output, '        end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '        r = [x;y;z1];\n');
fprintf(fid_output, '        vi = r - t;\n');
fprintf(fid_output, '        n = [x;y;B/2 + A*z1]; n = n/norm(n);\n');
fprintf(fid_output, "        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);\n");
fprintf(fid_output, "        dist1 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);\n");
fprintf(fid_output, '\n');
fprintf(fid_output, '        r = [x;y;z2];\n');
fprintf(fid_output, '        vi = r - t;\n');
fprintf(fid_output, '        n = [x;y;B/2 + A*z2]; n = n/norm(n);\n');
fprintf(fid_output, "        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);\n");
fprintf(fid_output, "        dist2 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);\n");
fprintf(fid_output, '\n');
fprintf(fid_output, '        if abs(dist1) < .1 && z1 < zmax && z1 > zmin\n');
fprintf(fid_output, '            point_to_plot(item_point_to_plot,:) = [x,y,z1];\n');
fprintf(fid_output, '            item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '        end\n');
fprintf(fid_output, '        if abs(dist2) < .1  && z2 < zmax && z2 > zmin\n');
fprintf(fid_output, '            point_to_plot(item_point_to_plot,:) = [x,y,z2];\n');
fprintf(fid_output, '            item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '        end\n');
fprintf(fid_output, '    end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');

fprintf(fid_output, 'x_ = -xymax:.1:xymax;\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'for x = x_\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    poly_y = [ ');
for iter = 1 : numel(coeffs_y)
    if iter == 1
        fprintf(fid_output, '%s', coeffs_y(iter));
    else
        fprintf(fid_output, ', %s', coeffs_y(iter));
    end
end
fprintf(fid_output, ' ];\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    y_ = roots(poly_y);\n');
fprintf(fid_output, '    y_(imag(y_) ~= 0) = [];\n');
fprintf(fid_output, '    if isempty(y_), continue, end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    for iter = 1: numel(y_)\n');
fprintf(fid_output, '        y = y_(iter);\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '        if A == 0\n');
fprintf(fid_output, '            z1 = -(x^2+y^2)/B;\n');
fprintf(fid_output, '            z2 = Inf;\n');
fprintf(fid_output, '        else\n');
fprintf(fid_output, '            z1 = -(B - (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A);\n');
fprintf(fid_output, '            z2 = -(B + (B^2 - 4*A*x^2 - 4*A*y^2 + 4*A*C)^(1/2))/(2*A); \n');       
fprintf(fid_output, '        end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '        r = [x;y;z1];\n');
fprintf(fid_output, '        vi = r - t;\n');
fprintf(fid_output, '        n = [x;y;B/2 + A*z1]; n = n/norm(n);\n');
fprintf(fid_output, "        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);\n");
fprintf(fid_output, "        dist1 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);\n");
fprintf(fid_output, '\n');
fprintf(fid_output, '        r = [x;y;z2];\n');
fprintf(fid_output, '        vi = r - t;\n');
fprintf(fid_output, '        n = [x;y;B/2 + A*z2]; n = n/norm(n);\n');
fprintf(fid_output, "        vr = vi - 2*(vi'*n)*n; vr = vr/norm(vr);\n");
fprintf(fid_output, "        dist2 = line_to_line_distance(r, vr, [q_1, q_2, q_3]', [s_1, s_2, s_3]',0);\n");
fprintf(fid_output, '\n');
fprintf(fid_output, '        if abs(dist1) < .1 && z1 < zmax && z1 > zmin\n');
fprintf(fid_output, '            point_to_plot(item_point_to_plot,:) = [x,y,z1];\n');
fprintf(fid_output, '            item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '        end\n');
fprintf(fid_output, '        if abs(dist2) < .1  && z2 < zmax && z2 > zmin\n');
fprintf(fid_output, '            point_to_plot(item_point_to_plot,:) = [x,y,z2];\n');
fprintf(fid_output, '            item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '        end\n');
fprintf(fid_output, '    end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'point_to_plot( all(~point_to_plot,2), : ) = [];\n');
fprintf(fid_output, "plot3(point_to_plot(:,1),point_to_plot(:,2),point_to_plot(:,3),'o','Color', line_color, 'MarkerSize',1);\n");
fprintf(fid_output, '\n');

fprintf(fid_output, 'end\n');
cd('..')

end
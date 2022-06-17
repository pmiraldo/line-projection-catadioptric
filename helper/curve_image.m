function curve_image(...
    model_name,...
    monomials, coeff, values, ...
    coeff_init, values_init, ...
    coeffs_ui, coeffs_vi ...
    )

arguments
    model_name char
    monomials cell
    coeff cell
    values cell
    coeff_init cell
    values_init cell
    coeffs_ui (1,:) sym
    coeffs_vi (1,:) sym
end

cd('draw_scripts')
file = ['draw_image_curve_', model_name];
fid_output = fopen([file,'.m'], 'wt');

disp(['<strong>Saving polynomial equations</strong> -- file: ', file])

fprintf(fid_output, 'function %s( ... \n', file);
fprintf(fid_output, '    A, B, C, c, H,...\n');
fprintf(fid_output, '    s, q, ...\n');
fprintf(fid_output, '    plot_size, line_color, density...\n');
fprintf(fid_output, '    )\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'arguments\n');
fprintf(fid_output, '    A double\n');
fprintf(fid_output, '    B double\n');
fprintf(fid_output, '    C double\n');
fprintf(fid_output, '    c double\n');
fprintf(fid_output, '    H (3,3) double\n');
fprintf(fid_output, '    s (3,1) double\n');
fprintf(fid_output, '    q (3,1) double\n');
fprintf(fid_output, '    plot_size (1,4) double = zeros(1,4)\n');
fprintf(fid_output, '    line_color (1,3) double = zeros(1,3)\n');
fprintf(fid_output, '    density double = 150\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, "warning('off')");
fprintf(fid_output, '\n');
fprintf(fid_output, 's_1 = s(1); s_2 = s(2); s_3 = s(3);\n');
fprintf(fid_output, 'q_1 = q(1); q_2 = q(2); q_3 = q(3);\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'h1_1 = H(1,1); h1_2 = H(1,2); h1_3 = H(1,3);\n');
fprintf(fid_output, 'h2_1 = H(2,1); h2_2 = H(2,2); h2_3 = H(2,3);\n');
fprintf(fid_output, 'h3_1 = H(3,1); h3_2 = H(3,2); h3_3 = H(3,3);\n');
fprintf(fid_output, 'if c(1) ~= 0\n');
fprintf(fid_output, "    disp('ERR: c_1 must be 0')\n");
fprintf(fid_output, '    exit()\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, 'c_2 = c(2); c_3 = c(3);\n');
if strcmp(model_name,'Hyperboloidal_central'), fprintf(fid_output, 'k = -2/A + 2;\n'); end
if strcmp(model_name,'Ellipsoidal_central'), fprintf(fid_output, 'k = -(A*c_3^2)/(2*(A - 1));\n'); end
fprintf(fid_output, '\n');
fprintf(fid_output, 'cnu1 = h2_2*h3_3 - h2_3*h3_2;\n');
fprintf(fid_output, 'cnu2 = h1_3*h3_2 - h1_2*h3_3;\n');
fprintf(fid_output, 'cnu3 = h1_2*h2_3 - h1_3*h2_2;\n');
fprintf(fid_output, 'cnv1 = h2_3*h3_1 - h2_1*h3_3;\n');
fprintf(fid_output, 'cnv2 = h1_1*h3_3 - h1_3*h3_1;\n');
fprintf(fid_output, 'cnv3 = h1_3*h2_1 - h1_1*h2_3;\n');
fprintf(fid_output, 'cd1 = h2_1*h3_2 - h2_2*h3_1;\n');
fprintf(fid_output, 'cd2 = h1_2*h3_1 - h1_1*h3_2;\n');
fprintf(fid_output, 'cd3 = h1_1*h2_2 - h1_2*h2_1;\n');

fprintf(fid_output, '\n');

for int = 1 : numel(coeff_init)
    to_plot = [coeff_init{int}, ' = ', char(values_init{int}), ';'];
    fprintf(fid_output, '%s\n', to_plot);
end

fprintf(fid_output, '\n');

for int = 1 : numel(coeff)
    to_plot = [coeff{int}, ' = ', char(values{int}), ';'];
    fprintf(fid_output, '%s\n', to_plot);
end

fprintf(fid_output, '\n');

% f1_array = ['f1 = @(ui,vi) '];
% 
% for int = 1 : numel(coeff_init)
%     if int == 1
%         f1_array = [f1_array, char(coeff{int}*monomials{int})];
%     else
%         f1_array = [f1_array, ' + ', char(coeff{int}*monomials{int})];
%     end
% end
% 
% fprintf(fid_output, '%s;\n', f1_array);
% fprintf(fid_output, "fimplicit(f1,plot_size, 'Color', line_color, 'MeshDensity', density, 'LineWidth', 1)\n");
% fprintf(fid_output, '\n');
% fprintf(fid_output, 'end\n');

fprintf(fid_output, 'vi_ = plot_size(3):1:plot_size(4);\n');
fprintf(fid_output, 'point_to_plot = zeros(2*2*numel(vi_),2);\n');
fprintf(fid_output, 'item_point_to_plot = 1;\n');
fprintf(fid_output, 'for vi = vi_\n');
fprintf(fid_output, '    coeffs_ui = [ ');
for iter = 1 : numel(coeffs_ui)
    if iter == 1
        fprintf(fid_output, '%s', coeffs_ui(iter));
    else
        fprintf(fid_output, ', %s', coeffs_ui(iter));
    end
end
fprintf(fid_output, ' ];\n');
fprintf(fid_output, '    ui_ = roots(coeffs_ui);\n');
fprintf(fid_output, '    ui_(imag(ui_) ~= 0) = [];\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    for iter = 1: numel(ui_)\n');
fprintf(fid_output, '        ui = ui_(iter);\n');
fprintf(fid_output, '        point_to_plot(item_point_to_plot,:) = [ui,vi];\n');
fprintf(fid_output, '        item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '    end\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'ui_ = plot_size(3):1:plot_size(4);\n');
fprintf(fid_output, 'for ui = ui_\n');
fprintf(fid_output, '    coeffs_vi = [ ');
for iter = 1 : numel(coeffs_vi)
    if iter == 1
        fprintf(fid_output, '%s', coeffs_vi(iter));
    else
        fprintf(fid_output, ', %s', coeffs_vi(iter));
    end
end
fprintf(fid_output, ' ];\n');
fprintf(fid_output, '    vi_ = roots(coeffs_vi);\n');
fprintf(fid_output, '    vi_(imag(vi_) ~= 0) = [];\n');
fprintf(fid_output, '\n');
fprintf(fid_output, '    for iter = 1: numel(vi_)\n');
fprintf(fid_output, '        vi = vi_(iter);\n');
fprintf(fid_output, '        point_to_plot(item_point_to_plot,:) = [ui,vi];\n');
fprintf(fid_output, '        item_point_to_plot = item_point_to_plot + 1;\n');
fprintf(fid_output, '    end\n');
fprintf(fid_output, 'end\n');
fprintf(fid_output, '\n');
fprintf(fid_output, 'point_to_plot( all(~point_to_plot,2), : ) = [];\n');
fprintf(fid_output, "plot(point_to_plot(:,1),point_to_plot(:,2),'o','Color', line_color, 'MarkerSize',1);\n");

fclose(fid_output);
cd('..')

end

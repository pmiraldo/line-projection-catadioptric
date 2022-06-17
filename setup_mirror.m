function [t, K, R, A, B, C, zmin, zmax, xymax, draw_image_curve, draw_mirror_curve] = setup_mirror()

addpath('draw_scripts')

disp('Select the model:');
disp('  1) General');
disp('  2) Sphere');
disp('  3) Axial Cone');
% disp('  4) Axial General');
disp('  5) Elliptic');
disp('  6) Parabolic');
disp('  7) Hyperboloidal central');
disp('  8) Ellipsoidal central');
prompt = '... ';
model = input(prompt);

draw_image_curve = 0;
draw_mirror_curve = 0;


switch(model)
    
   case 1
        % model_name = 'General';
        c_2 = 10;
        c_3 = 30;
        t = [0;c_2;c_3];
        K = [750, 0, 600; 0, 750, 400; 0, 0, 1];
        % R = eye(3);
        R = angle2dcm(0,0,pi);
        A = -1.2;
        B = -1.4;
        C = -23.2;

        zmin = -25;
        zmax = 0;
        xymax = 50;
        
        if ~exist('draw_image_curve_General')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_General;
        draw_mirror_curve = @draw_mirror_curve_General;
    
    case 2
        % model_name = 'Sphere';
        c_2 = 4; c_3 = 25;
        t = [0;c_2;c_3];
        K = [750, 0, 600; 0, 750, 400; 0, 0, 1];
        R = angle2dcm(0,0,pi);
        A = 1;
        B = 0;
        C = 150;
        zmin = -25;
        zmax = 25;
        xymax = 50;
        
        if ~exist('draw_image_curve_Sphere')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Sphere;
        draw_mirror_curve = @draw_mirror_curve_Sphere;
        
    case 3
        % model_name = 'Axial_Cone';
        c_3 = 25;
        t = [0;0;c_3];
        K = [1500, 0, 600; 0, 1500, 400; 0, 0, 1];
        R = angle2dcm(0,0,pi);
        A = -1; B = 0; C = 0;
        zmin = -25; zmax = 0; xymax = 50;

        if ~exist('draw_image_curve_Axial_Cone')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Axial_Cone;
        draw_mirror_curve = @draw_mirror_curve_Axial_Cone;
        
    case 5
        % model_name = 'Elliptic';
        c_2 = 2;
        c_3 = 35;
        t = [0;c_2;c_3];
        % projection parameters H
        K = [1500, 0, 600; 0, 1500, 400; 0, 0, 1];
        R = angle2dcm(0,0,pi);
        A = 0; B = 10; C = 0;
        zmin = -25; zmax = 0; xymax = 50;
        
        if ~exist('draw_image_curve_Elliptic')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Elliptic;
        draw_mirror_curve = @draw_mirror_curve_Elliptic;        
        
    case 6
        % model_name = 'Parabolic';
        c_2 = -4;
        c_3 = 40;
        t = [0;c_2;c_3];
        % K = eye(3);
        K = [1500, 0, 600; 0, 1500, 400; 0, 0, 1];
        % R = eye(3);
        R = angle2dcm(0,0,pi);
        A = .5; B = 0; C = 80;
        zmin = -25; zmax = 50; xymax = 50;

        if ~exist('draw_image_curve_Parabolic')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Parabolic;
        draw_mirror_curve = @draw_mirror_curve_Parabolic;  
        
    case 7
        % model_name = 'Hyperboloidal_central';
        k = 7;
        c_3 = 35;
        t = [0;0;c_3];
        % projection parameters H
        K = [1200, 0, 600; 0, 1200, 400; 0, 0, 1];
        R = angle2dcm(0,0,pi);
        A = -2/(k - 2);
        B = (2*c_3)/(k - 2);
        C = (c_3^2*(k/(k - 2) - 1))/(2*k);
        zmin = -25; zmax = 10; xymax = 50;
        
        if ~exist('draw_image_curve_Hyperboloidal_central')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Hyperboloidal_central;
        draw_mirror_curve = @draw_mirror_curve_Hyperboloidal_central;
        
    case 8
        % model_name = 'Ellipsoidal_central';
        k = 190;
        c_3 = 20;
        c_2 = 0;
        t = [0;0;c_3];
        % projection parameters H
        K = [750, 0, 600; 0, 750, 400; 0, 0, 1];
        R = angle2dcm(0,0,pi);
        A = (2*k)/(c_3^2 + 2*k);
        B = -(2*c_3*k)/(c_3^2 + 2*k);
        C = -(k*(c_3^2/(c_3^2 + 2*k) - 1))/2;      
        zmin = -25; zmax = 10; xymax = 50;
        
        if ~exist('draw_image_curve_Ellipsoidal_central')
            error('ERR: Drawing functions not available. Please run derivations_line_projection.m with the respective opetion.')
        end
        draw_image_curve = @draw_image_curve_Ellipsoidal_central;
        draw_mirror_curve = @draw_mirror_curve_Ellipsoidal_central;
        
end

disp(['Mirror Parameters (A, B, C) = (', num2str(A), ', ', num2str(B), ', ', num2str(C) ')'])
disp(['Camera position (c_2, c_3) = (', num2str(t(2)), ', ', num2str(t(3)), ')'])

rmpath('draw_scripts')

end
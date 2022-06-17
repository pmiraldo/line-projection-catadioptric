function testing_script()

close all

agrawal_test = 1;

if ispc
    addpath('helper\')
else
    addpath('helper/')
end

%% colors

blue = [0 0.4470 0.7410];
orange = [0.8500 0.3250 0.0980];
yellow = [0.9290 0.6940 0.1250];
magenta = [0.4940 0.1840 0.5560];
green = [0.4660 0.6740 0.1880];
cyan = [0.3010 0.7450 0.9330];
red = [0.6350 0.0780 0.1840];

colors = [
    blue; ...
    orange; ...
    green; ...
    yellow; ...
    magenta; ...
    cyan; ...
    red ...
    ];

%% Mirror Parameters
[t, K, R, A, B, C, zmin, zmax, xymax, draw_image_curve, draw_mirror_curve] = setup_mirror();

t1 = t(1); t2 = t(2); t3 = t(3);

%% Get some parallel lines

dir2 = [-1;2;-.2];
dir3 = [.3;1;1];

set_lines_two(:,1) = [dir2;-10;-40;30];
set_lines_two(:,2) = [dir2;-20;-40;20];
set_lines_two(:,3) = [dir2;-30;-40;10];

set_lines_three(:,1) = [dir3;-30;-60;-30];
set_lines_three(:,2) = [dir3;-35;-50;-30];
set_lines_three(:,3) = [dir3;-40;-40;-30];

lines = [
    set_lines_two, ...
    set_lines_three; ...
    2*ones(1,numel(set_lines_two(1,:))), ...
    3*ones(1,numel(set_lines_three(1,:))) ...
    ];

%% Plot 3D mirror
figure(1);
plot_mirror(A,B,C,xymax,zmin,zmax,0.5)
hold all;
text(t1,t2,t3+7.5,'Camera','HorizontalAlignment','right','FontSize',8);
scatter3(t1,t2,t3,25,'ko','filled');
quiver3(t1,t2,t3,R(1,3),R(2,3),R(3,3),10,'color',red,'linewidth',2)
quiver3(t1,t2,t3,R(1,2),R(2,2),R(3,2),10,'color',green,'linewidth',2)
quiver3(t1,t2,t3,R(1,1),R(2,1),R(3,1),10,'color',blue,'linewidth',2)


for line_iter = 1 : numel(lines(1,:))
    
    d1 = lines(1,line_iter);
    d2 = lines(2,line_iter);
    d3 = lines(3,line_iter);
    p1 = lines(4,line_iter);
    p2 = lines(5,line_iter);
    p3 = lines(6,line_iter);
    line_color = colors(lines(7,line_iter),:);
    
    
    plot3([p1+1000*d1;p1-1000*d1],[p2+1000*d2;p2-1000*d2],[p3+1000*d3;p3-1000*d3], 'Color', line_color, 'LineWidth',2);
    draw_mirror_curve(A, B, C, [0;t2;t3], [d1;d2;d3], [p1;p2;p3], ...
        'zmin', zmin, 'zmax', zmax, 'xymax', xymax, 'line_color', line_color);
    
end

hold on
axis equal;
view(158,28)
grid off
set(gca,'visible','off')
box on
axis([-50,50,-50,50,-35,50]);
hold off


%% plot image

k1_1 = K(1,1); k1_3 = K(1,3);
k2_2 = K(2,2); k2_3 = K(2,3);
r1_1 = R(1,1); r1_2 = R(1,2); r1_3 = R(1,3);
r2_1 = R(2,1); r2_2 = R(2,2); r2_3 = R(2,3);
r3_1 = R(3,1); r3_2 = R(3,2); r3_3 = R(3,3);

h1_1 = k1_1*r1_1 + k1_3*r3_1;
h1_2 =  k1_1*r1_2 + k1_3*r3_2;
h1_3 = k1_1*r1_3 + k1_3*r3_3;
h2_1 = k2_2*r2_1 + k2_3*r3_1;
h2_2 = k2_2*r2_2 + k2_3*r3_2;
h2_3 = k2_2*r2_3 + k2_3*r3_3;
h3_1 = r3_1;
h3_2 = r3_2;
h3_3 = r3_3;

H = [h1_1, h1_2, h1_3; h2_1, h2_2, h2_3; h3_1, h3_2, h3_3];

figure(2);
hold all;

for line_iter = 1 : numel(lines(1,:))
    
    d1 = lines(1,line_iter);
    d2 = lines(2,line_iter);
    d3 = lines(3,line_iter);
    p1 = lines(4,line_iter);
    p2 = lines(5,line_iter);
    p3 = lines(6,line_iter);
    line_color = colors(lines(7,line_iter),:);
    
    draw_image_curve( ...
        A, B, C, [0,t2,t3], H, ...
        [d1, d2, d3], [p1, p2, p3], ...
        [0,K(1,3)*2,0,K(2,3)*2], line_color, 300)
end

box on
set(gca, 'YDir','reverse')
axis('equal')
axis([0,K(1,3)*2,0,K(2,3)*2])
set(gca,'FontSize',15)
hold off

%% Run Agrawal 3D point projection for validation
if agrawal_test == 1
    
    if ispc
        addpath('helper\AgrawalForwardProjectionToolBox\OffAxisCatadioptric')
        addpath('helper\AgrawalForwardProjectionToolBox\AxialCatadioptric')
    else
        addpath('helper/AgrawalForwardProjectionToolBox/OffAxisCatadioptric')
        addpath('helper/AgrawalForwardProjectionToolBox/AxialCatadioptric')
    end
    
    point_agrawal_image = [0,0]; iter_agrawal_image = 1;
    point_agrawal_mirror = [0,0,0]; iter_agrawal_mirror = 1;
    
    for line_iter = 1 : numel(lines(1,:))
        
        d1 = lines(1,line_iter); d2 = lines(2,line_iter); d3 = lines(3,line_iter);
        p1 = lines(4,line_iter); p2 = lines(5,line_iter); p3 = lines(6,line_iter);
        
        for iter = -50:10:50
            
            % get some 3D points for projection
            px = p1 + iter*d1; py = p2 + iter*d2; pz = p3 + iter*d3;
            
            if t(2) ~= 0, solMirrorPoint_array = ComputeForwardProjection8Sols(t,[px;py;pz],A,B,C,50);
            else, solMirrorPoint_array = ComputeForwardProjectionAxial(t,[px;py;pz],A,B,C,50); end
            
            % check which points are to store
            if isempty(solMirrorPoint_array), continue, end
            for iiter = 1:numel(solMirrorPoint_array(1,:))
                solMirrorPoint = solMirrorPoint_array(:,iiter);
                if norm(solMirrorPoint) ~= 0
                    z = solMirrorPoint(3);
                    if z < zmax && z > zmin
                        % store points in the mirror
                        point_agrawal_mirror(iter_agrawal_mirror,:) = solMirrorPoint';
                        iter_agrawal_mirror = iter_agrawal_mirror + 1;
                    end
                    
                    i = K*R*(solMirrorPoint - [t1;t2;t3]); i = i/i(3);
                    % store points for image plot
                    point_agrawal_image(iter_agrawal_image,:) = i(1:2)';
                    iter_agrawal_image = iter_agrawal_image + 1;
                end
            end
        end
    end

    
    figure(2), hold on
    plot(point_agrawal_image(:,1),point_agrawal_image(:,2),'bo','MarkerSize',3, 'MarkerFaceColor', 'r');
    hold off
    
    
    if ispc
        rmpath('helper\AgrawalForwardProjectionToolBox\OffAxisCatadioptric')
        rmpath('helper\AgrawalForwardProjectionToolBox\AxialCatadioptric')
    else
        rmpath('helper/AgrawalForwardProjectionToolBox/OffAxisCatadioptric')
        rmpath('helper/AgrawalForwardProjectionToolBox/AxialCatadioptric')
    end
end


if ispc
    rmpath('helper\')
else
    rmpath('helper/')
end

end




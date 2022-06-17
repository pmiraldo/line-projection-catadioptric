syms A B C x y z s_1 s_2 s_3 k c_2 c_3 c_4 lambda u v xi real
syms q_1 q_2 q_3 real

if ispc
    addpath('helper\')
else
    addpath('helper/')
end

% options
verbose = 1;
to_file = 1;
to_plot = 1;

disp('Select the model:');
disp('  1) General');
disp('  2) Sphere');
disp('  3) Axial Cone');
disp('  4) Axial General');
disp('  5) Elliptic');
disp('  6) Parabolic');
disp('  7) Hyperboloidal central');
disp('  8) Ellipsoidal central');
prompt = '... ';
model = input(prompt);

switch model
    case 1
        model_name = 'General';        
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
    case 2
        model_name = 'Sphere';
        A = 1;
        B = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
    case 3
        model_name = 'Axial_Cone';
        c_2 = 0;
        B = 0;
        C = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
    case 4
        model_name = 'Axial_General';
        c_2 = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
    case 5
        model_name = 'Elliptic';
        A = 0;
        C = 0;  
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
        unknowns = [B, c_3];
    case 6
        model_name = 'Parabolic';
        B = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
        unknowns = [A, C, c_3];
    case 7
        model_name = 'Hyperboloidal_central';
        A = -2/(k - 2);
        B = (2*c_3)/(k - 2);
        C = (c_3^2*(k/(k - 2) - 1))/(2*k);
        c_2 = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
    case 8
        model_name = 'Ellipsoidal_central';
        A = (2*k)/(c_3^2 + 2*k);
        B = -(2*c_3*k)/(c_3^2 + 2*k);
        C = -(k*(c_3^2/(c_3^2 + 2*k) - 1))/2;
        c_2 = 0;
        C0 = x^2 + y^2 + A*z^2 + B*z - C;
end

disp(['Selected Model = ', model_name])
disp(['verbose = ', num2str(verbose)]);
disp(['save polynomials = ', num2str(to_file)]);
disp(['save plot curve = ', num2str(to_plot)]);

%% General definitions
K = [0, 0, z - A*z - B/2]';
m = [x, y, z]';
c = [0, c_2, c_3]';
n = [x, y, A*z+B/2]';

%% MIRROR EQUATION!
disp('<strong>## Getting the Constraints  (Sec. 4.1)</strong>')
disp('1: Mirror Equation -- Sec. 3')

[c0_,~] = coeffs(C0,[lambda,z]);

%% PLANE CONSTRAINT
disp('2:  Line Projection Constraints -- Sec. 4.1.1')

% constraint definition
p = [q_1 + lambda*s_1, q_2 + lambda*s_2, q_3 + lambda*s_3]';
PI = [[m';K';c';p'], ones(4,1)];
C1 = simplify(det(PI));

% algebraic simplifications
C1 = simplify(C1);
C1 = simplify(subs(expand(C1),z^3,z*(-y^2 - x^2 - B*z + C)/A));
C1 = simplify(subs(expand(C1),z^2,(-y^2 - x^2 - B*z + C)/A));

% LEMMA 1: Plane-reflection constraiant
[ct_,m1_] = coeffs(C1,lambda);

disp('<strong>LEMMA 1</strong> -- Contraint C1')
for iter = 1 : numel(ct_)
    [~,mt_] = coeffs(ct_(iter),[x,y,z]);
    array = [' -> monimials(',char(m1_(iter)),')'];
    plot_syn_array(array,mt_);
end

%% SNELL REFLECTION CONSTRAINT

% constraint definition
d_mc = m - c;
d_pm = 4*(n'*n)*d_mc - 8*n*(n'*d_mc);
C3_all = simplify(cross(d_pm,p-m));

C2 = simplify(C3_all(1));
C3 = simplify(C3_all(2));
C4 = simplify(C3_all(3));

% algebraic equations
[ct2_,m2_] = coeffs(C2,lambda);
[ct3_,m3_] = coeffs(C3,lambda);
[ct4_,m4_] = coeffs(C4,lambda);

disp('<strong>LEMMA 2</strong> -- Contraint C2')
for iter = 1 : numel(ct2_)
    [~,mt_] = coeffs(ct2_(iter),[x,y,z]);
    array = [' -> monimials(',char(m2_(iter)),')'];
    plot_syn_array(array,mt_);
end
disp('<strong>LEMMA 2</strong> -- Contraint C3')
for iter = 1 : numel(ct3_)
    [~,mt_] = coeffs(ct3_(iter),[x,y,z]);
    array = [' -> monimials(',char(m3_(iter)),')'];
    plot_syn_array(array,mt_);
end
disp('<strong>LEMMA 2</strong> -- Contraint C4')
for iter = 1 : numel(ct4_)
    [~,mt_] = coeffs(ct4_(iter),[x,y,z]);
    array = [' -> monimials(',char(m4_(iter)),')'];
    plot_syn_array(array,mt_);
end

%% LINE REFLECTION CONSTRAINT

disp('<strong>## Getting the line reflection constraints</strong>')
disp('lambda from C1')
[xx1,~] = coeffs(C1,lambda);
lambda_sol = simplify(-xx1(2)/xx1(1));
[ct5_,m5_] = coeffs(xx1(2),z);
disp('Numerator eq. 11')
for iter = 1 : numel(ct5_)
    [~,mt_] = coeffs(ct5_(iter),[x,y,z]);
    array = [' -> monimials(',char(m5_(iter)),')'];
    plot_syn_array(array,mt_);
end

[ct6_,m6_] = coeffs(xx1(1),z);
disp('Denominator eq. 11')
for iter = 1 : numel(ct6_)
    [~,mt_] = coeffs(ct6_(iter),[x,y,z]);
    array = [' -> monimials(',char(m6_(iter)),')'];
    plot_syn_array(array,mt_);
end

disp('<strong>## Getting the line reflection constraint (Sec. 4.2)</strong>')

% substitute lambda from C1 in C2
disp('1) removing lambda from the equation')
C2_ = simplify(subs(expand(C2),lambda,lambda_sol));

% simplifying the equation
% 1) remove the denominator
disp('2) removing the denominator')
[C2_,~] = numden(C2_); C2_ = simplify(C2_);

% 2) remove factors 
disp('3) removing factors')
C2f = factor(C2_);
num_items = -1;
item_factor = -1;
for iter = 1 : numel(C2f)
    [cv_,mv_] = coeffs(C2f(iter),[x,y,z]);
    %plot_syn_array('ithFactor_',mv_);
    if numel(mv_) > num_items
        item_factor = iter;
        num_items = numel(mv_);
    end
end
C2_ = C2f(item_factor);

% 3) remove z^2 and z^3 from the equation
if model ~= 5 % notice in this case A = 1
    
    disp('4) removing z^2 and z^3 from the equation')
    C2_ = simplify(subs(expand(C2_),z^3,-z*(x^2+y^2+B*z-C)/A));
    C2_ = simplify(subs(expand(C2_),z^2,-(x^2+y^2+B*z-C)/A));

    [ct2__,m2__] = coeffs(C2_,z);
    disp('<strong>Theorem 1</strong> -- Line reflection constraint')
    for iter = 1 : numel(ct2__)
        [~,mt_] = coeffs(ct2__(iter),[x,y,z]);
        array = [' -> monimials(',char(m2__(iter)),')'];
        plot_syn_array(array,mt_);
    end

    disp('<strong>## Getting results from Remark 1 (Sec. 4.2)</strong>')
    disp('1) getting matrix N')
    % deriving results from remark #1
    N = [A, B, -C + x^2 + y^2; 0, ct2__; ct2__, 0];
    remark1 = det(N);
    
else
    
    disp('4) removing z from the equation')
    C2_ = simplify(subs(expand(C2_),z,-(x^2+y^2)/B));
    disp('<strong>## Getting results from Remark 1 (Sec. 4.2)</strong>')
    remark1 = C2_;
    
end
    
disp('2) removing factors')
if model == 0 || model == 4
    disp('(it takes some time for general configurations...)')
end
% removing factors
remark1f = factor(remark1);
num_items = -1;
item_factor = -1;
for iter = 1 : numel(remark1f)
    [cv_,mv_] = coeffs(remark1f(iter),[x,y,z]);
    %plot_syn_array('ithFactor_',mv_);
    if numel(mv_) > num_items
        item_factor = iter;
        num_items = numel(mv_);
    end
end
remark1 = remark1f(item_factor);

[cr1_,mr1_] = coeffs(remark1,[x,y,z]);
disp('<strong>Remark 1</strong> -- Line reflection constraint')
array = ' -> monomials';
plot_syn_array(array,mr1_);

%% MODELING LINE PROJECTION
disp('<strong>## Modeling line projection (Secs. 4.3 and 4.4)</strong>')

% projection ray
disp('1) getting x = f1(u,v,z) and y = f2(u,v,z)')
ray = [u;v;1];
cameraEqs = cross(ray,m-c);
xy_sol = solve(cameraEqs,[x,y]); % u,v, z
[xzc,xzm] = coeffs(xy_sol.x,z);
[yzc,yzm] = coeffs(xy_sol.y,z);

disp('1) replacing x and y in the mirror equation')
C0 = xy_sol.x^2 + xy_sol.y^2 + A*z^2 + B*z - C; 

disp('2) removing denominator')
[C0,~] = numden(C0);

[ct0_,m0_] = coeffs(simplify(C0),z);
disp('Eq. 18')
for iter = 1 : numel(ct0_)
    [~,mt_] = coeffs(ct0_(iter),[u,v,x,y,z]);
    array = [' -> monimials(',char(m0_(iter)),')'];
    plot_syn_array(array,mt_);
end

disp('3) replacing x and y in the line reflection constraint')
C2__ = (subs(C2_,[x,y],[xy_sol.x,xy_sol.y]));

disp('4) removing z^3 and z^2')
[cc1,cc2] = coeffs(C0,z);
C2__ = (subs(expand(C2__),z^5,-z^3*cc1(2:end)*cc2(2:end)'/cc1(1)));
C2__ = (subs(expand(C2__),z^4,-z^2*cc1(2:end)*cc2(2:end)'/cc1(1)));
C2__ = (subs(expand(C2__),z^3,-z*cc1(2:end)*cc2(2:end)'/cc1(1)));
C2__ = (subs(expand(C2__),z^2,-cc1(2:end)*cc2(2:end)'/cc1(1)));

disp('5) removing denominator')
[C2__,~] = numden(C2__);

disp('6) removing factors')
C2__f = factor(simplify(C2__));
num_items = -1;
item_factor = -1;
for iter = 1 : numel(C2__f)
    [cv_,mv_] = coeffs(C2__f(iter),[u,v,z]);
    if numel(mv_) > num_items
        item_factor = iter;
        num_items = numel(mv_);
    end
end
C2__ = C2__f(item_factor);

[ct2_,m2_] = coeffs(C2__,z);
disp('Eq. 19')
for iter = 1 : numel(ct2_)
    [~,mt_] = coeffs(ct2_(iter),[u,v,z]);
    array = [' -> monimials(',char(m2_(iter)),')'];
    plot_syn_array(array,mt_);
end

disp('7) getting matrix N')
N = [ct0_; 0, ct2_; ct2_, 0];
theorem2 = det(N);

disp('8) removing factors')
if model == 0 || model == 4
    disp('(it takes some time for general configurations...)')
end
theorem2f = factor(theorem2);
num_items = -1;
item_factor = -1;
for iter = 1 : numel(theorem2f)
    [cv_,mv_] = coeffs(theorem2f(iter),[u,v]);
    if numel(mv_) > num_items
        item_factor = iter;
        num_items = numel(mv_);
    end
end
theorem2 = theorem2f(item_factor);

[ct2_,mt2_] = coeffs(theorem2,[u,v,x,y,z]);
disp('<strong>Theorem 2</strong> -- Projection curve on the normalized plane')
array = ' -> monomials';
plot_syn_array(array,mt2_);

%% curve in the image
syms ui vi real 

disp('9) applying collineation transformation')

H = sym('h',[3,3],'real');

l = H(3,:)*[u;v;1];
eqs = simplify(l*[ui;vi] - H(1:2,:)*[u;v;1]);

soluv = solve(eqs,[u,v]);

[num_u,den_u] = numden(soluv.u);
[num_v,den_v] = numden(soluv.v);

[cnu,mnu] = coeffs(num_u,[ui,vi]);
[cnv,mnv] = coeffs(num_v,[ui,vi]);
[cd,md] = coeffs(den_u,[ui,vi]);

cnu_ = sym('cnu',size(cnu),'real');
cnv_ = sym('cnv',size(cnv),'real');
cd_ = sym('cd',size(cd),'real');

num_u = cnu_*mnu';
num_v = cnv_*mnv';
den_u = cd_*md';


degreePol = polynomialDegree(theorem2,[u,v]);
mm_ = sym(zeros(1,numel(mt2_)));
for i = 1:numel(mt2_)
    dU = polynomialDegree(mt2_(i),u);
    dV = polynomialDegree(mt2_(i),v);
    mm_(1,i) = num_u^dU*num_v^dV*den_u^(degreePol-dU-dV);
end

c_uv = sym('c_uv',size(ct2_),'real');

theorem3 = expand(c_uv*mm_');

[ct3_,mt3_] = coeffs(theorem3,[ui,vi]);
[ct3__,mt3__] = coeffs(theorem3,ui);

disp('<strong>Theorem 3</strong> -- Projection curve on the image plane')
array = ' -> monomials';
plot_syn_array(array,mt3_);

disp('<strong>Note</strong> -- (u,v) and (ui,vi) correspond to the coordinates on the normalized and image plane, respectively')
if to_file > 0

    coeff_mirror = cell(numel(mr1_),1);
    values_mirror = cell(numel(mr1_),1);
    monomials_mirror = cell(numel(mr1_),1);
    constraint_xy = sym(0);
    for iter = 1 : numel(mr1_)
        coeff_mirror{iter} = ['c_xy', num2str(iter)];
        monomials_mirror{iter} = mr1_(iter);
        constraint_xy = constraint_xy + str2sym(coeff_mirror{iter})*monomials_mirror{iter};
        values_mirror{iter} = cr1_(iter); 
    end
    
    [coeffs_x, monimials_x] = coeffs(constraint_xy, x);
    [coeffs_y, monimials_y] = coeffs(constraint_xy, y);
    
    coeff_init = cell(numel(mt2_),1);
    values_init = cell(numel(mt2_),1);
    monomials_init = cell(numel(mt2_),1);
    for iter = 1 : numel(mt2_)
        coeff_init{iter} = ['c_uv', num2str(iter)];
        values_init{iter} = ct2_(iter);
        monomials_init{iter} = mt2_(iter);
    end
    
    coeff = cell(numel(mt3_),1);
    values = cell(numel(mt3_),1);
    monomials = cell(numel(mt3_),1);
    constraint_uivi = sym(0);
    for iter = 1 : numel(mt3_)
        coeff{iter} = ['c_uivi', num2str(iter)];
        values{iter} = ct3_(iter);
        monomials{iter} = mt3_(iter);
        constraint_uivi = constraint_uivi + str2sym(coeff{iter})*monomials{iter};
    end
    
    [coeffs_ui, monimials_ui] = coeffs(constraint_uivi, ui);
    [coeffs_vi, monimials_vi] = coeffs(constraint_uivi, vi);
    
    curve_mirror(model_name, monomials_mirror, coeff_mirror, values_mirror, coeffs_x, coeffs_y);
    curve_image(model_name, monomials, coeff, values, coeff_init, values_init, coeffs_ui, coeffs_vi);
    
end



if ispc
    rmpath('helper\')
else
    rmpath('helper/')
end
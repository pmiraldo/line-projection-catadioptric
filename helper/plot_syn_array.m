function plot_syn_array(name,array)

fmt = [name, ' = {'];
for iter = 1:numel(array)
    fmt = cat(2,fmt,(char(array(iter))));
    if(iter+1==numel(array)+1)
        fmt = cat(2,fmt,'}\n');
    else
        fmt = cat(2,fmt,', ');
    end
end
    
fprintf(fmt)
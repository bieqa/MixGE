function out = strjoin3(in)
switch length(in)
    case 0
        out = '';
    case 1
        out = in{1};
    case 2
        out = [in{1},' & ',in{2}];
    otherwise
        out = [strjoin2(in(1:end-2),', '),', ',in{end-1},' & ',in{end}];
end
end
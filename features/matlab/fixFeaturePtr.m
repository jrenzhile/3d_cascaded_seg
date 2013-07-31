function [unary,pairwise]=fixFeaturePtr(unary,pairwise)
% Explicitly encode the dimensions of the subset of unary features
% involved in computation of every pairwise feature
% In the end, pairwise(p).unary is a set of indices into U
% There are a few possibilities for the indication of unary
% specified in the system file:
% 1- a number (index of the unary feature)
% 2- a string (name of the unary feature)
% 3- a cell array of numbers and/or strings
% This function converts 2 and 3 to 1.

if (nargout > 1)
  for p = 1:length(pairwise)
    % map out unary features referred to by pairwise
    uname=pairwise(p).unary;
    pairwise(p).unary = getUnaryNames(uname,unary);
  end
end

for u=1:length(unary)
  if (isfield(unary(u),'unary'))
    uname=unary(u).unary;
    unary(u).unary = getUnaryNames(uname,unary);
  end
end


function uind = getUnaryNames(uname,unary)

if (isempty(uname))
  uind=[];
elseif (ischar(uname))
  if (strcmp(uname,'all'))
    uind=1:length(unary);
  else
    uind = find(arrayfun(@(f)(isequal(f.name,uname)),unary));
    if (length(uind)~=1)
      error(['could not find unique unary feature ' uname]);
    end
  end
elseif iscell(uname)
  uind = [];
  for u=1:length(uname)
    if (ischar(uname{u}))
      uind_u = find(arrayfun(@(f)(isequal(f.name,uname{u})),unary));
      if (length(uind_u)~=1)
        error(['could not find unique unary feature ' uname{u}]);
      end
      uind = [uind uind_u];
    else
      uind = [uind uname{u}];
    end
  end
else
  error('unrecognized format for unary name');
end

function  avgNorm  =  spAvgNorm(s, seginfo, vertex, face, avgNormMatrix)

% 
% Choose from the avgNorm matrix the average norm vector for segment s
%
% jrenzhile@gmail.com
% July, 2013

if nargin<5
    error('Compute the avg norm matrix first..\n');
end

avgNorm = avgNormMatrix(:,s);
avgNorm = avgNorm';


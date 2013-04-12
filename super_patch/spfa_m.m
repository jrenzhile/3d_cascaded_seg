function minDist = spfa_m(neighbors, dist, v)
% function minDist = spfa(neighbors, dist, v)
% Given neighbors and distance matrix, 
% perform Shortest Path Faster Algorithm(SPFA) algorithm in finding the
% shortest path from v to every other faces.
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013

num_face = size(neighbors,2);
myQueue = zeros(num_face,1);
num_myQueue = 0;
in_myQueue = zeros(num_face,1);
[myQueue, num_myQueue, in_myQueue] = ...
    push_myQueue(v, myQueue, num_myQueue, in_myQueue);
minDist =inf(num_face,1);
minDist(v) = 0;

while num_myQueue>0
    
    [u, myQueue, num_myQueue,in_myQueue] = ...
    pop_myQueue(myQueue, num_myQueue, in_myQueue);
    for i = 1:3
        w = neighbors(i,u);
        if minDist(w) > minDist(u)+dist(i,u)
            minDist(w) =  minDist(u)+dist(i,u);
            if in_myQueue(w)==0
                [myQueue, num_myQueue, in_myQueue] = ...
                push_myQueue(w, myQueue, num_myQueue, in_myQueue);
            end
        end
    end
end

end


%%%%%%%%%%% Basic actions in queue

function [myQueue, num_myQueue, in_myQueue] = ...
    push_myQueue(u, myQueue, num_myQueue, in_myQueue)
    
    myQueue(num_myQueue+1) = u;
    num_myQueue = num_myQueue+1;
    in_myQueue(u) = 1;
end

function [u, myQueue, num_myQueue,in_myQueue] = ...
    pop_myQueue(myQueue, num_myQueue, in_myQueue)
    
    u = myQueue(1);
    myQueue(1) = [];
    num_myQueue = num_myQueue-1;
    in_myQueue(u) = 0;
end


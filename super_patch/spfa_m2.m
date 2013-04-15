function minDist = spfa_m2(neighbors, dist, v)
% function minDist = spfa(neighbors, dist, v)
% Given neighbors and distance matrix, 
% perform Shortest Path Faster Algorithm(SPFA) algorithm in finding the
% shortest path from v to every other faces.
%
% Zhile Ren<jrenzhile@gmail.com>
% Apr, 2013

num_face = size(neighbors,2);
myQueue = zeros(num_face,1);
in_myQueue = zeros(num_face,1);
head_myQueue = 1;
tail_myQueue = 1;

[myQueue, head_myQueue, tail_myQueue, in_myQueue] = ...
    push_myQueue(v, myQueue, head_myQueue, tail_myQueue, in_myQueue);

minDist =inf(num_face,1);
minDist(v) = 0;

while tail_myQueue~=head_myQueue
    
    [u, myQueue, head_myQueue, tail_myQueue,in_myQueue] = ...
    pop_myQueue(myQueue, head_myQueue, tail_myQueue, in_myQueue);
    for i = 1:3
        w = neighbors(i,u);
        if minDist(w) > minDist(u)+dist(i,u)
            minDist(w) =  minDist(u)+dist(i,u);
            if in_myQueue(w)==0
                [myQueue, head_myQueue, tail_myQueue, in_myQueue] = ...
                push_myQueue(w, myQueue, head_myQueue, tail_myQueue, in_myQueue);
            end
        end
    end
end

end


%%%%%%%%%%% Basic actions in queue

function [myQueue, head_myQueue, tail_myQueue, in_myQueue] = ...
    push_myQueue(u, myQueue, head_myQueue, tail_myQueue, in_myQueue)
    
    myQueue(tail_myQueue) = u;
    tail_myQueue = tail_myQueue+1;
    if tail_myQueue>length(myQueue)
        tail_myQueue = 1;
    end
    in_myQueue(u) = 1;
end

function [u, myQueue, head_myQueue, tail_myQueue,in_myQueue] = ...
    pop_myQueue(myQueue, head_myQueue, tail_myQueue, in_myQueue)
    
    u = myQueue(head_myQueue);
    myQueue(head_myQueue) = 0;
    head_myQueue = head_myQueue+1;
    if head_myQueue>length(myQueue)
        head_myQueue = 1;
    end
    in_myQueue(u) = 0;
end


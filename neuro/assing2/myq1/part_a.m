function [stimulus] = stimulus_gen(t,del_t,lambda)
 threshold = lambda*del_t;
 ans = rand(t/del_t,1);
 stimulus =logical(ans<threshold);
end


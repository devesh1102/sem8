function spikes= poisson(T,del_t,rate)
    time = (del_t:del_t:T)
    lambda = rate*del_t
    random_nums = rand(size(time))
    spikes = random_nums<lambda
end
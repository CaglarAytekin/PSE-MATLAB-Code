function H=UpdateDiagonal(H,boundaries)

for bnd_cnt=1:length(boundaries)
    H(boundaries(bnd_cnt),boundaries(bnd_cnt))=H(boundaries(bnd_cnt),boundaries(bnd_cnt))+0.1;
end
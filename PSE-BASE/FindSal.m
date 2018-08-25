function eigvec_now_2D=FindSal(H,PixNum, LabelLine,width, height)

PSE=mat2gray(H\ones([size(H,1),1]));

eigvec_now_2D = sup2pixel( PixNum, LabelLine, PSE );
eigvec_now_2D = reshape( eigvec_now_2D,width, height  );
function response = glp(im,thresh)
% by mohammed athiq, found on https://fr.mathworks.com/matlabcentral/fileexchange/40579-frequency-domain-filtering-for-grayscale-images?s_tid=prof_contriblnk
% modified
% inputs
% im is the fourier transform of the image
% thresh is the cutoff circle radius
%outputs
% response is the filtered image
[r,c]=size(im);
im = fftshift(fft2(im));
res = zeros(r,c);
d0=thresh;
d=zeros(r,c);
h=zeros(r,c);
for i=1:r
    for j=1:c
     d(i,j)=  sqrt( (i-(r/2))^2 + (j-(c/2))^2);
    end
end
for i=1:r
    for j=1:c
      h(i,j)= exp ( -( (d(i,j)^2)/(2*(d0^2)) ) );
    end
end
for i=1:r
    for j=1:c
    res(i,j)=(h(i,j))*im(i,j);
    end
end
response = ifft2(fftshift(res));
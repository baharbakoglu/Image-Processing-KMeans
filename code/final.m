function [] = final( img )
imlab = vl_xyz2lab(vl_rgb2xyz(img)) ;
segments = vl_slic(single(imlab), 30, 1) ;
contourImg = draw_contours(segments, img);
figure, imshow(contourImg);
v=feature_vector(img,segments);
idx=kmeans(v,3);
% idx=kmeans(v,3, 'Distance', 'cityblock');
%  idx=kmeans(v,3, 'Distance', 'correlation');
% idx=kmeans(v,3, 'Distance', 'cosine');
%  idx=kmeans(v,3, 'Distance', 'sqeuclidean');
A=unique(segments);
[r,~]=size(A);
[rs,cs]=size(segments);
for i=1:rs
    for j=1:cs
        for k=1:r
            if(segments(i,j)==A(k))
                segments(i,j)=idx(k);
            end 
        end
    end 
end
figure,imagesc(segments);
contourImg = draw_contours(segments, img);
figure, imshow(contourImg);
end


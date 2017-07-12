function mask = findlaser(img, model)
% model:1--rows--(laser_x), 2--cols-(laser_y)
% img: gray img

% img_hsv = rgb2hsv(img);
% %% 提取亮度
% v = img_hsv(:,:,3);

%% 寻找每行每列的最大值
[h, w] = size(img);
maxImg = zeros(size(img));

if model == 1
    [Cb, bb] = max(img, [], 2); %每行最大
    for i = 1:h
        maxImg(i,bb(i)) = Cb(i);
    end
else
    [Ca, aa] = max(img, [], 1); %每列最大
    for i = 1:w
        maxImg(aa(i),i) = Ca(i);
    end
end
%% 提取色度值
% h = img_hsv(:,:,1);
% [m,n]=size(h);
% H=zeros(size(h));
% % 提取红色部分的值
% for kk=1:20
%     for ii=1:m
%         for jj=1:n
%             if(ceil(h(ii,jj)*360)==kk)
%                 H(ii,jj)=1;
%             end
%         end
%     end
% end

% mask = (H>0).*(maxImg>0);
mask = (maxImg>0);
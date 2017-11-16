function mask = findlaser(img, model)
% model:1--rows--(laser_x), 2--cols-(laser_y)
% img: gray img

% img_hsv = rgb2hsv(img);
% %% ��ȡ����
% v = img_hsv(:,:,3);


%% Ѱ��ÿ��ÿ�е����ֵ
[h, w] = size(img);
maxImg = zeros(size(img));

if model == 1
    [Cb, bb] = max(img, [], 2); %ÿ�����
    for i = 1:h
        maxImg(i,bb(i)) = Cb(i);
    end
else
    [Ca, aa] = max(img, [], 1); %ÿ�����
    for i = 1:w
        maxImg(aa(i),i) = Ca(i);
    end
end
%% ��ȡɫ��ֵ
% h = img_hsv(:,:,1);
% [m,n]=size(h);
% H=zeros(size(h));
% % ��ȡ��ɫ���ֵ�ֵ
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
mask = (maxImg>3);
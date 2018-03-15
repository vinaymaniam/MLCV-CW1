idxToPlot = randperm(length(rightClass));
for m=1:3
    subplot(2,3,m)
    % this is the true class
    c_int=floor(rightClass(idxToPlot(m))./15);
    idx=rightClass(idxToPlot(m))-15*c_int;
    if(c_int==10)
        subFolderName = fullfile(folderName,classList{c_int});
    else
        subFolderName = fullfile(folderName,classList{c_int+1});
    end
    imgList = dir(fullfile(subFolderName,'*.jpg'));
    if(idx==0)
        I = imread(fullfile(subFolderName,imgList(imgIdx_tr(c_int,idx+1)).name));
    else
        I = imread(fullfile(subFolderName,imgList(imgIdx_tr(c_int+1,idx)).name));
    end
    imshow(I);
    if(c_int==10)
        str1=sprintf('True: %s', classList_for_printing{c_int});
        str2=sprintf('Classified: %s',classList_for_printing{c(idxToPlot(m))});
    else
        str1=sprintf('True: %s', classList_for_printing{c_int+1});
        str2=sprintf('Classified: %s',classList_for_printing{c(rightClass(idxToPlot(m)))});

    end
    title({str1,str2}, 'FontSize', 15);
end
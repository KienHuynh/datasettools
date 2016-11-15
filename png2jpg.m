path = 'C:\IPCV group\Datasets\1\';
filelist = dir([path, '*.png']);
for i=1:size(filelist,1)
    I = imread([path, sprintf('%04d', i), '.png']);
    imwrite(I, ['C:\IPCV group\Datasets\jpg\', sprintf('%04d', i), '.jpg'], 'JPG');
    disp (i);
end
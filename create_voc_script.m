% first 200 files
load('data\data1-xemay.mat');
m_bb_data = bb_data;
load('data\data1-xehoi.mat');
c_bb_data = bb_data;
load('data\data1-xebuyt.mat');
b_bb_data = bb_data;
for i=1:5:1600
    filename = sprintf('%04d', i);
    %Create the top part of the xml
    top = create_voc_xml_top([filename, '.jpg']);
    %Create the bottom part of the xml
    bottom = create_voc_xml_bottom();
    
    % Create objects
    obj = {};
    
    % motorbike first
    bb_cell = m_bb_data{i};
    type = 'motorbike';
    for j=1:size(bb_cell,1)
        row = uint32(bb_cell(j,:));
        xmin = row(1);
        ymin = row(2);
        xmax = row(3);
        ymax = row(4);
        
        if (xmin < 0)
            xmin = 0;
        end
        if (xmin > 1279)
            xmin = 1279;
        end
        if (xmax < 0)
            xmax = 9;
        end
        if (xmax > 1279)
            xmax = 1279;
        end
        if (ymin < 0)
            ymin = 0;
        end
        if (ymin > 719)
            ymin = 719;
        end
        if (ymax < 0)
            ymax = 0;
        end
        if (ymax > 719)
            ymax = 719;
        end
        
        obj = [obj; create_voc_xml_object(type, ...
            sprintf('%d',xmin), ...
            sprintf('%d',ymin), ...
            sprintf('%d',xmax), ...
            sprintf('%d',ymax))];
    end
    
    % We car now
    bb_cell = c_bb_data{i};
    type = 'car';
    for j=1:size(bb_cell,1)
        row = uint32(bb_cell(j,:));
        xmin = row(1);
        ymin = row(2);
        xmax = row(3);
        ymax = row(4);
        
        if (xmin < 0)
            xmin = 0;
        end
        if (xmin > 1279)
            xmin = 1279;
        end
        if (xmax < 0)
            xmax = 9;
        end
        if (xmax > 1279)
            xmax = 1279;
        end
        if (ymin < 0)
            ymin = 0;
        end
        if (ymin > 719)
            ymin = 719;
        end
        if (ymax < 0)
            ymax = 0;
        end
        if (ymax > 719)
            ymax = 719;
        end
        
        obj = [obj; create_voc_xml_object(type, ...
            sprintf('%d',xmin), ...
            sprintf('%d',ymin), ...
            sprintf('%d',xmax), ...
            sprintf('%d',ymax))];
    end
    
    % We bus now
    bb_cell = b_bb_data{i};
    type = 'bus';
    for j=1:size(bb_cell,1)
        row = uint32(bb_cell(j,:));
        xmin = row(1);
        ymin = row(2);
        xmax = row(3);
        ymax = row(4);
        
        if (xmin < 0)
            xmin = 0;
        end
        if (xmin > 1279)
            xmin = 1279;
        end
        if (xmax < 0)
            xmax = 9;
        end
        if (xmax > 1279)
            xmax = 1279;
        end
        if (ymin < 0)
            ymin = 0;
        end
        if (ymin > 719)
            ymin = 719;
        end
        if (ymax < 0)
            ymax = 0;
        end
        if (ymax > 719)
            ymax = 719;
        end
        
        obj = [obj; create_voc_xml_object(type, ...
            sprintf('%d',xmin), ...
            sprintf('%d',ymin), ...
            sprintf('%d',xmax), ...
            sprintf('%d',ymax))];
        disp(['bus ', int2str(i) ]);
    end
    
    fileID = fopen(['rob_xml/' filename '.xml'],'w');
    for j=1:numel(top)
        fprintf(fileID,'%s\n', top{j});
    end
    for j=1:numel(obj)
        fprintf(fileID,'%s\n', obj{j});
    end
    for j=1:numel(bottom)
        fprintf(fileID,'%s\n', bottom{j});
    end
end

% 1001-1200
% load('motorbike_bb_data_1000-1200.mat');
% m_bb_data = bb_data;
% load('rob_car_bb_data_1-200 1001-1200.mat');
% c_bb_data = bb_data(1001:1200);
% for i=1:200
%     filename = sprintf('%04d', i+1000);
%     %Create the top part of the xml
%     top = create_voc_xml_top([filename, '.jpg']);
%     %Create the bottom part of the xml
%     bottom = create_voc_xml_bottom();
%     
%     % Create objects
%     obj = {};
%     
%     % motorbike first
%     bb_cell = m_bb_data{i};
%     type = 'motorbike';
%     for j=1:size(bb_cell,1)
%         row = uint32(bb_cell(j,:));
%         xmin = row(1);
%         ymin = row(2);
%         xmax = row(3);
%         ymax = row(4);
%         
%         if (xmin < 0)
%             xmin = 0;
%         end
%         if (xmin > 1279)
%             xmin = 1279;
%         end
%         if (xmax < 0)
%             xmax = 9;
%         end
%         if (xmax > 1279)
%             xmax = 1279;
%         end
%         if (ymin < 0)
%             ymin = 0;
%         end
%         if (ymin > 719)
%             ymin = 719;
%         end
%         if (ymax < 0)
%             ymax = 0;
%         end
%         if (ymax > 719)
%             ymax = 719;
%         end
%         
%         obj = [obj; create_voc_xml_object(type, ...
%             sprintf('%d',xmin), ...
%             sprintf('%d',ymin), ...
%             sprintf('%d',xmax), ...
%             sprintf('%d',ymax))];
%     end
%     
%     % We car now
%     bb_cell = c_bb_data{i};
%     type = 'car';
%     for j=1:size(bb_cell,1)
%         row = uint32(bb_cell(j,:));
%         xmin = row(1);
%         ymin = row(2);
%         xmax = row(3);
%         ymax = row(4);
%         
%         if (xmin < 0)
%             xmin = 0;
%         end
%         if (xmin > 1279)
%             xmin = 1279;
%         end
%         if (xmax < 0)
%             xmax = 9;
%         end
%         if (xmax > 1279)
%             xmax = 1279;
%         end
%         if (ymin < 0)
%             ymin = 0;
%         end
%         if (ymin > 719)
%             ymin = 719;
%         end
%         if (ymax < 0)
%             ymax = 0;
%         end
%         if (ymax > 719)
%             ymax = 719;
%         end
%         
%         obj = [obj; create_voc_xml_object(type, ...
%             sprintf('%d',xmin), ...
%             sprintf('%d',ymin), ...
%             sprintf('%d',xmax), ...
%             sprintf('%d',ymax))];
%     end
%     fileID = fopen(['rob_xml/' filename '.xml'],'w');
%     for j=1:numel(top)
%         fprintf(fileID,'%s\n', top{j});
%     end
%     for j=1:numel(obj)
%         fprintf(fileID,'%s\n', obj{j});
%     end
%     for j=1:numel(bottom)
%         fprintf(fileID,'%s\n', bottom{j});
%     end
% end


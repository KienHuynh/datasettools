function varargout = boundingBoxMarker_v1(varargin)
% BOUNDINGBOXMARKER_V1 MATLAB code for boundingBoxMarker_v1.fig
%      BOUNDINGBOXMARKER_V1, by itself, creates a new BOUNDINGBOXMARKER_V1 or raises the existing
%      singleton*.
%
%      H = BOUNDINGBOXMARKER_V1 returns the handle to a new BOUNDINGBOXMARKER_V1 or the handle to
%      the existing singleton*.
%
%      BOUNDINGBOXMARKER_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOUNDINGBOXMARKER_V1.M with the given input arguments.
%
%      BOUNDINGBOXMARKER_V1('Property','Value',...) creates a new BOUNDINGBOXMARKER_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before boundingBoxMarker_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to boundingBoxMarker_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help boundingBoxMarker_v1

% Last Modified by GUIDE v2.5 24-Nov-2016 09:38:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @boundingBoxMarker_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @boundingBoxMarker_v1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before boundingBoxMarker_v1 is made visible.
function boundingBoxMarker_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to boundingBoxMarker_v1 (see VARARGIN)

handles.output = hObject;
handles.path2Folder = '';
handles.imageID = 1;
handles.imageNameList = [];
handles.numObject = [];
handles.currentRow = 0;
handles.currentCol = 1;
handles.saveReminderCounter = 0;
handles.clickCounter = 0;
% handles.fileName = 'data 3\1501-1900\data4-xetai.mat';
handles.fileName = 'trungnguyen-motorbike.mat';
handles.mode = 'create';
handles.graphics_rects = {};
handles.last_key = '';
handles.last_key_pressed = 0;
if (exist(handles.fileName,'file'))
    load(handles.fileName);
    handles.data = bb_data;
    handles.numObject = numObject;
    %Point the currentRow pointer to [the last row =/= -100] + 1
%     handles.currentRow = max(find(handles.data(:,1) ~= -100)) + 1;
else
    handles.data = cell(5000,1);
    handles.numObject = zeros(5000,1);
%     handles.data = zeros(5000,11);
%     handles.data(:) = -100;
end

% Choose default command line output for boundingBoxMarker_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes boundingBoxMarker_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = boundingBoxMarker_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function folder_path_Callback(hObject, eventdata, handles)
% hObject    handle to folder_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.path2Folder = get(hObject,'String');
% handles.sID = str2num(handles.path2Folder(size(handles.path2Folder,2)));
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of folder_path as text
%        str2double(get(hObject,'String')) returns contents of folder_path as a double


% --- Executes during object creation, after setting all properties.
function folder_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to folder_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_button.
function browse_button_Callback(hObject, eventdata, handles)
% hObject    handle to browse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.path2Folder = uigetdir('C:\IPCV group\Datasets\1\');
set(handles.folder_path, 'String', handles.path2Folder);
handles.imageNameList = dir([handles.path2Folder '\' '*.png']);
if (isempty(handles.imageNameList))
    handles.imageNameList = dir([handles.path2Folder '\' '*.jpg']);
end
guidata(hObject,handles);



% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
imageNameList = handles.imageNameList;
%Load image and display bounding/ori information
imgName = [imageNameList(handles.imageID).name];
fullPath = [handles.path2Folder '\' imgName];
img = imread(fullPath);
set(handles.imageIDText, 'String', handles.imageID);
set(handles.imgNameText, 'String', imgName);
hold off;
imageHandle = imshow(img);
hold on;

handles.graphics_rects = drawOldInfo(handles.imageID, handles.data);

set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
guidata(hObject, handles);

% --- Executes on button press in previous_button.
function previous_button_Callback(hObject, eventdata, handles)
% hObject    handle to previous_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.imageID = handles.imageID-1;
if (handles.imageID <= 0)
    handles.imageID = 1;
end
%Load image and display bounding/ori information
imageNameList = handles.imageNameList;
imgName = [imageNameList(handles.imageID).name];
fullPath = [handles.path2Folder '\' imgName];
img = imread(fullPath);
set(handles.imageIDText, 'String', handles.imageID);
set(handles.imgNameText, 'String', imgName);
hold off;
imageHandle = imshow(img);
hold on;

handles.graphics_rects = drawOldInfo(handles.imageID, handles.data);
set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
guidata(hObject, handles);

% --- Executes on button press in next_button.
function next_button_Callback(hObject, eventdata, handles)
% hObject    handle to next_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.imageID = handles.imageID+1;
imageNameList = handles.imageNameList;
if (handles.imageID > numel(imageNameList))
    handles.imageID = numel(imageNameList);
end

%Load image and display bounding/ori information

imgName = [imageNameList(handles.imageID).name];
fullPath = [handles.path2Folder '\' imgName];
img = imread(fullPath);
set(handles.imageIDText, 'String', handles.imageID);
set(handles.imgNameText, 'String', imgName);
hold off;
imageHandle = imshow(img);
hold on;

handles.graphics_rects = drawOldInfo(handles.imageID, handles.data);
set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
guidata(hObject, handles);

% --- Executes on button press in undo_button.
function undo_button_Callback(hObject, eventdata, handles)
% hObject    handle to undo_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if (~isempty(handles.data{handles.imageID}))
    handles.data{handles.imageID}(end,:) = [];
    handles.numObject(handles.imageID) = handles.numObject(handles.imageID)-1;
end
imageNameList = handles.imageNameList;
imgName = [imageNameList(handles.imageID).name];
fullPath = [handles.path2Folder '\' imgName];
img = imread(fullPath);
hold off;
imageHandle = imshow(img);
hold on;

handles.graphics_rects = drawOldInfo(handles.imageID, handles.data);
set(imageHandle,'ButtonDownFcn',@ImageClickCallback);

guidata(hObject, handles);

% --- Executes on button press in save_button.
function save_button_Callback(hObject, eventdata, handles)
% hObject    handle to save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
handles.saveReminderCounter = 0;
set(handles.saveReminder, 'String', '');
numObject = handles.numObject;
bb_data = handles.data;
save(handles.fileName,'bb_data', 'numObject');
guidata(hObject, handles);

function imageIDText_Callback(hObject, eventdata, handles)
% hObject    handle to imageIDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imageIDText as text
%        str2double(get(hObject,'String')) returns contents of imageIDText as a double
handles = guidata(hObject);
imageID = get(hObject,'String');
handles.imageID = str2num(imageID);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function imageIDText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageIDText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function imgNameText_Callback(hObject, eventdata, handles)
% hObject    handle to imgNameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgNameText as text
%        str2double(get(hObject,'String')) returns contents of imgNameText as a double


% --- Executes during object creation, after setting all properties.
function imgNameText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgNameText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function [rects] = drawOldInfo(imageID, data)
rects = cell(size(data{imageID},1),1);
if (~isempty(data{imageID}))
    for i=1:size(data{imageID},1)
        rects{i} = infoDisplay (imageID, data, i);
    end
end

% --- Display bounding box and orientation line on image
function [r] = infoDisplay (imageID, data, idx)
if (~isempty(data{imageID}))
    x1 = data{imageID}(:,1);
    y1 = data{imageID}(:,2);
    x2 = data{imageID}(:,3);
    y2 = data{imageID}(:,4);
%     s = scatter(data{imageID}(:,2),data{imageID}(:,3),'r','fill','MarkerEdgeColor','green','LineWidth',1);
    w = x2-x1;
    h = y2-y1;
%     for i=1:size(x1,1)
        r = rectangle('Position', [x1(idx) y1(idx) w(idx) h(idx)],...
                'EdgeColor',[0 1 0], 'LineWidth', 1.5);
        set(r,'ButtonDownFcn',@ImageClickCallback);
%     end
    
end

function [ind] = FindRectByPoint(x, y, data)
ind1 = x < data(:, 1);
ind2 = x > data(:, 3);
ind3 = y < data(:, 2);
ind4 = y > data(:, 4);
ind = ~(ind1 | ind2 | ind3 | ind4);

function [x1, y1, x2, y2] = XYSwap(x1, y1, x2, y2)
if (x1 > x2)
    temp = x1;
    x1 = x2;
    x2 = temp;
end

if (y1 > y2)
    temp = y1;
    y1 = y2;
    y2 = temp;
end

function [rect] = DrawRectangle(rect, color)
x1 = rect(1);
y1 = rect(2);
x2 = rect(3);
y2 = rect(4);
w = x2 - x1;
h = y2 - y1;
rect = rectangle('Position', [x1 y1 w h],...
    'EdgeColor', color, 'LineWidth', 1.5);

function ImageClickCallback ( hObject , eventData )
handles = guidata(hObject);
axesHandle  = get(hObject,'Parent');
% coordinates = get(axesHandle,'CurrentPoint'); 
handles.saveReminderCounter = handles.saveReminderCounter +1;
currentImage = handles.imageID;

if strcmp(handles.mode, 'create')
    coordinates = ginput(2);
    numObject = handles.numObject;
    
    x1 = coordinates(1,1);
    y1 = coordinates(1,2);
    x2 = coordinates(2,1);
    y2 = coordinates(2,2);
    [x1, y1, x2, y2] = XYSwap(x1, y1, x2, y2);
    % Swap coordinates
    
    numObject(currentImage) = numObject(currentImage)+1;
    handles.data{currentImage} = [handles.data{currentImage}; [x1 y1 x2 y2]];
    infoDisplay (handles.imageID, handles.data, numObject(currentImage));
    handles.numObject = numObject;
    
elseif strcmp(handles.mode, 'edit')
    coordinates = ginput(1);
    numObject = handles.numObject;
    x0 = coordinates(1,1);
    y0 = coordinates(1,2);
    
    ind = FindRectByPoint(x0, y0, handles.data{currentImage});
    ind = find(ind == 1);
    % If you clicked on mutliple rectangles, only take the one comes first
    ind = ind(1);
    
    rmv = handles.data{currentImage}(ind, :);
    handles.data{currentImage}(ind,:) = [];    
    numObject(currentImage) = numObject(currentImage) - 1;
    
    % infoDisplay (handles.imageID, handles.data, numObject(currentImage));
    rect = DrawRectangle(rmv, 'red');
    
    coordinates = ginput(2);
    x1 = coordinates(1,1);
    y1 = coordinates(1,2);
    x2 = coordinates(2,1);
    y2 = coordinates(2,2);
    [x1, y1, x2, y2] = XYSwap(x1, y1, x2, y2);
    delete(rect);
    
    rect = handles.graphics_rects{ind};
    handles.graphics_rects(ind) = [];
    delete(rect);
    
    handles.data{currentImage} = [handles.data{currentImage}; [x1 y1 x2 y2]];
    numObject(currentImage) = numObject(currentImage) + 1;
    handles.graphics_rects{end+1} = ...
        infoDisplay (handles.imageID, handles.data, numObject(currentImage));
    handles.numObject = numObject;
end


if (handles.saveReminderCounter >= 7)
   set(handles.saveReminder,'String','Please save');
end

disp([handles.imageID size(handles.data{handles.imageID},1)...
    handles.data{handles.imageID}(end,:)]);
guidata(hObject,handles);

% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
if handles.CreateNewRadioButton == eventdata.NewValue
    handles.mode = 'create';
elseif handles.EditRadioButton == eventdata.NewValue
    handles.mode = 'edit';
else
    error('Unknown mode chosen');
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function uipanel2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

time = cputime;
if (strcmp(eventdata.Key, 'a') || strcmp(eventdata.Key, 'leftarrow'))
%     if (strcmp(handles.last_key, 'shift') && ...
%             (time-handles.last_key_pressed < 0.1))
%         handles = guidata(hObject);
%         handles.imageID = handles.imageID-4;
%         guidata(hObject,handles);
%     end
    previous_button_Callback(hObject, eventdata, handles)
elseif (strcmp(eventdata.Key, 'd') || strcmp(eventdata.Key, 'rightarrow'))
%     if (strcmp(handles.last_key, 'shift') && ...
%             (time-handles.last_key_pressed < 0.1))
%         handles = guidata(hObject);
%         handles.imageID = handles.imageID+4;
%         guidata(hObject,handles);
%     end
    next_button_Callback(hObject, eventdata, handles)
elseif (strcmp(eventdata.Key, 'w') || strcmp(eventdata.Key, 'uparrow'))
    handles = guidata(hObject);
    handles.imageID = handles.imageID+4;
    guidata(hObject,handles);
    next_button_Callback(hObject, eventdata, handles)
elseif (strcmp(eventdata.Key, 's') || strcmp(eventdata.Key, 'downarrow'))
    handles = guidata(hObject);
    handles.imageID = handles.imageID-4;
    guidata(hObject,handles);
    next_button_Callback(hObject, eventdata, handles)
end
handles = guidata(hObject);
handles.last_key = eventdata.Key;
handles.last_key_pressed = time;
guidata(hObject,handles);

% --- Executes on key release with focus on figure1 and none of its controls.
function figure1_KeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)

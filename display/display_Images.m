function varargout = display_Images(varargin)
% DISPLAY_IMAGES MATLAB code for display_Images.fig
%      DISPLAY_IMAGES, by itself, creates a new DISPLAY_IMAGES or raises the existing
%      singleton*.
%
%      H = DISPLAY_IMAGES returns the handle to a new DISPLAY_IMAGES or the handle to
%      the existing singleton*.
%
%      DISPLAY_IMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAY_IMAGES.M with the given input arguments.
%
%      DISPLAY_IMAGES('Property','Value',...) creates a new DISPLAY_IMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before display_Images_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to display_Images_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help display_Images

% Last Modified by GUIDE v2.5 04-Apr-2016 15:52:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @display_Images_OpeningFcn, ...
    'gui_OutputFcn',  @display_Images_OutputFcn, ...
    'gui_LayoutFcn',  @display_Images_LayoutFcn, ...
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


% --- Executes just before display_Images is made visible.
function display_Images_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to display_Images (see VARARGIN)

% Choose default command line output for display_Images
handles.output = hObject;

% UIWAIT makes display_Images wait for user response (see UIRESUME)
% uiwait(handles.display_Images);

set(handles.FT_popup,'String',{'Pi';'SKAT';'Tausq';'Fisher';'Tippett'})
set(handles.FT_popup,'Value',4)

handles.out = varargin{1};

% Update handles structure
guidata(hObject, handles);

movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = display_Images_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in FT_popup.
function FT_popup_Callback(hObject, eventdata, handles)
% hObject    handle to FT_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FT_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FT_popup


% --- Executes during object creation, after setting all properties.
function FT_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FT_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function FDR_edit_Callback(hObject, eventdata, handles)
% hObject    handle to FDR_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDR_edit as text
%        str2double(get(hObject,'String')) returns contents of FDR_edit as a double


% --- Executes during object creation, after setting all properties.
function FDR_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDR_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Threshold_button.
function Threshold_button_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FT = get(handles.FT_popup,'Value');
switch FT
    case 1
        P_all = handles.out.Ppi;
    case 2
        P_all = handles.out.Pskat;
    case 3
        P_all = handles.out.Ptausq;
    case 4
        P_all = handles.out.Pfisher;
    case 5
        P_all = handles.out.Ptippett;
end

P_idx = find(P_all ~= 0);
P_vec = P_all(P_idx);
h = waitbar(0,'Performing FDR correction');
[FDR,Q] = mafdr(P_vec);
%P_FDRvec = mafdr(P_vec,'method','polynomial');
P_FDR = zeros(size(P_all));
P_FDR(P_idx) = Q;
waitbar(1,h)
delete(h)

P_sig = (P_FDR < 0.05) - (P_FDR == 0);
if sum(P_sig(:))
    L = bwlabeln(P_sig,26);
    CC = label2CC(L);
    Cluster_idx = CC.PixelIdxList;
    Cluster_peak = zeros(CC.NumObjects,1);
    Cluster_size = zeros(CC.NumObjects,1);
    for i = 1:CC.NumObjects
        P_cluster = P_FDR(Cluster_idx{i});
        [P_peak,I] = min(P_cluster);
        Cluster_peak(i) = Cluster_idx{i}(I);
        Cluster_size(i) = length(Cluster_idx{i});
    end
    [Cluster_size,I] = sort(Cluster_size,'descend');
    Cluster_idx = Cluster_idx(I);
    Cluster_peak = Cluster_peak(I);

    Cluster_list = cell(length(Cluster_idx),1);
    for i = 1:length(Cluster_idx)
        Cluster_list{i} = sprintf('Cluster %d (Size: %d)',i,Cluster_size(i));
    end
    set(handles.Cluster_list,'String',Cluster_list);

    handles.P_FDR = P_FDR;
    handles.Cluster_idx = Cluster_idx;
    handles.Cluster_peak = Cluster_peak;
else
    errordlg('No significant clusters')
end


% Update handles structure
guidata(hObject, handles);


function Background_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Background_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Background_edit as text
%        str2double(get(hObject,'String')) returns contents of Background_edit as a double


% --- Executes during object creation, after setting all properties.
function Background_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Background_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Background_button.
function Background_button_Callback(hObject, eventdata, handles)
% hObject    handle to Background_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.img;*.nii'});
if FileName
    set(handles.Background_edit,'String',[PathName,FileName]);
end


function Orientation_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Orientation_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Orientation_edit as text
%        str2double(get(hObject,'String')) returns contents of Orientation_edit as a double


% --- Executes during object creation, after setting all properties.
function Orientation_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Orientation_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Cluster_list.
function Cluster_list_Callback(hObject, eventdata, handles)
% hObject    handle to Cluster_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Cluster_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Cluster_list


% --- Executes during object creation, after setting all properties.
function Cluster_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cluster_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Save_button.
function Save_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uiputfile('*.img;*.nii');
if FileName
    
    pass = 1;
    
    %cluster
    if isempty(get(handles.Cluster_list,'String'))
        msg.cluster = 'Perform P value thresholding first and select a cluster to save';
        pass = 0;
    end
    
    if ~pass
        errordlg(struct2cell(msg))
    else
        Cluster = zeros(size(handles.P_FDR));
        Cluster_num = get(handles.Cluster_list,'Value');
        Cluster(handles.Cluster_idx{Cluster_num}) = handles.P_FDR(handles.Cluster_idx{Cluster_num});
        
        nii = make_nii(Cluster);
        h = waitbar(0,'Saving cluster');
        save_nii(nii,[PathName,FileName])
        
        idx = strfind(FileName, '.');
        if ~isempty(idx)
            FileName = FileName(1:idx(end)-1);
        end
        save([PathName,FileName,'.mat'],'Cluster')
        delete(h)
        
        msgbox('Cluster saved!')
    end
end


% --- Executes on button press in View_button.
function View_button_Callback(hObject, eventdata, handles)
% hObject    handle to View_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pass = 1;

%cluster
if isempty(get(handles.Cluster_list,'String'))
    msg.cluster = 'Perform P value thresholding first and select a cluster to view';
    pass = 0;
end

if pass
    %background
    Background = get(handles.Background_edit,'String');
    if ~isempty(Background)
        if exist(Background,'file')
            if strcmp(Background(end-3:end),'.img') || strcmp(Background(end-3:end),'.nii')
                hdr = load_nii_hdr(Background);
                if all(size(handles.P_FDR) == hdr.dime.dim(2:4))
                    background_img = load_nii(Background);
                    background_img = background_img.img;
                else
                    msg.dimension = ('Dimensions of "Images" and "Background" must be the same');
                    pass = 0;
                end
            else
                msg.extension = ('"Background" must be of filetype .img or .nii');
                pass = 0;
            end
        else
            msg.file = ('Path in "Background" must exist');
            pass = 0;
        end
    else
        background_img = [];
    end
    %orientation
    Orientation = get(handles.Orientation_edit,'String');
    if numel(Orientation) == 3
        reference = ['R' 'A' 'S'; 'L' 'P' 'I'];
        Orientation = upper(Orientation);
        if length(unique(Orientation)) == 3
            [C,ia,ib] = intersect(reference(:), Orientation);
            if length(C) == 3
                match = zeros(2,3);
                match(ia) = 1;
                if sum(match(:,1)) == 2
                    msg.RL = '"Orientation" must not contain both "R" and "L"';
                    pass = 0;
                end
                if sum(match(:,2)) == 2
                    msg.AP = '"Orientation" must not contain both "A" and "P"';
                    pass = 0;
                end
                if sum(match(:,3)) == 2
                    msg.AP = '"Orientation" must not contain both "S" and "I"';
                    pass = 0;
                end
            else
                msg.invalid = 'There are invalid characters in "Orientation"';
                pass = 0;
            end
        else
            msg.repeat = '"Orientation" must not have repeated characters';
            pass = 0;
        end
    else
        msg.elements = '"Orientation" must be 3 characters';
        pass = 0;
    end
end

if ~pass
    errordlg(struct2cell(msg))
else
    Cluster = zeros(size(handles.P_FDR));
    Cluster_num = get(handles.Cluster_list,'Value');
    Cluster(handles.Cluster_idx{Cluster_num}) = handles.P_FDR(handles.Cluster_idx{Cluster_num});
    Peak_idx = handles.Cluster_peak(Cluster_num);
    
    %orientation
    [rows,columns] = ind2sub([2 3],ia);
    [Y,I] = sort(columns);
    permutation = ib(I);
    Cluster = permute(Cluster,permutation);
    if ~isempty(background_img)
        background_img = permute(background_img,permutation);
    end
    
    for i = 1:3
        if match(2,i) == 1
            Cluster = flipdim(Cluster,i);
            if ~isempty(background_img)
                background_img = flipdim(background_img,i);
            end
        end
    end
    
    display3d(background_img,Cluster,Peak_idx)
end


% --- Creates and returns a handle to the GUI figure. 
function h1 = display_Images_LayoutFcn(policy)
% policy - create a new figure or use a singleton. 'new' or 'reuse'.

persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', [], ...
    'taginfo', struct(...
    'figure', 2, ...
    'text', 7, ...
    'edit', 5, ...
    'pushbutton', 5, ...
    'listbox', 3, ...
    'popupmenu', 2), ...
    'override', 0, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0, ...
    'lastSavedFile', '', ...
    'lastFilename', '');
appdata.lastValidTag = 'display_Images';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'display_Images');

h1 = figure(...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','Display results',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[520 395 400 340],...
'Resize','off',...
'HandleVisibility','callback',...
'UserData',[],...
'Tag','display_Images',...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'FT_text';

h2 = uicontrol(...
'Parent',h1,...
'HorizontalAlignment','left',...
'Position',[20 299 81 21],...
'String','P value map:',...
'Style','text',...
'Tag','FT_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'FT_popup';

h3 = uicontrol(...
'Parent',h1,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)display_Images('FT_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 279 261 21],...
'String',blanks(0),...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)display_Images('FT_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','FT_popup');

appdata = [];
appdata.lastValidTag = 'Threshold_button';

h4 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)display_Images('Threshold_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[300 279 81 21],...
'String','Threshold',...
'Tag','Threshold_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Background_text';

h5 = uicontrol(...
'Parent',h1,...
'HorizontalAlignment','left',...
'Position',[20 239 81 21],...
'String','Atlas:',...
'Style','text',...
'TooltipString','<html>Path of Background image<br/>Cluster being viewed is overlayed on this Background<br/>Note: Optional',...
'Tag','Background_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Background_edit';

h6 = uicontrol(...
'Parent',h1,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)display_Images('Background_edit_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'Position',[20 219 261 21],...
'String',blanks(0),...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)display_Images('Background_edit_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Background_edit');

appdata = [];
appdata.lastValidTag = 'Background_button';

h7 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)display_Images('Background_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[300 219 81 21],...
'String','Browse',...
'Tag','Background_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Orientation_text';

h8 = uicontrol(...
'Parent',h1,...
'HorizontalAlignment','left',...
'Position',[20 179 101 21],...
'String','Orientation:',...
'Style','text',...
'TooltipString','<html>Orientation of the Images and/or Background<br/>(R)ight or (L)eft<br/>(A)nterior or (P)osterior<br/>(S)uperior or (I)nferior<br/>Example: "RAS" means that the first, second and third dimensions<br/>increase in the right, anterior and superior directions respectively',...
'Tag','Orientation_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Orientation_edit';

h9 = uicontrol(...
'Parent',h1,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)display_Images('Orientation_edit_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'Position',[20 159 261 21],...
'String','RAS',...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)display_Images('Orientation_edit_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Orientation_edit');

appdata = [];
appdata.lastValidTag = 'Cluster_text';

h10 = uicontrol(...
'Parent',h1,...
'HorizontalAlignment','left',...
'Position',[20 119 141 21],...
'String','Significant cluster(s):',...
'Style','text',...
'Tag','Cluster_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Cluster_list';

h11 = uicontrol(...
'Parent',h1,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)display_Images('Cluster_list_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 19 261 101],...
'String',blanks(0),...
'Style','listbox',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)display_Images('Cluster_list_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Cluster_list');

appdata = [];
appdata.lastValidTag = 'Save_button';

h12 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)display_Images('Save_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[300 79 81 21],...
'String','Save cluster',...
'Tag','Save_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'View_button';

h13 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)display_Images('View_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[300 39 81 21],...
'String','View cluster',...
'Tag','View_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


hsingleton = h1;


% --- Set application data first then calling the CreateFcn. 
function local_CreateFcn(hObject, eventdata, createfcn, appdata)

if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   if isa(createfcn,'function_handle')
       createfcn(hObject, eventdata);
   else
       eval(createfcn);
   end
end


% --- Handles default GUIDE GUI creation and callback dispatch
function varargout = gui_mainfcn(gui_State, varargin)

gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error(message('MATLAB:guide:StateFieldNotFound', gui_StateFields{ i }, gui_Mfile));
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
    % DISPLAY_IMAGES
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % DISPLAY_IMAGES(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % DISPLAY_IMAGES('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % DISPLAY_IMAGES(...)
    % create the GUI and hand varargin to the openingfcn
    gui_Create = true;
end

if ~gui_Create
    % In design time, we need to mark all components possibly created in
    % the coming callback evaluation as non-serializable. This way, they
    % will not be brought into GUIDE and not be saved in the figure file
    % when running/saving the GUI from GUIDE.
    designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~ishghandle(fig)
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || isprop(fig,'__GUIDEFigure');
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
    % evaluate the callback now
    varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    % Set serializable of objects created in the above callback to off in
    % design time. Need to check whether figure handle is still valid in
    % case the figure is deleted during the callback dispatching.
    if designEval && ishghandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    % Check user passing 'visible' P/V pair first so that its value can be
    % used by oepnfig to prevent flickering
    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        % Recognize 'visible' P/V pair
        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    % Open fig file with stored settings.  Note: This executes all component
    % specific CreateFunctions with an empty HANDLES structure.

    
    % Do feval on layout code in m-file if it exists
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    % this application data is used to indicate the running mode of a GUIDE
    % GUI to distinguish it from the design mode of the GUI in GUIDE. it is
    % only used by actxproxy at this time.   
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);

        % make figure invisible here so that the visibility of figure is
        % consistent in OpeningFcn in the exported GUI case
        if isempty(gui_VisibleInput)
            gui_VisibleInput = get(gui_hFigure,'Visible');
        end
        set(gui_hFigure,'Visible','off')

        % openfig (called by local_openfig below) does this for guis without
        % the LayoutFcn. Be sure to do it here so guis show up on screen.
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        % If the figure has InGUIInitialization it was not completely created
        % on the last pass.  Delete this handle and try again.
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    if isappdata(0, genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]))
        rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));
    end

    % Set flag to indicate starting GUI initialization
    setappdata(gui_hFigure,'InGUIInitialization',1);

    % Fetch GUIDE Application options
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
    % Singleton setting in the GUI M-file takes priority if different
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        % Adjust background color
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

        % Generate HANDLES structure and store with GUIDATA. If there is
        % user set GUI data already, keep that also.
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    % Apply input P/V pairs other than 'visible'
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

    % If handle visibility is set to 'callback', turn it on until finished
    % with OpeningFcn
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        % Handle the default callbacks of predefined toolbar tools in this
        % GUI, if any
        guidemfile('restoreToolbarToolPredefinedCallback',gui_hFigure); 
        
        % Update handle visibility
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

        % Call openfig again to pick up the saved visibility or apply the
        % one passed in from the P/V pairs
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        % Done with GUI initialization
        if isappdata(gui_hFigure,'InGUIInitialization')
            rmappdata(gui_hFigure,'InGUIInitialization');
        end

        % If handle visibility is set to 'callback', turn it on until
        % finished with OutputFcn
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishghandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)

% openfig with three arguments was new from R13. Try to call that first, if
% failed, try the old openfig.
if nargin('openfig') == 2
    % OPENFIG did not accept 3rd input argument until R13,
    % toggle default figure visible to prevent the figure
    % from showing up too soon.
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    gui_hFigure = openfig(name, singleton, visible);  
    %workaround for CreateFcn not called to create ActiveX
    if feature('HGUsingMATLABClasses')
        peers=findobj(findall(allchild(gui_hFigure)),'type','uicontrol','style','text');    
        for i=1:length(peers)
            if isappdata(peers(i),'Control')
                actxproxy(peers(i));
            end            
        end
    end
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallback(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishghandle(varargin{2}), 1) ...
             && (~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])) || ...
                ~isempty(strfind(varargin{1}, '_CreateFcn'))) );
catch
    result = false;
end



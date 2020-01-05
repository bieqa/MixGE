function varargout = input_Matrix(varargin)
% input_Matrix MATLAB code for input_Matrix.fig
%      input_Matrix, by itself, creates a new input_Matrix or raises the existing
%      singleton*.
%
%      H = input_Matrix returns the handle to a new input_Matrix or the handle to
%      the existing singleton*.
%
%      input_Matrix('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in input_Matrix.M with the given input arguments.
%
%      input_Matrix('Property','Value',...) creates a new input_Matrix or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before input_Matrix_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to input_Matrix_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help input_Matrix

% Last Modified by GUIDE v2.5 04-Apr-2016 15:50:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @input_Matrix_OpeningFcn, ...
    'gui_OutputFcn',  @input_Matrix_OutputFcn, ...
    'gui_LayoutFcn',  @input_Matrix_LayoutFcn, ...
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


% --- Executes just before input_Matrix is made visible.
function input_Matrix_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to input_Matrix (see VARARGIN)

% Choose default command line output for input_Matrix
handles.output = hObject;

% UIWAIT makes input_Matrix wait for user response (see UIRESUME)
% uiwait(handles.input_Matrix);

set(handles.Matrix_radio,'Value',1)

variables = evalin('base','who');
variables(2:end+1) = variables;
variables{1} = 'Not selected';

set(handles.Matrix_popup,'String',variables)
set(handles.Genotype_popup,'String',variables)
set(handles.Characteristic_popup,'String',variables)
set(handles.Weight_popup,'String',variables)
set(handles.Covariate_popup,'String',variables)
set(handles.Environment_popup,'String',variables)

handles.variables = variables;

if ~isempty(varargin)
    varname = varargin{1};
    
    if any(strcmp(variables,varname{1}))
        set(handles.Matrix_popup,'Value',find(strcmp(variables,varname{1})))
    end
    if any(strcmp(variables,varname{5}))
        set(handles.Genotype_popup,'Value',find(strcmp(variables,varname{5})))
    end
    if any(strcmp(variables,varname{6}))
        set(handles.Characteristic_popup,'Value',find(strcmp(variables,varname{6})))
    end
    if any(strcmp(variables,varname{7}))
        set(handles.Weight_popup,'Value',find(strcmp(variables,varname{7})))
    end
    if any(strcmp(variables,varname{8}))
        set(handles.Covariate_popup,'Value',find(strcmp(variables,varname{8})))
    end
    if any(strcmp(variables,varname{9}))
        set(handles.Environment_popup,'Value',find(strcmp(variables,varname{9})))
    end
    set(handles.Output_edit,'String',varname{10})
else
    varname = cell(10,1);
    varname{4} = 1000;
end

handles.varname = varname;

% Update handles structure
guidata(hObject, handles);

movegui(hObject,'center')


% --- Outputs from this function are returned to the command line.
function varargout = input_Matrix_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Matrix_radio.
function Matrix_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Matrix_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Matrix_radio

set(handles.Matrix_radio,'Value',1)


% --- Executes on button press in Images_radio.
function Images_radio_Callback(hObject, eventdata, handles)
% hObject    handle to Images_radio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Images_radio

variables = handles.variables;

varname = handles.varname;

varname{1} = variables{get(handles.Matrix_popup,'Value')};
varname{5} = variables{get(handles.Genotype_popup,'Value')};
varname{6} = variables{get(handles.Characteristic_popup,'Value')};
varname{7} = variables{get(handles.Weight_popup,'Value')};
varname{8} = variables{get(handles.Covariate_popup,'Value')};
varname{9} = variables{get(handles.Environment_popup,'Value')};
varname{10} = get(handles.Output_edit,'String');

delete(handles.output)

input_Images(varname);


% --- Executes on selection change in Matrix_popup.
function Matrix_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Matrix_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Matrix_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Matrix_popup


% --- Executes during object creation, after setting all properties.
function Matrix_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Matrix_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Genotype_popup.
function Genotype_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Genotype_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Genotype_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Genotype_popup


% --- Executes during object creation, after setting all properties.
function Genotype_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Genotype_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Characteristic_popup.
function Characteristic_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Characteristic_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Characteristic_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Characteristic_popup


% --- Executes during object creation, after setting all properties.
function Characteristic_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Characteristic_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Weight_popup.
function Weight_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Weight_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Weight_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Weight_popup


% --- Executes during object creation, after setting all properties.
function Weight_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Weight_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Covariate_popup.
function Covariate_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Covariate_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Covariate_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Covariate_popup


% --- Executes during object creation, after setting all properties.
function Covariate_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Covariate_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Environment_popup.
function Environment_popup_Callback(hObject, eventdata, handles)
% hObject    handle to Environment_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Environment_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Environment_popup


% --- Executes during object creation, after setting all properties.
function Environment_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Environment_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Output_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Output_edit as text
%        str2double(get(hObject,'String')) returns contents of Output_edit as a double


% --- Executes during object creation, after setting all properties.
function Output_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Output_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Output_button.
function Output_button_Callback(hObject, eventdata, handles)
% hObject    handle to Output_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dir = uigetdir;
if dir
    set(handles.Output_edit,'String',dir);
end


% --- Executes on button press in Data_button.
function Data_button_Callback(hObject, eventdata, handles)
% hObject    handle to Data_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.mat'});
if FileName
    variables = handles.variables;
    
    varname = handles.varname;
    
    varname{1} = variables{get(handles.Matrix_popup,'Value')};
    varname{5} = variables{get(handles.Genotype_popup,'Value')};
    varname{6} = variables{get(handles.Characteristic_popup,'Value')};
    varname{7} = variables{get(handles.Weight_popup,'Value')};
    varname{8} = variables{get(handles.Covariate_popup,'Value')};
    varname{9} = variables{get(handles.Environment_popup,'Value')};
    varname{10} = get(handles.Output_edit,'String');
    
    evalin('base',['load(''',[PathName,FileName],''')'])
    
    variables = evalin('base','who');
    variables(2:end+1) = variables;
    variables{1} = 'Not selected';
    
    handles.variables = variables;
    
    set(handles.Matrix_popup,'String',variables)
    set(handles.Matrix_popup,'Value',find(strcmp(variables,varname{1})))
    set(handles.Genotype_popup,'String',variables)
    set(handles.Genotype_popup,'Value',find(strcmp(variables,varname{5})))
    set(handles.Characteristic_popup,'String',variables)
    set(handles.Characteristic_popup,'Value',find(strcmp(variables,varname{6})))
    set(handles.Weight_popup,'String',variables)
    set(handles.Weight_popup,'Value',find(strcmp(variables,varname{7})))
    set(handles.Covariate_popup,'String',variables)
    set(handles.Covariate_popup,'Value',find(strcmp(variables,varname{8})))
    set(handles.Environment_popup,'String',variables)
    set(handles.Environment_popup,'Value',find(strcmp(variables,varname{9})))
end

guidata(hObject, handles);

% --- Executes on button press in Load_button.
function Load_button_Callback(hObject, eventdata, handles)
% hObject    handle to Load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile({'*.m'});
if FileName
    variables = handles.variables;
    
    varname = handles.varname;
    
    varname{1} = variables{get(handles.Matrix_popup,'Value')};
    varname{5} = variables{get(handles.Genotype_popup,'Value')};
    varname{6} = variables{get(handles.Characteristic_popup,'Value')};
    varname{7} = variables{get(handles.Weight_popup,'Value')};
    varname{8} = variables{get(handles.Covariate_popup,'Value')};
    varname{9} = variables{get(handles.Environment_popup,'Value')};
    varname{10} = get(handles.Output_edit,'String');
    
    run([PathName,FileName]);
    loaded = zeros(8,1);
    removed = zeros(7,1);
    if exist('Data','var')
        if any(cellfun(@(x) exist(x,'file'),Data))
            loaded(1) = 1;
            
            for i = 1:length(Data)
                if exist(Data{i},'file')
                    evalin('base',['load(''',Data{i},''')'])
                end
            end
            variables = evalin('base','who');
            variables(2:end+1) = variables;
            variables{1} = 'Not selected';
            
            handles.variables = variables;
            
            set(handles.Matrix_popup,'String',variables)
            set(handles.Matrix_popup,'Value',find(strcmp(variables,varname{1})))
            set(handles.Genotype_popup,'String',variables)
            set(handles.Genotype_popup,'Value',find(strcmp(variables,varname{5})))
            set(handles.Characteristic_popup,'String',variables)
            set(handles.Characteristic_popup,'Value',find(strcmp(variables,varname{6})))
            set(handles.Weight_popup,'String',variables)
            set(handles.Weight_popup,'Value',find(strcmp(variables,varname{7})))
            set(handles.Covariate_popup,'String',variables)
            set(handles.Covariate_popup,'Value',find(strcmp(variables,varname{8})))
            set(handles.Environment_popup,'String',variables)
            set(handles.Environment_popup,'Value',find(strcmp(variables,varname{9})))
        end
    end
    if exist('Matrix','var')
        if any(strcmp(variables,Matrix))
            loaded(2) = 1;
            set(handles.Matrix_popup,'Value',find(strcmp(variables,Matrix)))
        end
        if isempty(Matrix)
            removed(1) = 1;
            set(handles.Matrix_popup,'Value',1)
        end
    end
    if exist('Genotype','var')
        if any(strcmp(variables,Genotype))
            loaded(3) = 1;
            set(handles.Genotype_popup,'Value',find(strcmp(variables,Genotype)))
        end
        if isempty(Genotype)
            removed(2) = 1;
            set(handles.Genotype_popup,'Value',1)
        end
    end
    if exist('Characteristic','var')
        if any(strcmp(variables,Characteristic))
            loaded(4) = 1;
            set(handles.Characteristic_popup,'Value',find(strcmp(variables,Characteristic)))
        end
        if isempty(Characteristic)
            removed(3) = 1;
            set(handles.Characteristic_popup,'Value',1)
        end
    end
    if exist('Weight','var')
        if any(strcmp(variables,Weight))
            loaded(5) = 1;
            set(handles.Weight_popup,'Value',find(strcmp(variables,Weight)))
        end
        if isempty(Weight)
            removed(4) = 1;
            set(handles.Weight_popup,'Value',1)
        end
    end
    if exist('Covariate','var')
        if any(strcmp(variables,Covariate))
            loaded(6) = 1;
            set(handles.Covariate_popup,'Value',find(strcmp(variables,Covariate)))
        end
        if isempty(Covariate)
            removed(5) = 1;
            set(handles.Covariate_popup,'Value',1)
        end
    end
    if exist('Environment','var')
        if any(strcmp(variables,Environment))
            loaded(7) = 1;
            set(handles.Environment_popup,'Value',find(strcmp(variables,Environment)))
        end
        if isempty(Environment)
            removed(6) = 1;
            set(handles.Environment_popup,'Value',1)
        end
    end
    if exist('Output','var')
        if ~isempty(Output)
            loaded(8) = 1;
            set(handles.Output_edit,'String',Output)
        else
            removed(7) = 1;
            set(handles.Output_edit,'String','')
        end
    end
    
    if sum(loaded)
        temp = {'"Data"','"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"','"Output"'};
        temp = strjoin3(temp(logical(loaded)));
        message.loaded = [temp,' loaded'];
    else
        message.loaded = 'Nothing was loaded';
    end
    
    if sum(removed)
        temp = {'"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"','"Output"'};
        temp = strjoin3(temp(logical(removed)));
        message.removed = [temp,' removed'];
    else
        message.removed = 'Nothing was removed';
    end
    
    msgbox(struct2cell(message))
end

guidata(hObject, handles);


% --- Executes on button press in Save_button.
function Save_button_Callback(hObject, eventdata, handles)
% hObject    handle to Save_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[FileName,PathName] = uiputfile('*.mat;*.m');
if FileName
    idx = strfind(FileName, '.');
    if ~isempty(idx)
        FileName = FileName(1:idx(end)-1);
    end
    
    variables = handles.variables;

    varname = handles.varname;

    varname{1} = variables{get(handles.Matrix_popup,'Value')};
    varname{5} = variables{get(handles.Genotype_popup,'Value')};
    varname{6} = variables{get(handles.Characteristic_popup,'Value')};
    varname{7} = variables{get(handles.Weight_popup,'Value')};
    varname{8} = variables{get(handles.Covariate_popup,'Value')};
    varname{9} = variables{get(handles.Environment_popup,'Value')};
    varname{10} = get(handles.Output_edit,'String');
    
    savelist = struct;
    for i = [1,5:9]
        if strcmp(varname{i},'Not selected')
            varname{i} = '';
        else
            if evalin('base',sprintf('exist(''%s'',''var'')',varname{i}))
                savelist.(varname{i}) = evalin('base',varname{i});
            end
        end
    end
    if ~isempty(fieldnames(savelist))
        save([PathName,'/',FileName,'_data.mat'],'-struct','savelist')
    end
    
    fID = fopen([PathName,FileName,'_batch.m'],'w');
    if ~isempty(fieldnames(savelist))
        fprintf(fID,'Data = {''%s''};\n',[PathName,FileName,'_data.mat']);
    else
        fprintf(fID,'Data = {''''};\n');
    end
    fprintf(fID,'Matrix = ''%s'';\n',varname{1});
    fprintf(fID,'Genotype = ''%s'';\n',varname{5});
    fprintf(fID,'Characteristic = ''%s'';\n',varname{6});
    fprintf(fID,'Weight = ''%s'';\n',varname{7});
    fprintf(fID,'Covariate = ''%s'';\n',varname{8});
    fprintf(fID,'Environment = ''%s'';\n',varname{9});
    fprintf(fID,'Output = ''%s'';',varname{10});
    fclose(fID);
end

msgbox('Batch saved!')


% --- Executes on button press in Past_button.
function Past_button_Callback(hObject, eventdata, handles)
% hObject    handle to Past_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_loader


% --- Executes on button press in Begin_button.
function Begin_button_Callback(hObject, eventdata, handles)
% hObject    handle to Begin_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

variables = handles.variables;

choice = cell(11,1);
choice{1} = get(handles.Matrix_popup,'Value');
choice{5} = get(handles.Genotype_popup,'Value');
choice{6} = get(handles.Characteristic_popup,'Value');
choice{7} = get(handles.Weight_popup,'Value');
choice{8} = get(handles.Covariate_popup,'Value');
choice{9} = get(handles.Environment_popup,'Value');
choice{10} = get(handles.Output_edit,'String');

%fetch values from 'base' and perform tests
specified = zeros(3,1);
base = ones(6,1);
dimension = ones(6,1) * 2;
numeric = ones(6,1);
nan = zeros(6,1);
allele = 1;
N = zeros(4,1);
p = zeros(3,1);
one = zeros(2,1);
pass = 1;
if choice{1} ~= 1
    specified(1) = 1;
    base(1) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{1}}));
    if base(1)
        Y = evalin('base',variables{choice{1}});
        dimension(1) = length(size(Y));
        numeric(1) = isnumeric(Y);
        nan(1) = any(isnan(Y(:)));
        N(1) = size(Y,1);
    end
end
if choice{5} ~= 1
    specified(2) = 1;
    base(2) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{5}}));
    if base(2)
        G = evalin('base',variables{choice{5}});
        dimension(2) = length(size(G));
        numeric(2) = isnumeric(G);
        nan(2) = any(isnan(G(:)));
        if ~isequal(unique(G),[0;1;2])
            allele = 0;
        end
        N(2) = size(G,1);
        p(1) = size(G,2);
    end
end
if choice{6} ~= 1
    base(3) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{6}}));
    if base(3)
        Z = evalin('base',variables{choice{6}});
        dimension(3) = length(size(Z));
        numeric(3) = isnumeric(Z);
        nan(3) = any(isnan(Z(:)));
        p(2) = size(Z,1);
    end
end
if choice{7} ~= 1
    base(4) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{7}}));
    if base(4)
        W = evalin('base',variables{choice{7}});
        dimension(4) = length(size(W));
        numeric(4) = isnumeric(W);
        nan(4) = any(isnan(W(:)));
        p(3) = size(W,1);
        one(1) = size(W,2);
    end
end
if choice{8} ~= 1
    base(5) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{8}}));
    if base(5)
        X = evalin('base',variables{choice{8}});
        dimension(5) = length(size(X));
        numeric(5) = isnumeric(X);
        nan(5) = any(isnan(X(:)));
        N(3) = size(X,1);
    end
end
if choice{9} ~= 1
    base(6) = evalin('base',sprintf('exist(''%s'',''var'')',variables{choice{9}}));
    if base(6)
        E = evalin('base',variables{choice{9}});
        dimension(6) = length(size(E));
        numeric(6) = isnumeric(E);
        nan(6) = any(isnan(E(:)));
        N(4) = size(E,1);
        one(2) = size(E,2);
    end
end
if choice{10}
    Output = choice{10};
    specified(3) = 1;
    directory = isdir(Output);
end

%first level check
if ~all(specified)
    temp = {'"Matrix"','"Genotype"','"Output"'};
    temp = strjoin3(temp(~logical(specified)));
    msg.specified = [temp,' must be specified'];
    pass = 0;
end
if ~all(base)
    temp = {'"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"'};
    temp = strjoin3(temp(~logical(base)));
    msg.base = [temp,' must exist in the workspace'];
    pass = 0;
end
if ~all(dimension==2)
    temp = {'"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"'};
    temp = strjoin3(temp(dimension~=2));
    msg.dimension = [temp,' must have dimension of 2'];
    pass = 0;
end
if ~all(numeric)
    temp = {'"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"'};
    temp = strjoin3(temp(~logical(numeric)));
    msg.numeric = [temp,' must be numeric'];
    pass = 0;
end
if any(nan)
    temp = {'"Matrix"','"Genotype"','"Characteristic"','"Weight"','"Covariate"','"Environment"'};
    temp = strjoin3(temp(logical(nan)));
    msg.nan = [temp,' must not contain NaN'];
    pass = 0;
end
if ~allele
    msg.allele = '"Genotype" must only consist of the values (0,1,2)';
    pass = 0;
end
if specified(3)
    if ~directory
        msg.directory = '"Output" must be a valid directory';
        pass = 0;
    end
end

%second level check
if pass
    temp = N(logical(N));
    if ~all(temp==temp(1))
        temp = {'"Matrix"','"Genotype"','"Covariate"','"Environment"'};
        temp = strjoin3(temp(logical(N)));
        msg.N = ['First dimensions of ',temp,' must be equal'];
        pass = 0;
    end
    temp = p(logical(p));
    if ~all(temp==temp(1))
        temp = {'"Characteristic"','"Weight"'};
        temp = strjoin3(temp(logical(p(2:3))));
        if sum(logical(p(2:3)))==1
            msg.p = ['Second dimension of "Genotype" must be of the same size as the first dimension of ',temp];
        else
            msg.p = ['Second dimension of "Genotype" must be of the same size as the first dimensions of ',temp];
        end
        pass = 0;
    end
    temp = one(logical(one));
    if ~all(temp==1)
        temp = {'"Weight"','"Environment"'};
        temp = strjoin3(temp(one>1));
        if sum(one>1)==1
            msg.one = ['Second dimension of ',temp,' must be of size 1'];
        else
            msg.one = ['Second dimensions of ',temp,' must be of size 1'];
        end
        pass = 0;
    end
end

if ~pass
    errordlg(struct2cell(msg))
else
    %run mist
    Parameters = struct;
    if exist('Z','var')
        Parameters.Z = Z;
    end
    if exist('W','var')
        Parameters.W = W;
    end
    if exist('X','var')
        Parameters.X = X;
    end
    if exist('E','var')
        Parameters.E = E;
    end
    out = mixge_main(Y,G,Parameters);
    
    %save output
    out.Phenotype = 'Matrix';
    if ~exist(Output,'dir')
        mkdir(Output)
    end
    string = [Output,'/out.mat'];
    if exist(string,'file')
        counter = 1;
        string = sprintf('%s/out (%d).mat',Output,counter);
        while(exist(string,'file'))
            counter = counter + 1;
            string = sprintf('%s/out (%d).mat',Output,counter);
        end
    end
    save(string,'out')
    
    Complete(out,sprintf('Output saved as: %s',string))
end


% --- Creates and returns a handle to the GUI figure. 
function h1 = input_Matrix_LayoutFcn(policy)
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
    'text', 13, ...
    'uipanel', 7, ...
    'radiobutton', 3, ...
    'popupmenu', 10, ...
    'pushbutton', 8, ...
    'edit', 3), ...
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
appdata.lastValidTag = 'Matrix';
appdata.GUIDELayoutEditor = [];
appdata.initTags = struct(...
    'handle', [], ...
    'tag', 'Matrix');

h1 = figure(...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','MixGE',...
'NumberTitle','off',...
'PaperPosition',get(0,'defaultfigurePaperPosition'),...
'Position',[520 417 700 360],...
'Resize','off',...
'HandleVisibility','callback',...
'UserData',[],...
'Tag','Matrix',...
'Visible','on',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Phenotype_panel';

h2 = uipanel(...
'Parent',h1,...
'Units','pixels',...
'FontWeight','bold',...
'Title','Phenotype',...
'Clipping','on',...
'Position',[20 99 221 241],...
'Tag','Phenotype_panel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Matrix_radio';

h3 = uicontrol(...
'Parent',h2,...
'Callback',@(hObject,eventdata)input_Matrix('Matrix_radio_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 200 61 21],...
'String','Matrix',...
'Style','radiobutton',...
'Tag','Matrix_radio',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Images_radio';

h4 = uicontrol(...
'Parent',h2,...
'Callback',@(hObject,eventdata)input_Matrix('Images_radio_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[80 200 81 21],...
'String','Images',...
'Style','radiobutton',...
'Tag','Images_radio',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Matrix_text';

h5 = uicontrol(...
'Parent',h2,...
'HorizontalAlignment','left',...
'Position',[20 160 61 21],...
'String','Matrix:',...
'Style','text',...
'TooltipString','<html>Matrix of Phenotype(s)<br/>Dimension: [Nxk]',...
'Tag','Matrix_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Matrix_popup';

h6 = uicontrol(...
'Parent',h2,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Matrix_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 140 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Matrix_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Matrix_popup');

appdata = [];
appdata.lastValidTag = 'Genotype_panel';

h7 = uipanel(...
'Parent',h1,...
'Units','pixels',...
'FontWeight','bold',...
'Title','Gene',...
'Clipping','on',...
'Position',[240 99 221 241],...
'Tag','Genotype_panel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Genotype_text';

h8 = uicontrol(...
'Parent',h7,...
'HorizontalAlignment','left',...
'Position',[20 199 81 21],...
'String','Genotype:',...
'Style','text',...
'TooltipString','<html>Matrix of Genotype(s)<br/>Dimension: [Nxp]<br/>Values: Number of minor alleles (0,1,2)',...
'Tag','Genotype_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Characteristic_text';

h9 = uicontrol(...
'Parent',h7,...
'HorizontalAlignment','left',...
'Position',[20 139 101 21],...
'String','Characteristic:',...
'Style','text',...
'TooltipString','<html>Matrix of Characteristic(s)<br/>Dimension: [pxq]<br/>Note: Intercept will be automatically added',...
'Tag','Characteristic_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Weight_text';

h10 = uicontrol(...
'Parent',h7,...
'HorizontalAlignment','left',...
'Position',[20 79 61 21],...
'String','Weight:',...
'Style','text',...
'TooltipString','<html>Vector of Weights<br/>Dimension: [px1]<br/>Note: Select none to give all SNPs equal weight',...
'Tag','Weight_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Genotype_popup';

h11 = uicontrol(...
'Parent',h7,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Genotype_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 179 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Genotype_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Genotype_popup');

appdata = [];
appdata.lastValidTag = 'Characteristic_popup';

h12 = uicontrol(...
'Parent',h7,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Characteristic_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 119 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Characteristic_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Characteristic_popup');

appdata = [];
appdata.lastValidTag = 'Weight_popup';

h13 = uicontrol(...
'Parent',h7,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Weight_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 59 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Weight_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Weight_popup');

appdata = [];
appdata.lastValidTag = 'Others_panel';

h14 = uipanel(...
'Parent',h1,...
'Units','pixels',...
'FontWeight','bold',...
'Title','Others',...
'Clipping','on',...
'Position',[460 99 221 241],...
'Tag','Others_panel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Covariate_text';

h15 = uicontrol(...
'Parent',h14,...
'HorizontalAlignment','left',...
'Position',[20 199 81 21],...
'String','Covariate:',...
'Style','text',...
'TooltipString','<html>Matrix of Covariate(s)<br/>Dimension: [Nxm]<br/>Note: Intercept will be automatically added',...
'Tag','Covariate_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Covariate_popup';

h16 = uicontrol(...
'Parent',h14,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Covariate_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 179 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Covariate_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Covariate_popup');

appdata = [];
appdata.lastValidTag = 'Environment_text';

h17 = uicontrol(...
'Parent',h14,...
'HorizontalAlignment','left',...
'Position',[20 139 101 21],...
'String','Environment:',...
'Style','text',...
'TooltipString','<html>Vector of Environment<br/>Dimension: [Nx1]<br/>Note: Optional',...
'Tag','Environment_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Environment_popup';

h18 = uicontrol(...
'Parent',h14,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Environment_popup_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[20 119 181 21],...
'String',{  'Pop-up Menu' },...
'Style','popupmenu',...
'Value',1,...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Environment_popup_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Environment_popup');

appdata = [];
appdata.lastValidTag = 'Output_text';

h19 = uicontrol(...
'Parent',h14,...
'HorizontalAlignment','left',...
'Position',[20 79 121 21],...
'String','Output Directory:',...
'Style','text',...
'TooltipString','<html>String of Output Directory<br/>Directory where results will be stored',...
'Tag','Output_text',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Output_edit';

h20 = uicontrol(...
'Parent',h14,...
'BackgroundColor',[1 1 1],...
'Callback',@(hObject,eventdata)input_Matrix('Output_edit_Callback',hObject,eventdata,guidata(hObject)),...
'HorizontalAlignment','left',...
'Position',[20 59 116 21],...
'String',blanks(0),...
'Style','edit',...
'CreateFcn', {@local_CreateFcn, @(hObject,eventdata)input_Matrix('Output_edit_CreateFcn',hObject,eventdata,guidata(hObject)), appdata} ,...
'Tag','Output_edit');

appdata = [];
appdata.lastValidTag = 'Output_button';

h21 = uicontrol(...
'Parent',h14,...
'Callback',@(hObject,eventdata)input_Matrix('Output_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[140 59 61 21],...
'String','Browse',...
'Tag','Output_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Data_button';

h22 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)input_Matrix('Data_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[30 59 201 21],...
'String','Load data file',...
'Tag','Data_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Load_button';

h23 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)input_Matrix('Load_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[250 59 201 21],...
'String','Load batch file',...
'Tag','Load_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Save_button';

h24 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)input_Matrix('Save_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[470 59 201 21],...
'String','Save batch file',...
'Tag','Save_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Past_button';

h25 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)input_Matrix('Past_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[140 19 201 21],...
'String','Display past results',...
'Tag','Past_button',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'Begin_button';

h26 = uicontrol(...
'Parent',h1,...
'Callback',@(hObject,eventdata)input_Matrix('Begin_button_Callback',hObject,eventdata,guidata(hObject)),...
'Position',[360 19 201 21],...
'String','Begin computation',...
'Tag','Begin_button',...
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
    % INPUT_MATRIX
    % create the GUI only if we are not in the process of loading it
    % already
    gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    % INPUT_MATRIX(ACTIVEX,...)
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallback(gui_State, varargin{:})
    % INPUT_MATRIX('CALLBACK',hObject,eventData,handles,...)
    gui_Create = false;
else
    % INPUT_MATRIX(...)
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



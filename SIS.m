function varargout = SIS(varargin)
% SIS M-file for SIS.fig
%      SIS, by itself, creates a new SIS or raises the existing
%      singleton*.
%
%      H = SIS returns the handle to a new SIS or the handle to
%      the existing singleton*.
%
%      SIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIS.M with the given input arguments.
%
%      SIS('Property','Value',...) creates a new SIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SIS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SIS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SIS

% Last Modified by tim Kinyanjui
% 13th Nov 2009

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SIS_OpeningFcn, ...
                   'gui_OutputFcn',  @SIS_OutputFcn, ...
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


% --- Executes just before SIS is made visible.
function SIS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SIS (see VARARGIN)

% Choose default command line output for SIS
handles.output = hObject;

%%%%%Time%%%%%
% Get the value of time
m=get(handles.Time_fxn,'String');

% Change to number
m=str2num(m);

% Save it in the handles
handles.time=m;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Birth Rate%%%%%
% Get the values of birth rate
m1=get(handles.Birth_rate_fxn,'String');

% Change to number
m1=str2num(m1);

% Save in the handles
handles.birth_rate=m1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Rate of Infection%%%%%
% Get the value of Rate of infection
m2=get(handles.FOI_fxn,'String');

% Change to number
m2=str2num(m2);

% Save in the handles
handles.FOI=m2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%Rate of Recovery%%%%%
% Get the values of rate of recovery
m3=get(handles.Recovery_rate_fxn,'String');

% Change to number
m3=str2num(m3);

% Save in the handles
handles.recovery_rate=m3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Call the SISModel to run the stochastic model
[S,I,time]=SISModel(handles.time,100,1,[handles.birth_rate handles.FOI handles.recovery_rate]);

% Clear axis in readiness for plotting
cla

% Do the figure labelling
title('Stochastic SIS with demography')
xlabel('Time in weeks')
ylabel('Number of individuals')

% Make the plot and label (legend)
hold on
plot(time,[S I],'linewidth',2)
legend('S','I')
axis([0 handles.time 0 105])
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SIS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SIS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Simulate.
function Simulate_Callback(hObject, eventdata, handles)
% hObject    handle to Simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Call the SISModel to run the stochastic model
[S,I,time]=SISModel(handles.time,99,1,[handles.birth_rate handles.FOI handles.recovery_rate]);

% Clear axis in readiness for plotting
cla

% Do the figure labelling
title('Stochastic SIS with demography')
xlabel('Time in weeks')
ylabel('Number of individuals')

% Make the plot and label (legend)
hold on
plot(time,[S I],'linewidth',2)
legend('S','I')
axis([0 handles.time 0 105])

function Time_fxn_Callback(hObject, eventdata, handles)
% hObject    handle to Time_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_fxn as text
%        str2double(get(hObject,'String')) returns contents of Time_fxn as a double

% Get the input value in the string field
m=get(hObject,'String');

% Convert the string in a number and store
handles.time=str2num(m);

% Update gui handle
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Time_fxn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FOI_fxn_Callback(hObject, eventdata, handles)
% hObject    handle to FOI_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FOI_fxn as text
%        str2double(get(hObject,'String')) returns contents of FOI_fxn as a double

% Get the value entered
m=get(hObject,'String');

% Convert and store
handles.FOI=str2num(m);

% Updata gui handles
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function FOI_fxn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FOI_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Birth_rate_fxn_Callback(hObject, eventdata, handles)
% hObject    handle to Birth_rate_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Birth_rate_fxn as text
%        str2double(get(hObject,'String')) returns contents of Birth_rate_fxn as a double

% Get the value entered
m=get(hObject,'String');

% Convert and store
handles.birth_rate=str2num(m);

% Update gui handles
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function Birth_rate_fxn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Birth_rate_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Recovery_rate_fxn_Callback(hObject, eventdata, handles)
% hObject    handle to Recovery_rate_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Recovery_rate_fxn as text
%        str2double(get(hObject,'String')) returns contents of Recovery_rate_fxn as a double

% Get the value entered
m=get(hObject,'String');

% Convert and store
handles.recovery_rate=str2num(m);

% Update gui handles
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Recovery_rate_fxn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Recovery_rate_fxn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



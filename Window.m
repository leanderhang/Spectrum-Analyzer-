function varargout = Window(varargin)
% WINDOW MATLAB code for Window.fig
%      WINDOW, by itself, creates a new WINDOW or raises the existing
%      singleton*.
%
%      H = WINDOW returns the handle to a new WINDOW or the handle to
%      the existing singleton*.
%
%      WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW.M with the given input arguments.
%
%      WINDOW('Property','Value',...) creates a new WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Window

% Last Modified by GUIDE v2.5 17-Nov-2018 18:14:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Window_OpeningFcn, ...
                   'gui_OutputFcn',  @Window_OutputFcn, ...
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


% --- Executes just before Window is made visible.
function Window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Window (see VARARGIN)

% Choose default command line output for Window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Windowmenu.
function Windowmenu_Callback(hObject, eventdata, handles)
% hObject    handle to Windowmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% we get the input from the windowmenu and then check what it is and save the
% result in the handles to be plotted later 
contents = cellstr(get(hObject,'String'));
menuchoice = contents{get(hObject,'Value')};
n = [0:handles.wlength-1];
handles.w = zeros(1,length(n));
if (strcmp(menuchoice,'Rectangular'))
    handles.w = [zeros(1,6), 100*ones(1,length(n)-12), zeros(1,6)];
elseif (strcmp(menuchoice,'Triangular'))
    handles.w = zeros(1,length(n));
    for i = 5:length(n)/2
        handles.w(i) = 10*n(i-4);
    end
    for k = length(n)/2+1:length(n)-5
        handles.w(k) = 2*10*n(length(n)/2) - 10*n(k+4);
    end
elseif (strcmp(menuchoice,'Hamming'))
    handles.w = 100 - 50*cos(2*pi*n/handles.wlength);
elseif (strcmp(menuchoice,'Hanning'))
    handles.w = 62 - 42*cos(2*pi*n/handles.wlength);
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Windowmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Windowmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Inputmenu.
function Inputmenu_Callback(hObject, eventdata, handles)
contents = cellstr(get(hObject,'String'));
popchoice = contents{get(hObject,'Value')};
% here we  get the input and then plot it on its corresponding plots then
% save it in the handles
fs = 10e3;
t = -.1:1/fs:.1;
w = 20e-3;
x = zeros(1,length(t));
handles.signal = zeros(1,length(t));
if (strcmp(popchoice,'SincSquare'))
    z1 = sinc(.25*fs/10*t);
    z2 = sinc(.25*fs/10*t);
    x = z1.*z2;
    handles.signal = z1.*z2;
elseif (strcmp(popchoice,'Sinc'))
    x = sinc(.25*fs/100*t);
    handles.signal = sinc(.25*fs/10*t);
elseif (strcmp(popchoice,'Rect'))
    x = rectpuls(t,w);
    handles.signal = rectpuls(t,w); 
elseif (strcmp(popchoice,'Tri'))
    x = tripuls(t,w);
    handles.signal = tripuls(t,w);
end
axes(handles.TimePlot);
title('TD');
xlabel('t');
grid on
xlim([-2 2])
stem(t,handles.signal)
axes(handles.FreqPlot);
xlim([-2 2])
grid on
title('FD');
xlabel('f');
stem(t,abs(fftshift(fft(handles.signal))))
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function Inputmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Inputmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function WindowShape_CreateFcn(hObject, eventdata, handles)
title('W[n]');
xlabel('n');
ylim([-1 1.5]);
xlim([-1,1.5]);
% Hint: place code in OpeningFcn to populate WindowShape


% --- Executes during object creation, after setting all properties.
function TimePlot_CreateFcn(hObject, eventdata, handles)
title('TD');
xlabel('t');
ylim([-1 1.5]);
xlim([-1,1.5]);


% --- Executes during object creation, after setting all properties.
function FreqPlot_CreateFcn(hObject, eventdata, handles)
title('FD');
xlabel('f');
ylim([-1 1.5]);
xlim([-1,1.5]);


% --- Executes on button press in Applybtn.
function pushbutton2_Callback(hObject, eventdata, handles)
z = handles.signal;
u = handles.w;
%this push button is for the resulting signal after windowing
handles.p = zeros(1,length(handles.w));
for i = 1:length(handles.p)
    handles.p(i) = u(i)*z(i)
end
axes(handles.TimeWindowPlot)
stem(handles.p)
axes(handles.FreqWindowPlot)
stem(abs(fftshift(fft(handles.p))))
guidata(hObject,handles)



function lentext_Callback(hObject, eventdata, handles)
x = get(hObject,'String');
handles.wlength =  str2double(get(hObject,'String')) 
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function lentext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lentext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in wndwbtn.
function wndwbtn_Callback(hObject, eventdata, handles)
axes(handles.WindowShape);  % in this function we define the windowing types for use by the user 
handles.n1 = [0:1:handles.wlength-1];
contents = cellstr(get(handles.Windowmenu,'String'));
menuchoice = contents{get(handles.Windowmenu,'Value')};
n = [0:handles.wlength-1];
handles.w = zeros(1,length(n));% we check what was the option and then generate the window signal with length saved in the handles
if (strcmp(menuchoice,'Rectangular'))
    handles.w = [zeros(1,6), 100*ones(1,length(n)-12), zeros(1,6)];
elseif (strcmp(menuchoice,'Triangular'))
    handles.w = zeros(1,length(n));
    for i = 5:length(n)/2
        handles.w(i) = 10*n(i-4);
    end
    for k = length(n)/2+1:length(n)-5
        handles.w(k) = 2*10*n(length(n)/2) - 10*n(k+4);
    end
elseif (strcmp(menuchoice,'Hanning'))
    handles.w = 50 - 50*cos(2*pi*n/handles.wlength);
elseif (strcmp(menuchoice,'Hamming'))
    handles.w = 54 - 46*cos(2*pi*n/handles.wlength);% we just multiplied the amplitude of all windows by 100
end
ylim([-1 , 1.5]);
xlim([-1,1.5]);
title('W[n]');
xlabel('n');
stem(handles.n1,handles.w)
guidata(hObject,handles)


% --- Executes on button press in Brwsbtn.
function Brwsbtn_Callback(hObject, eventdata, handles)
[file,path] = uigetfile('*.*');% we read the file and then get its time domain and FD
fid = fopen(fullfile(path,file));
Data = fread(fid);
handles.signal = double(Data);
axes(handles.TimePlot)
fs = 10e3;
t = -.1:1/fs:.1;
plot(handles.signal)
axes(handles.FreqPlot);
xlim([-2 2])
grid on
title('FD');
xlabel('f');
stem(abs(fftshift(fft(handles.signal))))
guidata(hObject,handles)

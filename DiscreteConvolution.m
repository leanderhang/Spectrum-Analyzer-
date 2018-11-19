function varargout = DiscreteConvolution(varargin)
% DISCRETECONVOLUTION MATLAB code for DiscreteConvolution.fig
%      DISCRETECONVOLUTION, by itself, creates a new DISCRETECONVOLUTION or raises the existing
%      singleton*.
%
%      H = DISCRETECONVOLUTION returns the handle to a new DISCRETECONVOLUTION or the handle to
%      the existing singleton*.
%
%      DISCRETECONVOLUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISCRETECONVOLUTION.M with the given input arguments.
%
%      DISCRETECONVOLUTION('Property','Value',...) creates a new DISCRETECONVOLUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DiscreteConvolution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DiscreteConvolution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DiscreteConvolution

% Last Modified by GUIDE v2.5 16-Nov-2018 20:29:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DiscreteConvolution_OpeningFcn, ...
                   'gui_OutputFcn',  @DiscreteConvolution_OutputFcn, ...
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


% --- Executes just before DiscreteConvolution is made visible.
function DiscreteConvolution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DiscreteConvolution (see VARARGIN)

% Choose default command line output for DiscreteConvolution
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DiscreteConvolution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DiscreteConvolution_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in Func1.
function Func1_Callback(hObject, eventdata, handles)
% hObject    handle to Func1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Func1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Func1


% --- Executes during object creation, after setting all properties.
function Func1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Func1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in func2.
function func2_Callback(hObject, eventdata, handles)
% hObject    handle to func2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns func2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from func2


% --- Executes during object creation, after setting all properties.
function func2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to func2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in convbtn.
function convbtn_Callback(hObject, eventdata, handles)
fs = 10e3;
t = -0.1:1/fs:0.1;
w = 20e-3;
contents = cellstr(get(handles.Func1,'String'));
functchoice = contents{get(hObject,'Value')};
signal = ones(1,length(t));
if(strcmp(functchoice,'Sinc'))
    signal = sinc(t);
elseif(strcmp(functchoice,'Rect'))
    signal = rectpuls(t,w);
elseif(strcmp(functchoice,'Sincsquare'))
    y1 = sinc(t);
    y2 = sinc(t);
    signal = y1.*y2;
elseif(strcmp(functchoice,'Tri'))
    signal = tripuls(t,w);
end
signal2 = zeros(1,length(t));
contents2 = cellstr(get(handles.func2,'String'));
popchoice2 = contents2{get(hObject,'Value')};
if (strcmp(popchoice2,'Sinc'))
    signal2 = sinc(t);
elseif (strcmp(popchoice2,'Rect'))
    signal2 = rectpuls(t,w);
elseif (strcmp(popchoice2,'Sincsqare'))
    z1 = sinc(t);
    z2 = sinc(t);
    signal2 = z1.*z2;
elseif (strcmp(popchoice2,'Tri'))
    signal2 = tripuls(t,w);
end
axes(handles.Y);
stem(conv(signal,signal2))
axes(handles.X1);
plot(t,signal)
axes(handles.X2);
plot(t,signal2)
guidata(hObject,handles);
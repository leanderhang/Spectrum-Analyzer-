function varargout = SECONDOPTIONGUI(varargin)
% SECONDOPTIONGUI MATLAB code for SECONDOPTIONGUI.fig
%      SECONDOPTIONGUI, by itself, creates a new SECONDOPTIONGUI or raises the existing
%      singleton*.
%
%      H = SECONDOPTIONGUI returns the handle to a new SECONDOPTIONGUI or the handle to
%      the existing singleton*.
%
%      SECONDOPTIONGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECONDOPTIONGUI.M with the given input arguments.
%
%      SECONDOPTIONGUI('Property','Value',...) creates a new SECONDOPTIONGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SECONDOPTIONGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SECONDOPTIONGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SECONDOPTIONGUI

% Last Modified by GUIDE v2.5 17-Nov-2018 22:08:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SECONDOPTIONGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SECONDOPTIONGUI_OutputFcn, ...
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


% --- Executes just before SECONDOPTIONGUI is made visible.
function SECONDOPTIONGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SECONDOPTIONGUI (see VARARGIN)

% Choose default command line output for SECONDOPTIONGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SECONDOPTIONGUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SECONDOPTIONGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in menuconv.
function menuconv_Callback(hObject, eventdata, handles)
fs = 10e3;% we choose fs to be 1 k
t = -0.1:1/fs:0.1; % length of t = 2000
w = handles.width;  % we get the width of the signal from the user 
contents = cellstr(get(handles.menuconv,'String'));
functchoice = contents{get(hObject,'Value')};% then we string compare the user input to choose which signal to be plotted on the graph
handles.signal = handles.amp*ones(1,length(t)); % we add the signa; to the handles to be used later in the ocnvolution and animation steps 
if(strcmp(functchoice,'Sine')) 
    handles.signal = handles.amp*sin(2*pi*.25*fs/100*t);
elseif(strcmp(functchoice,'Rect'))
    handles.signal = handles.amp*rectpuls(t,w);
elseif(strcmp(functchoice,'Linear'))
    handles.signal = handles.amp*.25*fs*t;
elseif(strcmp(functchoice,'Triangle'))
    handles.signal = handles.amp*tripuls(t,w);
end
axes(handles.ConvolutingSignal);    % we call the specified tagged axis to plot the signal on
stem(t,handles.signal)  
guidata(hObject,handles); % we update the handles with the end of the function
% Hints: contents = cellstr(get(hObject,'String')) returns menuconv contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuconv




% --- Executes during object creation, after setting all properties.
function menuconv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuconv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in convmenu2.
function convmenu2_Callback(hObject, ~, handles)
fs = 10e3;
% here we do the exact same thing as the previous signal 
t = -0.1:1/fs:0.1;
w = handles.width;
handles.signal2 = handles.amp*ones(1,length(t)); 
contents2 = cellstr(get(hObject,'String'));
popchoice2 = contents2{get(hObject,'Value')};
if (strcmp(popchoice2,'Sine'))
    handles.signal2 = handles.amp*sin(2*pi*.25*fs/100*t);
elseif (strcmp(popchoice2,'Rect'))
    handles.signal2 = handles.amp*rectpuls(t,w);
elseif (strcmp(popchoice2,'Linear'))
    handles.signal2 = handles.amp*.25*fs*t;
elseif (strcmp(popchoice2,'Triangle'))
    handles.signal2 = handles.amp*tripuls(t,w);
end
axes(handles.axes2);
stem(t,handles.signal2)
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns convmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from convmenu2


% --- Executes during object creation, after setting all properties.
function convmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to convmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotandCalcbtn.
function PlotandCalcbtn_Callback(hObject, eventdata, handles)
%we just specify the axis to plot our graph on
axes(handles.axes5);
stem(conv(handles.signal,handles.signal2))
guidata(hObject,handles);



% --- Executes on button press in Animatebtn.
function Animatebtn_Callback(hObject, eventdata, handles)
figure
% we get the two signals and do convolutioon for both of them then we plot
% one of them as it is and then shift it with time , then for the other
% signal we flip it and keep it as it is and when the overlap between the
% two signals occurs the result appears in the third graph
Q = handles.signal;
R = handles.signal2;
wq = length(Q);% length of signal
wr = length(R);%length of signal2
R=flip(R);% to fli[p and multiply as we do in the normal conv
c=conv(Q,R); 
%wa = length(a);
%wb = length(b);
Q =[Q zeros(1,wq+wr-1)]; % we add zeros to make both the same length
R =[zeros(1,wq-1) R zeros(1,wq)]; % if you notice the length in both signals is 2wq + wr-1, however we will multiply only until wq+wr-1 the length of the convolution
ai=Q;% to be used later
ci=zeros(1,wq+wr);% the signal that will be changed each iteration
t=-wq+1:wq+wr-1;

for i=1:wq+wr-1
    subplot(3,1,1)
    stem(t,Q)
    title('Q');
    xbounds = xlim;    
    subplot(3,1,2)
    stem(t,R,'r');
    title('R');
    xbounds = xlim;
    Q = [zeros(1,i) ai(1:end-i)];% this is to plot the shifted signal , ai here is added to put the signal after shift
    pause(0.000000000000000000000000000000001);
    subplot(3,1,3)
    ci(i)=c(i); % the result for each overlap that is being plotted on the third graph, ci is the value that is added each step to the animated graph
    stem (0:wq+wr-1,ci)
    xbounds = xlim;
end



% --- Executes on button press in Backbtn.
function Backbtn_Callback(hObject, eventdata, handles)
ProjectGUI;


% --- Executes during object creation, after setting all properties.
function PlotandCalcbtn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlotandCalcbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function amptxt_Callback(hObject, eventdata, handles)
% hObject    handle to amptxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
z = get(hObject,'String');% we get the input from the user and save it in the handles
handles.amp = str2double(get(hObject,'String'));
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function amptxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amptxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wdthtxt_Callback(hObject, eventdata, handles)
% hObject    handle to wdthtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = get(hObject,'String');% we asdd the value to the handles
handles.width = str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function wdthtxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wdthtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Enterbtn.
function Enterbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Enterbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

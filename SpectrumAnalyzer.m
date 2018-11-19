function varargout = SpectrumAnalyzer(varargin)
% SPECTRUMANALYZER MATLAB code for SpectrumAnalyzer.fig
%      SPECTRUMANALYZER, by itself, creates a new SPECTRUMANALYZER or raises the existing
%      singleton*.
%
%      H = SPECTRUMANALYZER returns the handle to a new SPECTRUMANALYZER or the handle to
%      the existing singleton*.
%
%      SPECTRUMANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTRUMANALYZER.M with the given input arguments.
%
%      SPECTRUMANALYZER('Property','Value',...) creates a new SPECTRUMANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpectrumAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpectrumAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpectrumAnalyzer

% Last Modified by GUIDE v2.5 17-Nov-2018 14:48:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SpectrumAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @SpectrumAnalyzer_OutputFcn, ...
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


% --- Executes just before SpectrumAnalyzer is made visible.
function SpectrumAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpectrumAnalyzer (see VARARGIN)

% Choose default command line output for SpectrumAnalyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SpectrumAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SpectrumAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Infilebtn.
function Infilebtn_Callback(hObject, eventdata, handles)
% hObject    handle to Infilebtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%contents = cellstr(get(handles.Browsetext,'String'));
%popchoice = contents{get(hObject,'Value')};
[file,path] = uigetfile('*.*');% to get the file 
fid = fopen(fullfile(path,file));
Data = fread(fid);  
handles.data = double(Data);    % we parse the data into double to be processible
N = length(Data);   % N here is different from the input functions
t = [0:1/N:1-1/N];
axes(handles.TimeDomain);   % to plot the signal
set(handles.TimeDomain,'title',text(.5,.5,'TD'));
set(handles.TimeDomain,'ylabel',text(.5,.5,'Amplitude'));
set(handles.TimeDomain,'xlabel',text(.5,.5,'t'));
set(handles.TimeDomain,'xlim',[-0.1 0.1],'ylim', [-5000 5000]);
plot(handles.data)
handles.Freq = abs(fftshift(fft(handles.data)));    % we fft shift the fft of the signal and then take its abs
axes(handles.FrequencyDomain);
set(handles.FrequencyDomain,'title',text(.5,.5,'FD'));
set(handles.FrequencyDomain,'ylabel',text(.5,.5,'Amplitude'));
set(handles.FrequencyDomain,'xlabel',text(.5,.5,'f'));
set(handles.FrequencyDomain,'xlim',[-1500 1500],'ylim', [0 10000]);
stem(handles.Freq)
guidata(hObject,handles)

% --- Executes on selection change in Functionmenu.
function Functionmenu_Callback(hObject, eventdata, handles)
fs = 10e3;%fs is 1k
t = -0.1:1/fs:0.1;
w = 20e-3;  %width of the signal
contents = cellstr(get(hObject,'String'));
functchoice = contents{get(hObject,'Value')};
popchoice = functchoice;    % we iterate over the possible functions and then add it to the handles
handles.data = zeros(1,length(t));
if (strcmp(popchoice,'SincSquare'))
    z1 = sinc(.25*fs/10*t);
    z2 = sinc(.25*fs/10*t);
    handles.data = z1.*z2;
elseif (strcmp(popchoice,'Sinc'))
    handles.data = sinc(.25*fs/10*t);
elseif (strcmp(popchoice,'Rect'))
    handles.data = rectpuls(t,w); 
elseif (strcmp(popchoice,'Tri'))
    handles.data = tripuls(t,w);
elseif(strcmp(functchoice,'Sine'))
    handles.data = sin(2*pi*0.25*fs/100*t);
elseif(strcmp(functchoice,'Cosine'))
    handles.data = cos(2*pi*.25*fs/100*t);
elseif(strcmp(functchoice,'Linear'))
    handles.data = 2*fs*t;
end
axes(handles.TimeDomain); % then we specify the figure to plot the signal
set(handles.TimeDomain,'title',text(.5,.5,'T-D'));
set(handles.TimeDomain,'ylabel',text(.5,.5,'Amp'));
set(handles.TimeDomain,'xlabel',text(.5,.5,'t'));
set(handles.TimeDomain,'xlim',[-0.1 0.1],'ylim', [0 1000]);
stem(t,handles.data)
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function Functionmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Functionmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in FreqOptin.
function FreqOptin_Callback(hObject, eventdata, handles)
% hObject    handle to FreqOptin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns FreqOptin contents as cell array
%        contents{get(hObject,'Value')} returns selected item from FreqOptin


% --- Executes during object creation, after setting all properties.
function FreqOptin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FreqOptin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cmprmodbtn.
function cmprmodbtn_Callback(hObject, eventdata, handles)
% hObject    handle to cmprmodbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ComparisonMode;

% --- Executes on button press in FFTbtn.
function FFTbtn_Callback(hObject, eventdata, handles)
figure;
subplot(2,1,1)
xlabel('f')
ylabel('Magnitude')
plot(abs(fftshift(FFT(handles.data)))) % FD of signal
subplot(2,1,2)
xlabel('f')
ylabel('Phase')
plot(unwrap(angle(fftshift(FFT(handles.data))))) % to plot the phase of the FD


% --- Executes on button press in backbtn.
function backbtn_Callback(hObject, eventdata, handles)
ProjectGUI;


function Browsetext_Callback(hObject, eventdata, handles)
% hObject    handle to Browsetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
txt = get(hObject,'String');
%        str2double(get(hObject,'String')) returns contents of Browsetext as a double


% --- Executes during object creation, after setting all properties.
function Browsetext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Browsetext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function FrequencyDomain_CreateFcn(hObject, eventdata, handles)
xlim([0,1500])
xlabel('f')
ylabel('Amp')
title('F-D')


% --- Executes during object creation, after setting all properties.
function TimeDomain_CreateFcn(hObject, eventdata, handles)
xlim([-.1,.1])
ylim([-5000,5000])
xlabel('t')
ylabel('Amp')
title('T-D')



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
numpoints = get(hObject,'String');% the user defined N 'not applicable in case of file'
handles.N = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in wndwbtn.
function wndwbtn_Callback(~, eventdata, handles)
Window; 

% --- Executes on button press in DFTbtn.
function DFTbtn_Callback(hObject, eventdata, handles)
handles.Freq = abs(fftshift(fft(handles.data,handles.N)));
axes(handles.FrequencyDomain);
set(handles.FrequencyDomain,'title',text(.5,.5,'F-D'));
set(handles.FrequencyDomain,'ylabel',text(.5,.5,'Amp'));
set(handles.FrequencyDomain,'xlabel',text(.5,.5,'t'));
set(handles.FrequencyDomain,'xlim',[-0.1 0.1],'ylim', [0 10000]);
stem(handles.Freq)
guidata(hObject,handles)


% --- Executes on selection change in scalemenu.
function scalemenu_Callback(hObject, eventdata, handles)
% hObject    handle to scalemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));
handles.scale = contents{get(hObject,'Value')};
if (strcmp(handles.scale,'Linear'))
    axes(handles.FrequencyDomain);
    plot(handles.Freq)
elseif(strcmp(handles.scale,'Logarithmic'))
    axes(handles.FrequencyDomain);
    loglog(handles.Freq)    %different plotting scales 
end
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function scalemenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalemenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

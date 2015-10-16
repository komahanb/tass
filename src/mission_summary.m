function varargout = mission_summary(varargin)
% MISSION_SUMMARY MATLAB code for mission_summary.fig
%      MISSION_SUMMARY, by itself, creates a new MISSION_SUMMARY or raises the existing
%      singleton*.
%
%      H = MISSION_SUMMARY returns the handle to a new MISSION_SUMMARY or the handle to
%      the existing singleton*.
%
%      MISSION_SUMMARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MISSION_SUMMARY.M with the given input arguments.
%
%      MISSION_SUMMARY('Property','Value',...) creates a new MISSION_SUMMARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mission_summary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mission_summary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mission_summary

% Last Modified by GUIDE v2.5 16-Oct-2015 06:18:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mission_summary_OpeningFcn, ...
                   'gui_OutputFcn',  @mission_summary_OutputFcn, ...
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


% --- Executes just before mission_summary is made visible.
function mission_summary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mission_summary (see VARARGIN)

% Choose default command line output for mission_summary
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mission_summary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mission_summary_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_drag_polar();

try 
load_data

BETA;
set(handles.beta1, 'String',  BETA(1) );
set(handles.beta2, 'String',  BETA(2) );
set(handles.beta3, 'String',  BETA(3) );
set(handles.beta4, 'String',  BETA(4) );
set(handles.beta5, 'String',  BETA(5) );
set(handles.beta6, 'String',  BETA(6) );
set(handles.beta7, 'String',  BETA(7) );
set(handles.beta8, 'String',  BETA(8) );
set(handles.beta9, 'String',  BETA(9) );
set(handles.beta10, 'String',  BETA(10) );
set(handles.beta11, 'String',  BETA(11) );
set(handles.beta12, 'String',  BETA(12) );

W_HIST;
set(handles.f1, 'String',  W_HIST(1) );
set(handles.f2, 'String',  W_HIST(2) );
set(handles.f3, 'String',  W_HIST(3) );
set(handles.f4, 'String',  W_HIST(4) );
set(handles.f5, 'String',  W_HIST(5) );
set(handles.f6, 'String',  W_HIST(6) );
set(handles.f7, 'String',  W_HIST(7) );
set(handles.f8, 'String',  W_HIST(8) );
set(handles.f9, 'String',  W_HIST(9) );
set(handles.f10, 'String',  W_HIST(10) );
set(handles.f11, 'String',  W_HIST(11) );
set(handles.f12, 'String',  W_HIST(12) );


W_F =W(4);
set(handles.wf1, 'String',  W_F*(1-W_HIST(1)) );
set(handles.wf2, 'String',  W_F*(1-W_HIST(2)) );
set(handles.wf3, 'String',  W_F*(1-W_HIST(3)) );
set(handles.wf4, 'String',  W_F*(1-W_HIST(4)) );
set(handles.wf5, 'String',  W_F*(1-W_HIST(5)) );
set(handles.wf6, 'String',  W_F*(1-W_HIST(6)) );
set(handles.wf7, 'String',  W_F*(1-W_HIST(7)) );
set(handles.wf8, 'String',  W_F*(1-W_HIST(8)) );
set(handles.wf9, 'String',  W_F*(1-W_HIST(9)) );
set(handles.wf10, 'String',  W_F*(1-W_HIST(10)) );
set(handles.wf11, 'String',  W_F*(1-W_HIST(11)) );
set(handles.wf12, 'String',  W_F*(1-W_HIST(12)) );

W_TO = sum(W) ;
set(handles.wto1, 'String',  W_TO*BETA(1) );
set(handles.wto2, 'String',  W_TO*BETA(2) );
set(handles.wto3, 'String',  W_TO*BETA(3) );
set(handles.wto4, 'String',  W_TO*BETA(4) );
set(handles.wto5, 'String',  W_TO*BETA(5) );
set(handles.wto6, 'String',  W_TO*BETA(6) );
set(handles.wto7, 'String',  W_TO*BETA(7) );
set(handles.wto8, 'String',  W_TO*BETA(8) );
set(handles.wto9, 'String',  W_TO*BETA(9) );
set(handles.wto10, 'String',  W_TO*BETA(10) );
set(handles.wto11, 'String',  W_TO*BETA(11) );
set(handles.wto12, 'String',  W_TO*BETA(12) );

S=W_TO/str2num(get(handles.w_s,'String'));

set(handles.wing_area, 'String', S);

set(handles.ws1, 'String',  W_TO*BETA(1)/S );
set(handles.ws2, 'String',  W_TO*BETA(2)/S );
set(handles.ws3, 'String',  W_TO*BETA(3)/S );
set(handles.ws4, 'String',  W_TO*BETA(4)/S );
set(handles.ws5, 'String',  W_TO*BETA(5)/S );
set(handles.ws6, 'String',  W_TO*BETA(6)/S );
set(handles.ws7, 'String',  W_TO*BETA(7)/S );
set(handles.ws8, 'String',  W_TO*BETA(8)/S );
set(handles.ws9, 'String',  W_TO*BETA(9)/S );
set(handles.ws10, 'String',  W_TO*BETA(10)/S);
set(handles.ws11, 'String',  W_TO*BETA(11)/S);
set(handles.ws12, 'String',  W_TO*BETA(12)/S);


tw=str2num(get(handles.thrust_weight,'String'));

set(handles.tw1, 'String',  tw/BETA(1)  );
set(handles.tw2, 'String',  tw/BETA(2)  );
set(handles.tw3, 'String',  tw/BETA(3)  );
set(handles.tw4, 'String',  tw/BETA(4)  );
set(handles.tw5, 'String',  tw/BETA(5)  );
set(handles.tw6, 'String',  tw/BETA(6)  );
set(handles.tw7, 'String',  tw/BETA(7)  );
set(handles.tw8, 'String',  tw/BETA(8)  );
set(handles.tw9, 'String',  tw/BETA(9)  );
set(handles.tw10, 'String',  tw/BETA(10) );
set(handles.tw11, 'String',  tw/BETA(11) );
set(handles.tw12, 'String',  tw/BETA(12) );

catch
    set(handles.wing_area, 'String', 'Run Weight Analysis!');

end














%set(handles.wf, 'String', round(W(4)));
%set(handles.gto, 'String', round(sum(W)));
%WTO  = sum(W);





function w_s_Callback(hObject, eventdata, handles)
% hObject    handle to w_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w_s as text
%        str2double(get(hObject,'String')) returns contents of w_s as a double


% --- Executes during object creation, after setting all properties.
function w_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thrust_weight_Callback(hObject, eventdata, handles)
% hObject    handle to thrust_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thrust_weight as text
%        str2double(get(hObject,'String')) returns contents of thrust_weight as a double


% --- Executes during object creation, after setting all properties.
function thrust_weight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thrust_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

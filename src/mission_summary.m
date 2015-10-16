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

% Last Modified by GUIDE v2.5 16-Oct-2015 01:52:52

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



function t_w_Callback(hObject, eventdata, handles)
% hObject    handle to t_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_w as text
%        str2double(get(hObject,'String')) returns contents of t_w as a double


% --- Executes during object creation, after setting all properties.
function t_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

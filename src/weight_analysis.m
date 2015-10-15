function varargout = weight_analysis(varargin)
% WEIGHT_ANALYSIS MATLAB code for weight_analysis.fig
%      WEIGHT_ANALYSIS, by itself, creates a new WEIGHT_ANALYSIS or raises the existing
%      singleton*.
%
%      H = WEIGHT_ANALYSIS returns the handle to a new WEIGHT_ANALYSIS or the handle to
%      the existing singleton*.
%
%      WEIGHT_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEIGHT_ANALYSIS.M with the given input arguments.
%
%      WEIGHT_ANALYSIS('Property','Value',...) creates a new WEIGHT_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before weight_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to weight_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help weight_analysis

% Last Modified by GUIDE v2.5 15-Oct-2015 02:11:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @weight_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @weight_analysis_OutputFcn, ...
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


% --- Executes just before weight_analysis is made visible.
function weight_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to weight_analysis (see VARARGIN)

% Choose default command line output for weight_analysis
clc;
handles.output = hObject;
pie(1);
title('Gross Takeoff Weight Breakdown');
%handles.compute_weight = plt;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes weight_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = weight_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in compute_weight.
function compute_weight_Callback(hObject, eventdata, handles)
% hObject    handle to compute_weight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    w_p = str2num(get(handles.w_p,'String'));
    w_c = str2num(get(handles.w_c,'String'));
    A = str2num(get(handles.A,'String'));
    B = str2num(get(handles.B,'String'));
    v_cruise_kts = str2num(get(handles.v_cruise_kts,'String'));
    R_nm = str2num(get(handles.R_nm,'String'));
    loiter_time_min = str2num(get(handles.loiter_time,'String'));
    p_res = str2num(get(handles.p_res,'String'));
    time_combat = str2num(get(handles.time_combat,'String'));
    C_cruise = str2num(get(handles.C_cruise,'String'));
    C_loiter = str2num(get(handles.C_loiter,'String'));
    C_combat = str2num(get(handles.C_combat,'String'));  
    method = lower(get(get(handles.method,'SelectedObject'), 'String')); %raymer/roskam empty weight
    W = weight_main(w_p, w_c, A, B, v_cruise_kts, R_nm, loiter_time_min,p_res, C_cruise, C_loiter, C_combat,time_combat, method);
    %fprintf('------------------------------------\n')
    %fprintf('Weights Breakdown:\n')
    %fprintf('------------------------------------\n')
    %fprintf('Payload Weight | %0.0f [lbs]  | %0.3f\n',100)
    %fprintf('Crew Weight    | %0.0f [lbs]  | %0.3f\n',w_c,fuel_frac)
    %fprintf('Empty Weight   | %0.0f [lbs]  | %0.3f\n',w_e,fuel_frac)
    %fprintf('Fuel Weight    | %0.0f [lbs]  | %0.3f\n',w_f,fuel_frac)
    %fprintf('------------------------------------\n')
    %fprintf('Gross Weight   | %0.0f [lbs] | %0.3f\n',w_to,fuel_frac)
    %fprintf('------------------------------------\n')
    %mass = handles.metricdata.density * handles.metricdata.volume;
    set(handles.wp, 'String', round(W(1)));
    set(handles.wc, 'String', round(W(3)));
    set(handles.we, 'String', round(W(2)));
    set(handles.wf, 'String', round(W(4)));
    set(handles.gto, 'String', round(sum(W)));
catch
    disp('Error Occurred');
    set(handles.wp, 'String', 'No Real Solution Exists!');
    set(handles.wc, 'String', 'No Real Solution Exists!');
    set(handles.we, 'String', 'No Real Solution Exists!');
    set(handles.wf, 'String', 'No Real Solution Exists!');
    set(handles.gto, 'String', 'No Real Solution Exists!');
end



function w_c_Callback(hObject, eventdata, handles)
% hObject    handle to w_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w_c as text
%        str2double(get(hObject,'String')) returns contents of w_c as a double


% --- Executes during object creation, after setting all properties.
function w_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w_p_Callback(hObject, eventdata, handles)
% hObject    handle to w_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w_p as text
%        str2double(get(hObject,'String')) returns contents of w_p as a double


% --- Executes during object creation, after setting all properties.
function w_p_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_Callback(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A as text
%        str2double(get(hObject,'String')) returns contents of A as a double


% --- Executes during object creation, after setting all properties.
function A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function B_Callback(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of B as text
%        str2double(get(hObject,'String')) returns contents of B as a double


% --- Executes during object creation, after setting all properties.
function B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function v_cruise_kts_Callback(hObject, eventdata, handles)
% hObject    handle to v_cruise_kts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_cruise_kts as text
%        str2double(get(hObject,'String')) returns contents of v_cruise_kts as a double


% --- Executes during object creation, after setting all properties.
function v_cruise_kts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_cruise_kts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function R_nm_Callback(hObject, eventdata, handles)
% hObject    handle to R_nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of R_nm as text
%        str2double(get(hObject,'String')) returns contents of R_nm as a double


% --- Executes during object creation, after setting all properties.
function R_nm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to R_nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_cruise_Callback(hObject, eventdata, handles)
% hObject    handle to C_cruise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_cruise as text
%        str2double(get(hObject,'String')) returns contents of C_cruise as a double


% --- Executes during object creation, after setting all properties.
function C_cruise_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_cruise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loiter_time_Callback(hObject, eventdata, handles)
% hObject    handle to loiter_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loiter_time as text
%        str2double(get(hObject,'String')) returns contents of loiter_time as a double


% --- Executes during object creation, after setting all properties.
function loiter_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loiter_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_loiter_Callback(hObject, eventdata, handles)
% hObject    handle to C_loiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_loiter as text
%        str2double(get(hObject,'String')) returns contents of C_loiter as a double


% --- Executes during object creation, after setting all properties.
function C_loiter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_loiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_combat_Callback(hObject, eventdata, handles)
% hObject    handle to time_combat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_combat as text
%        str2double(get(hObject,'String')) returns contents of time_combat as a double


% --- Executes during object creation, after setting all properties.
function time_combat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_combat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_combat_Callback(hObject, eventdata, handles)
% hObject    handle to C_combat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_combat as text
%        str2double(get(hObject,'String')) returns contents of C_combat as a double


% --- Executes during object creation, after setting all properties.
function C_combat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_combat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p_res_Callback(hObject, eventdata, handles)
% hObject    handle to p_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p_res as text
%        str2double(get(hObject,'String')) returns contents of p_res as a double


% --- Executes during object creation, after setting all properties.
function p_res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%weight_analysis_OpeningFcn(hObject, eventdata, handles)
set(handles.w_p,'String','432');
set(handles.w_c,'String', '210');
set(handles.A ,'String', '0.5091');
set(handles.B ,'String', '0.9505');
set(handles.v_cruise_kts ,'String', '458');
set(handles.R_nm ,'String', '550');
set(handles.loiter_time ,'String', '10');
set(handles.p_res ,'String', '10');
set(handles.time_combat ,'String', '10');
set(handles.C_cruise ,'String','1.4');
set(handles.C_loiter ,'String', '0.6');
set(handles.C_combat ,'String','2.0');
pie(1);
title('Gross Takeoff Weight Breakdown');
set(handles.we ,'String','');
set(handles.wp ,'String','');
set(handles.wf ,'String','');
set(handles.wc ,'String','');
set(handles.gto ,'String','');




% --- Executes on key press with focus on reset and none of its controls.
function reset_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

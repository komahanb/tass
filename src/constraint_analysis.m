function varargout = constraint_analysis(varargin)
% CONSTRAINT_ANALYSIS MATLAB code for constraint_analysis.fig
%      CONSTRAINT_ANALYSIS, by itself, creates a new CONSTRAINT_ANALYSIS or raises the existing
%      singleton*.
%
%      H = CONSTRAINT_ANALYSIS returns the handle to a new CONSTRAINT_ANALYSIS or the handle to
%      the existing singleton*.
%
%      CONSTRAINT_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONSTRAINT_ANALYSIS.M with the given input arguments.
%
%      CONSTRAINT_ANALYSIS('Property','Value',...) creates a new CONSTRAINT_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before constraint_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to constraint_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help constraint_analysis

% Last Modified by GUIDE v2.5 15-Oct-2015 22:28:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @constraint_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @constraint_analysis_OutputFcn, ...
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


% --- Executes just before constraint_analysis is made visible.
function constraint_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to constraint_analysis (see VARARGIN)
%clc;cla;
box on;

%grid on;
%grid minor;

axis([0 100 0 2.0]);

%title('\textbf{Constraint Analysis}','Interpreter','latex','fontsize',14);
xlabel('$\textrm{Wing Loading}~\frac{W_{TO}}{S}~[\frac{lb}{ft^2}]$','Interpreter','latex','fontsize',14);
ylabel('$\textrm{Thrust Loading}~\frac{T_{SL}}{W_{TO}}$','Interpreter','latex','fontsize',14);

% Choose default command line output for constraint_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes constraint_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = constraint_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global k1 k2 cd0
global kts_to_fts fts_to_mach kts_to_mach nm_to_ft

global_constants();
%% 

cla;

grid on;
box on;
grid minor;
hold on;
%%
v_cruise_kts   = str2double(get(handles.cc_v_kts,'String'));
h1             = str2double(get(handles.cc_h1,'String'));
h2             = str2double(get(handles.cc_h2,'String'));
r_cruise_nm    = str2double(get(handles.cc_r,'String'));
%dh_dt         = str2double(get(handles.w_p,'String'));
plot_cruise_climb(v_cruise_kts, h1, h2, r_cruise_nm);
%%
v_cruise_kts   = str2double(get(handles.roc_vel1,'String'));
h              = str2double(get(handles.roc_h1,'String'));
dT             = str2double(get(handles.roc_dt1,'String'));
dh_dt          = str2double(get(handles.roc_roc1,'String'));
power_setting  = lower(get(get(handles.roc_power_setting,'SelectedObject'), 'String'));
plot_climb(v_cruise_kts, h, dT, dh_dt, power_setting);
%%
v_cruise_kts   = str2double(get(handles.turn_velocity,'String'));
h1             = str2double(get(handles.turn_height,'String'));
n              = str2double(get(handles.turn_n,'String'));
plot_turn(v_cruise_kts, h1 ,n);
%%
h_to           = str2double(get(handles.to_h,'String'));
dT             = str2double(get(handles.to_dt,'String'));
s_to           = str2double(get(handles.to_s,'String'));
h_obs          = str2double(get(handles.to_hobs,'String'));
clmax_to       = str2double(get(handles.to_clmax,'String'));
plot_takeoff(h_to, dT, s_to,  h_obs, clmax_to);
%%
h              = str2double(get(handles.land_h,'String'));
dT             = str2double(get(handles.land_dt,'String'));
s_l            = str2double(get(handles.land_s,'String'));
h_obs          = str2double(get(handles.land_hobs,'String'));
clmax_land     = str2double(get(handles.land_clmax,'String'));
plot_landing(h, dT,s_l,  h_obs, clmax_land);
%%
v_max          = str2double(get(handles.max_vel,'String'));
h              = str2double(get(handles.max_h,'String'));
dT             = str2double(get(handles.max_dt,'String'));
power_setting  = lower(get(get(handles.max_power_button,'SelectedObject'), 'String'));
plot_max_speed(v_max,h,dT,power_setting);
%%
v_kts          = str2double(get(handles.sc_v,'String'));
h              = str2double(get(handles.sc_h,'String'));
power_setting  = lower(get(get(handles.sc_power_button,'SelectedObject'), 'String'));
plot_service_ceiling(v_kts,h,power_setting);
%%
%plot_rate_of_climb(); void

axes_and_label();

legend('Rate of Climb', 'Cruise Climb','Turn','Takeoff', 'Landing','Max Speed', 'Service Ceiling');

hold off;


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%axes_and_label();
clc;cla;






% --- Executes on button press in estimate_weights.
function estimate_weights_Callback(hObject, eventdata, handles)
% hObject    handle to estimate_weights (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
weight_analysis();


% --- Executes on button press in mission_summary.
function mission_summary_Callback(hObject, eventdata, handles)
% hObject    handle to mission_summary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mission_summary();


% --- Executes on button press in check_climb.
function check_climb_Callback(hObject, eventdata, handles)
% hObject    handle to check_climb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_climb


% --- Executes on button press in check_cruise_climb.
function check_cruise_climb_Callback(hObject, eventdata, handles)
% hObject    handle to check_cruise_climb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_cruise_climb


% --- Executes on button press in check_turn.
function check_turn_Callback(hObject, eventdata, handles)
% hObject    handle to check_turn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_turn


% --- Executes on button press in check_takeoff.
function check_takeoff_Callback(hObject, eventdata, handles)
% hObject    handle to check_takeoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_takeoff


% --- Executes on button press in check_landing.
function check_landing_Callback(hObject, eventdata, handles)
% hObject    handle to check_landing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_landing


% --- Executes on button press in check_max_speed.
function check_max_speed_Callback(hObject, eventdata, handles)
% hObject    handle to check_max_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_max_speed


% --- Executes on button press in check_service_ceiling.
function check_service_ceiling_Callback(hObject, eventdata, handles)
% hObject    handle to check_service_ceiling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_service_ceiling


% --- Executes on button press in check_rate_of_climb.
function check_rate_of_climb_Callback(hObject, eventdata, handles)
% hObject    handle to check_rate_of_climb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_rate_of_climb



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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_v_kts_Callback(hObject, eventdata, handles)
% hObject    handle to cc_v_kts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc_v_kts as text
%        str2double(get(hObject,'String')) returns contents of cc_v_kts as a double


% --- Executes during object creation, after setting all properties.
function cc_v_kts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc_v_kts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_h1_Callback(hObject, eventdata, handles)
% hObject    handle to cc_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc_h1 as text
%        str2double(get(hObject,'String')) returns contents of cc_h1 as a double


% --- Executes during object creation, after setting all properties.
function cc_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_r_Callback(hObject, eventdata, handles)
% hObject    handle to cc_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc_r as text
%        str2double(get(hObject,'String')) returns contents of cc_r as a double


% --- Executes during object creation, after setting all properties.
function cc_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roc_vel1_Callback(hObject, eventdata, handles)
% hObject    handle to roc_vel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roc_vel1 as text
%        str2double(get(hObject,'String')) returns contents of roc_vel1 as a double


% --- Executes during object creation, after setting all properties.
function roc_vel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roc_vel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roc_h1_Callback(hObject, eventdata, handles)
% hObject    handle to roc_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roc_h1 as text
%        str2double(get(hObject,'String')) returns contents of roc_h1 as a double


% --- Executes during object creation, after setting all properties.
function roc_h1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roc_h1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roc_dt1_Callback(hObject, eventdata, handles)
% hObject    handle to roc_dt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roc_dt1 as text
%        str2double(get(hObject,'String')) returns contents of roc_dt1 as a double


% --- Executes during object creation, after setting all properties.
function roc_dt1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roc_dt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function turn_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to turn_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turn_velocity as text
%        str2double(get(hObject,'String')) returns contents of turn_velocity as a double


% --- Executes during object creation, after setting all properties.
function turn_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to turn_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function turn_height_Callback(hObject, eventdata, handles)
% hObject    handle to turn_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turn_height as text
%        str2double(get(hObject,'String')) returns contents of turn_height as a double


% --- Executes during object creation, after setting all properties.
function turn_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to turn_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function turn_n_Callback(hObject, eventdata, handles)
% hObject    handle to turn_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of turn_n as text
%        str2double(get(hObject,'String')) returns contents of turn_n as a double


% --- Executes during object creation, after setting all properties.
function turn_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to turn_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cc_h2_Callback(hObject, eventdata, handles)
% hObject    handle to cc_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cc_h2 as text
%        str2double(get(hObject,'String')) returns contents of cc_h2 as a double


% --- Executes during object creation, after setting all properties.
function cc_h2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cc_h2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roc_roc1_Callback(hObject, eventdata, handles)
% hObject    handle to roc_roc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roc_roc1 as text
%        str2double(get(hObject,'String')) returns contents of roc_roc1 as a double


% --- Executes during object creation, after setting all properties.
function roc_roc1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roc_roc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_h_Callback(hObject, eventdata, handles)
% hObject    handle to to_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_h as text
%        str2double(get(hObject,'String')) returns contents of to_h as a double


% --- Executes during object creation, after setting all properties.
function to_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_dt_Callback(hObject, eventdata, handles)
% hObject    handle to to_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_dt as text
%        str2double(get(hObject,'String')) returns contents of to_dt as a double


% --- Executes during object creation, after setting all properties.
function to_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_hobs_Callback(hObject, eventdata, handles)
% hObject    handle to to_hobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_hobs as text
%        str2double(get(hObject,'String')) returns contents of to_hobs as a double


% --- Executes during object creation, after setting all properties.
function to_hobs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_hobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_s_Callback(hObject, eventdata, handles)
% hObject    handle to to_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_s as text
%        str2double(get(hObject,'String')) returns contents of to_s as a double


% --- Executes during object creation, after setting all properties.
function to_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function to_clmax_Callback(hObject, eventdata, handles)
% hObject    handle to to_clmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of to_clmax as text
%        str2double(get(hObject,'String')) returns contents of to_clmax as a double


% --- Executes during object creation, after setting all properties.
function to_clmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to to_clmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function land_h_Callback(hObject, eventdata, handles)
% hObject    handle to land_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of land_h as text
%        str2double(get(hObject,'String')) returns contents of land_h as a double


% --- Executes during object creation, after setting all properties.
function land_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to land_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function land_dt_Callback(hObject, eventdata, handles)
% hObject    handle to land_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of land_dt as text
%        str2double(get(hObject,'String')) returns contents of land_dt as a double


% --- Executes during object creation, after setting all properties.
function land_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to land_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function land_hobs_Callback(hObject, eventdata, handles)
% hObject    handle to land_hobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of land_hobs as text
%        str2double(get(hObject,'String')) returns contents of land_hobs as a double


% --- Executes during object creation, after setting all properties.
function land_hobs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to land_hobs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function land_s_Callback(hObject, eventdata, handles)
% hObject    handle to land_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of land_s as text
%        str2double(get(hObject,'String')) returns contents of land_s as a double


% --- Executes during object creation, after setting all properties.
function land_s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to land_s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function land_clmax_Callback(hObject, eventdata, handles)
% hObject    handle to land_clmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of land_clmax as text
%        str2double(get(hObject,'String')) returns contents of land_clmax as a double


% --- Executes during object creation, after setting all properties.
function land_clmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to land_clmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_vel_Callback(hObject, eventdata, handles)
% hObject    handle to max_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_vel as text
%        str2double(get(hObject,'String')) returns contents of max_vel as a double


% --- Executes during object creation, after setting all properties.
function max_vel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_vel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_h_Callback(hObject, eventdata, handles)
% hObject    handle to max_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_h as text
%        str2double(get(hObject,'String')) returns contents of max_h as a double


% --- Executes during object creation, after setting all properties.
function max_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_dt_Callback(hObject, eventdata, handles)
% hObject    handle to max_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_dt as text
%        str2double(get(hObject,'String')) returns contents of max_dt as a double


% --- Executes during object creation, after setting all properties.
function max_dt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_dt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sc_v_Callback(hObject, eventdata, handles)
% hObject    handle to sc_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sc_v as text
%        str2double(get(hObject,'String')) returns contents of sc_v as a double


% --- Executes during object creation, after setting all properties.
function sc_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sc_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sc_h_Callback(hObject, eventdata, handles)
% hObject    handle to sc_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sc_h as text
%        str2double(get(hObject,'String')) returns contents of sc_h as a double


% --- Executes during object creation, after setting all properties.
function sc_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sc_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

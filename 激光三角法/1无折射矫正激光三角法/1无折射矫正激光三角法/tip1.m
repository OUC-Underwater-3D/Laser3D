function varargout = tip1(varargin)
% TIP1 MATLAB code for tip1.fig
%      TIP1, by itself, creates a new TIP1 or raises the existing
%      singleton*.
%
%      H = TIP1 returns the handle to a new TIP1 or the handle to
%      the existing singleton*.
%
%      TIP1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIP1.M with the given input arguments.
%
%      TIP1('Property','Value',...) creates a new TIP1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tip1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tip1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tip1

% Last Modified by GUIDE v2.5 09-Nov-2017 15:15:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tip1_OpeningFcn, ...
                   'gui_OutputFcn',  @tip1_OutputFcn, ...
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


% --- Executes just before tip1 is made visible.
function tip1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tip1 (see VARARGIN)

% Choose default command line output for tip1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tip1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(gcf,'position',[250,55,40,5])
set(gcf,'Name','∂¡»°÷–') 

% --- Outputs from this function are returned to the command line.
function varargout = tip1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

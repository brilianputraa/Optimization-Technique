% You can get the figure here https://github.com/brilianputraa/Optimization-Technique/blob/master/untitled.fig

function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 20-Mar-2019 14:53:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in stepdes.
function stepdes_Callback(hObject, eventdata, handles)
% hObject    handle to stepdes (see GCBO
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
syms h(x1,x2)

a= str2double(get(handles.inputa,'string'));
b= str2double(get(handles.inputb,'string'));
cc= str2double(get(handles.inputcc,'string'));
dd= str2double(get(handles.inputdd,'string'));
e= str2double(get(handles.inpute,'string'));
fz= str2double(get(handles.inputfz,'string'));
ee= str2double(get(handles.inputee,'string'));
stepdesce(a,b,cc,dd,e,fz,ee);
datab = evalin('base', 'datab');
dataaa = evalin('base', 'dataaa');
datax1 = evalin('base', 'datax1');
datax2 = evalin('base', 'datax2');
datad1 = evalin('base', 'datad1');
datad2 = evalin('base', 'datad2');
nilx1=evalin('base','nilx1');
nilx2=evalin('base','nilx2');
h(x1,x2)=a*x1^2+b*x2^2+cc*x1*x2+dd*x1+e*x2+fz;
axes(handles.axes2);
ezcontour(h); 
grid on
hold on;scatter(datax1,datax2,'x');hold off
nline=size(datab,1);
ncolumn=6;
set(handles.uitable1,'data',cell(nline,ncolumn))
yy = get(handles.uitable1, 'data');
yy(:,1) = num2cell(datab);
yy(:,2) = num2cell(datax1);
yy(:,3) = num2cell(datax2);
yy(:,4) = num2cell(datad1);
yy(:,5) = num2cell(datad2);
yy(:,6) = num2cell(dataaa);
set(handles.uitable1, 'data', yy);
nline=size(nilx1,1);
ncolumn=2;
set(handles.uitable2,'data',cell(nline,ncolumn))
dd = get(handles.uitable2, 'Data');
dd(:,1) = num2cell(nilx1);
dd(:,2) = num2cell(nilx2);
set(handles.uitable2, 'Data', dd);


function stepdesce(a,b,cc,dd,e,fz,ee)
syms x1 x2 c(k) d(k)
datab=[];
dataaa=[];
datax1=[];
datax2=[];
datad1=[];
datad2=[];
ggg=b;
f=a*x1^2+b*x2^2+cc*x1*x2+dd*x1+e*x2+fz
h=gradient(f,[x1,x2])
x1=1;
x2=1;
aa=10;
b=1;
while ((aa > ee))
    syms g(k)
    datax1=[datax1;x1];
    assignin('base','datax1',datax1);
    datax2=[datax2;x2];
    assignin('base','datax2',datax2);
    datab=[datab;b];
    assignin('base','datab',datab);
    gradd=double(subs(h));
    gradx1=-gradd(1,:);
    gradx2=-gradd(2,:);
    datad1=[datad1;gradx1];
    assignin('base','datad1',datad1);
    datad2=[datad2;gradx2];
    assignin('base','datad2',datad2);
    x1=x1+k*gradx1;
    x2=x2+k*gradx2;
    c=x1;
    d=x2;
    g(k)=a*x1^2+ggg*x2^2+cc*x1*x2+dd*x1+e*x2+fz;
    za=diff(g,k)  
    k=double(solve(za,k))
    c=double(subs(c));   
    d=double(subs(d));   
    aa=sqrt(gradx1^2+gradx2^2);
    dataaa=[dataaa;aa];
    x1=c;
    x2=d;
    b=b+1;
    assignin('base','dataaa',dataaa);
end
assignin('base','nilx1',x1);
assignin('base','nilx2',x2);



function xbar = goldensec(fungsi)
syms g(k)
g(k)=fungsi;
gal=10^-12;
a=0;
b=3;
p=0.618;
l=b-a;
k1=a+(1-p)*l;
k2=a+p*l;
while (l>=gal) 
    c=double(g(k1));
    d=double(g(k2));
    if (c<d)
        b=k2;
        k2=k1;
        l=p*l;
        k1=a+(1-p)*l;
    elseif (c>d)
        a=k1;
        k1=k2;
        l=p*l;
        k2=a+p*l;
    else
        a=k1;
        b=k2;
        l=b-a;
        k1=a+(1-p)*l;
        k2=a+p*l;
    end
    if(l<=gal)
        xbar=(b+a)/2;
    end
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
if get(hObject,'Value')
    set(handles.edit2,'Visible','Off')
else
    set(handles.edit2,'Visible','On')
end

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


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function inputa_Callback(hObject, eventdata, handles)
% hObject    handle to inputa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputa as text
%        str2double(get(hObject,'String')) returns contents of inputa as a double
% a=str2double(get(hObject,'String'));
 
% --- Executes during object creation, after setting all properties.
function inputa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputb_Callback(hObject, eventdata, handles)
% hObject    handle to inputb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputb as text
%        str2double(get(hObject,'String')) returns contents of inputb as a double
% b=str2double(get(hObject,'String'));
% assignin('base','b1',b);
% --- Executes during object creation, after setting all properties.
function inputb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function  inputcc_Callback(hObject, eventdata, handles)
% hObject    handle to inputcc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of inputcc as text
%        str2double(get(hObject,'String')) returns contents of inputcc as a double

% --- Executes during object creation, after setting all properties.
function inputcc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputcc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function  inputdd_Callback(hObject, eventdata, handles)
% hObject    handle to inputdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputdd as text
%        str2double(get(hObject,'String')) returns contents of inputdd as a double
% dd=str2double(get(hObject,'String'));
% assignin('base','d1',dd);
% --- Executes during object creation, after setting all properties.
function inputdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function  inpute_Callback(hObject, eventdata, handles)
% hObject    handle to inpute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inpute as text
%        str2double(get(hObject,'String')) returns contents of inpute as a double
% e=str2double(get(hObject,'String'));
% assignin('base','e1',e);
% --- Executes during object creation, after setting all properties.
function inpute_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inpute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputfz_Callback(hObject, eventdata, handles)
% hObject    handle to inputfz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputfz as text
%        str2double(get(hObject,'String')) returns contents of inputfz as a double
% fz=str2double(get(hObject,'String'));
% assignin('base','f1',fz);

% --- Executes during object creation, after setting all properties.
function inputfz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputfz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ee= inputee_Callback(hObject, eventdata, handles)
% hObject    handle to inputee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputee as text
%        str2double(get(hObject,'String')) returns contents of inputee as a double
% ee=str2double(get(hObject,'String'));
% assignin('base','ee1',ee);

% --- Executes during object creation, after setting all properties.
function inputee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

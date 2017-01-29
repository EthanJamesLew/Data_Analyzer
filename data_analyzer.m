function varargout = data_analyzer(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_analyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @data_analyzer_OutputFcn, ...
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



function data_analyzer_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

x = 0:.1:6.28;
y = sin(x);
handles.p = plot(handles.main_axes, x, y);

handles.tabs = uitabgroup(handles.data_panel);

guidata(hObject, handles);



function varargout = data_analyzer_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function build_panel(hObject, eventdata, handles, tab)
btn = uicontrol(tab,'Style', 'pushbutton', 'String', 'delete',...
        'units', 'normalized',...
        'Position', [.9 0 .1 .2],...
        'Callback', {@destroy_tab, tab});
    
 color_btn = uicontrol(tab,'Style', 'pushbutton', 'String', 'color...',...
        'units', 'normalized',...
        'Position', [.9 .8 .1 .2],...
        'Callback', {@set_color, handles,  tab});
    
 txt = uicontrol(tab, 'Style','text',...
        'units', 'normalized',...
        'Position',[0 .8 .1 .2],...
        'String','Name');
    
 name = uicontrol(tab, 'Style','edit',...
        'units', 'normalized',...
        'Position',[.2 .8 .35 .2],...
        'String','',...
        'Callback', {@rename_tab, tab});

function set_color(hObject, eventdata, handles,  tab)
c = uisetcolor(handles.p);

    
function load_point(hObject, eventdata, tab)
[FileName,PathName] = uigetfile('*.csv','Select a CSV');
if(~(FileName==0))
end

function destroy_tab(hObject, eventdata, tab)
    delete(tab);
    
function rename_tab(hObject, eventdata, tab)
    set(tab, 'Title', get(hObject, 'String'));

function build_point_panel(hObject, eventdata, handles)
tab = uitab(handles.tabs,'Title','point');
build_panel(hObject, eventdata, handles, tab);
browse_btn = uicontrol(tab,'Style', 'pushbutton', 'String', 'browse...',...
        'units', 'normalized',...
        'Position', [.0 .5 .35 .2],...
        'Callback', {@load_point, tab});


function build_ode_panel(hObject, eventdata, handles)
tab = uitab(handles.tabs,'Title','ODE');
build_panel(hObject, eventdata, handles, tab);



function build_fx_panel(hObject, eventdata, handles)
tab = uitab(handles.tabs,'Title','f(x)');
build_panel(hObject, eventdata, handles, tab);



function add_point_button_Callback(hObject, eventdata, handles)
build_point_panel(hObject, eventdata, handles);

function add_fx_button_Callback(hObject, eventdata, handles)
build_fx_panel(hObject, eventdata, handles);

function add_ode_button_Callback(hObject, eventdata, handles)
build_ode_panel(hObject, eventdata, handles);


function figure1_SizeChangedFcn(hObject, eventdata, handles)
set(handles.figure1, 'units', 'pixels');
set(handles.bottom_container, 'units', 'pixels');
set(handles.main_axes, 'units', 'pixels');
t = get(handles.figure1, 'Position');

if t(3) > 30 && t(4) > 200
set(handles.bottom_container, 'Position', [0 5 t(3) 151]);
set(handles.main_axes, 'Position', [30 186 t(3)-30 t(4)-196]);
end
guidata(hObject, handles);

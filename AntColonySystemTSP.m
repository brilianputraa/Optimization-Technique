%Brilian Putra Amiruddin 07111740000088
function varargout = AntColonySystemTSP(varargin)
% ANTCOLONYSYSTEMTSP MATLAB code for AntColonySystemTSP.fig
%      ANTCOLONYSYSTEMTSP, by itself, creates a new ANTCOLONYSYSTEMTSP or raises the existing
%      singleton*.
%
%      H = ANTCOLONYSYSTEMTSP returns the handle to a new ANTCOLONYSYSTEMTSP or the handle to
%      the existing singleton*.
%
%      ANTCOLONYSYSTEMTSP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANTCOLONYSYSTEMTSP.M with the given input arguments.
%
%      ANTCOLONYSYSTEMTSP('Property','Value',...) creates a new ANTCOLONYSYSTEMTSP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AntColonySystemTSP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AntColonySystemTSP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AntColonySystemTSP

% Last Modified by GUIDE v2.5 27-May-2019 11:37:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AntColonySystemTSP_OpeningFcn, ...
                   'gui_OutputFcn',  @AntColonySystemTSP_OutputFcn, ...
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


% --- Executes just before AntColonySystemTSP is made visible.
function AntColonySystemTSP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AntColonySystemTSP (see VARARGIN)

% Choose default command line output for AntColonySystemTSP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AntColonySystemTSP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AntColonySystemTSP_OutputFcn(hObject, eventdata, handles) 
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
%ACS Algorithm
%Inisialisasi
% M = Jumlah Semut
% K = Jumlah Iterasi
% ro = Parameter Evaporasi Lokal
% a= Parameter Evaporasi Global
% b = Hubungan Parameter Evaporasi dengan Biaya
% cost= matriks penyimpan biaya perjalanan
% phe= matriks penyimpan pheromone awal
%qo = parameter tingkat eksploitasi dan eksplorasi
M=str2double(get(handles.edit2,'string'));;
K=str2double(get(handles.edit1,'string'));
ro=str2double(get(handles.edit3,'string'));
a=str2double(get(handles.edit4,'string'));
b=str2double(get(handles.edit7,'string'));
qo=str2double(get(handles.edit5,'string'));
phea=1; %ganti nilai disini untuk mengganti nilai pheromone awal
phe=zeros(7);
phe=bsxfun(@plus,phea,phe);%memasukkan nilai pheromone awal
phe=phe-diag(diag(phe));
localiter=[];
globalbest=[];
% cost=[0 25 20 30 15 18; 22 0 15 21 27 12; 20 16 0 32 10 21; 27 23 30 0 18 35; 15 25 12 20 0 24; 19 14 19 33 22 0];
%cost dari perjalanan bisa diganti sendiri di matriks cost
cost=[0 4 6.5 5 7.5 8.5 6; 4.5 0 8 5 5 6.5 8; 7 7.5 0 4 6 6 7; 5.5 6 5 0 7 4.5 5; 7 5 6.5 6 0 6 5.5; 9 7 7 5 7 0 9; 6 8.5 8.5 6 6.5 9.5 0;];
NN=KNN(cost);
tumpuk=[]; %list node per iterasi
N=length(cost)-1; %Jumlah Node
if ((b>0) & (a>0) & (a<1) & (qo>=0) & (qo<=1) & (ro>0) & (ro<1))
for i=1:K
        for iter=1:M
             J=length(cost);
             J=2:J;
             costiterasi=0;
             r=1; % matriks dimulai dari 1 tetapi dianggap node 0 (depo) karena di matlab defaultnya 1
             %list node yang belum dikunjungi
             S=[]; %list node yang sudah dikunjungi
             Ss=[];   % Untuk menyimpan rute perjalanan dan cost perjalanan per semut
             while (~isempty(J)) 
              q=rand();%membangkitkan nilai random
              if (q<=qo) %jika q<qo maka eksploitasi
                  panjangj=length(J);   
                  Sk=[];%menyimpan probabilitas kumulatif per node
                      for zz=1:length(J)        
                         tot=((phe(r,J(zz)))*(1/cost(r,J(zz)))^b)/sum((phe(r,J)*(ones(1,length(J))./(cost(r,J)))')); %mencari probabilitas
                        nod=[tot;J(zz)]; % node yang diiterasi
                        if (zz==1)
                           Sk=[Sk nod];
                        else
                           Sk=[Sk [Sk(1,zz-1)+tot; J(zz)]];
                        end
                      end
                      Skc=Sk(1,:);
                      [~,indks] = min(abs(Skc-qo)); % mendapatkan indeks nilai terdekat dari qo
              else %jika q>qo maka eksplorasi
                  Sk=[];%menyimpan hasil perkalian 1/cost dan pheromone
                     for zz=1:length(J)
                         tot=(1/cost(r,J(zz)))*phe(r,J(zz))^b;
                         Sk=[Sk [tot; J(zz)]];
                      % mendapatkan indeks nilai terdekat dari qo
                     end
                     Skc=Sk(1,:);
                     [~,indks] = max(abs(Skc));
              end
              terdekat = Sk(2,indks);
              costiterasi=costiterasi+cost(r,terdekat); % menghitung cost perjalanan setiap iterasi 
              S=[S terdekat] %update himpunan node yang sudah dikunjungi
              del=J==terdekat; % menemukan indeks J yang sudah dikunjungi
              J(del)=[];% mendelete elemen J yang sudah dikunjungi
              to=(1/(N*115)); %mendapatkan tau 0
              phe(r,terdekat)=(1-ro)*phe(r,terdekat)+ro*to; % melakukan local pheromone update
              r=terdekat;  % merubah r jadi terdekat atau s setelah melakukan pheromone update
              if (length(S)==length(cost)-1)
                  costiterasi=costiterasi+cost(r,1);
                  phe(r,1)=(1-ro)*phe(r,1)+ro*to; % update local pheromone saat semua node sudah dikunjungi dan kembali ke depo
                  S=S-1;
                  S=[0 S 0];
                  Ss=[Ss; [S costiterasi]]
              end
             end
             localiter=[localiter; Ss];
        end
        [~,idxbst]=min(localiter(:,length(cost)+2)); % menemukan indeks best iteration
        A=localiter(idxbst,1:length(cost)+1); % urutan bestiteration
        C=localiter(idxbst,length(cost)+2); %cost best iteration
        cut=[A(2:length(cost)-2)]; % urutan yang akan di insertion
        ii=0;
        pa=length(A)-2;% untuk mencari panjang matriks yang di tukar
        tumpuk=[A];% menjadikan hasil insertion sebuah matriks
        it=A;
        j=2; %j dan k digunakan untuk menukar urutan agar proses insertion bisa berjalan
        k=3;
        while ii~=1
            harga=0;
            tmp=it(j); % proses menukar urutan
            it(j)=it(k);
            it(k)=tmp;
            k=k+1;
            j=j+1;
            if (k==length(A)) %jika panjang k = panjang urutan maka harus di reset j dan k nya
                k=k-(N-1);
                j=j-(N-1);
            end
            if (it==A) %jika hasil urutan yang dihasilkan sama dengan bestiteration awal maka berhenti
                ii=1;
                break
            end
            for x=1:length(A)-1
                harga=harga+cost(it(x)+1,it(x+1)+1); %mendapatkan cost per iterasi
            end    
            tumpuk=[tumpuk; it] % menumpuk urutan
            C=[C; harga] % menumpuk harga
        end
        if (i==1) % iterasi pertama
        [bestcost,idx]=min(C); % mencari cost minimal untuk dijadikan best cost dan mencari indeks dari cost untuk digunakan mencari best iteration
        bestit=tumpuk(idx,:); % mencari best iteration dari indeks yang sudah didapatkan
        globalbest=[bestit bestcost];
        else
        [bestcostc,idx]=min(C); % mencari indeks lagi tetapi untuk iterasi setelah pertama
        bestitc=tumpuk(idx,:);
        globalbest=[globalbest; bestitc bestcostc]
            if(bestcostc<bestcost) %jika bestiterasi lebih besar daripada hasil dari iterasi selanjutnya maka tukar bestiterasi dengan bestiterasi baru
            bestcost=bestcostc;
            bestit=bestitc;
            end
        end
        for x=1:length(A)-1
            ja=bestit(x)+1;
            jb=bestit(x+1)+1;
            phe(ja,jb)=(1-a)*phe(ja,jb)+a*(1/bestcost);  %melakukan global pheromone update
        end
        bestit
        bestcost
        ca=[bestit bestcost];
end
kolom={'Depo','','','Urutan','','','','Depo','Cost'};
kolom2={'Depo','','','Urutan','','','','Depo','Cost'};
set(handles.uitable1,'Data',globalbest,'ColumnName',kolom);
set(handles.uitable2,'Data',ca,'ColumnName',kolom2);
else
    return
end
function NN=KNN(cost) %fungsi Nearest Neighbour
    K=length(cost);
    matb=1:K;
    tidak=1;
    hitung=1;
    indeks=1;
    urutan=[indeks-1];
    simpan=zeros(1,K);% menyimpan node yang sudah dilalui
    simpann=0; % menyimpan total cost
    while(tidak==1)
        simpan(hitung)=indeks;
        save=cost(indeks,:);%mencari cost terendah tiap node
        if (hitung~=K)
            val=min(save(1,setdiff(matb,simpan)));
            idx=find(save==val);
            idx=setdiff(idx,simpan); % mendapatkan indeks depo dengan jarak terdekat dari node sebelumnya
            idx=idx(1);
        end
        hitung=hitung+1;
        urutan=[urutan idx-1];
        indeks=idx; % mendapatkan indeks nomor depo
        simpann=simpann+val;
        if (hitung==K) % jika hitung sudah sama dengan jumlah node maka kembali ke depo
            simpan=[simpan 1];
            urutan=[urutan 0]; % menyimpan urutan perjalanan
            [val,idx]=min(cost(indeks,1));
            newsave=setdiff(matb,simpan);
            simpann=simpann+val;% mendapatkan urutan Nearest Neighbour
            tidak=0; %menghentikan iterasi jika sudah kembali lagi ke depo
        end
    end
    NN=simpann;%total cost menggunakan algoritma K Nearest Neighbours

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
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



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

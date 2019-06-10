matt=[0 0 0 0 0 0 1 1 0; -1 a -b c 0 0 0 0 (-a*x+b*y-c*z); 0 d -e f 1 0 0 0 (g-d*x+e*y-f*z); 0 h -i j 0 -1 1 0 (k-h*x+i*y-j*z); 0 l -m n 0 0 0 1 (o-l*x+m*y-n*z);];
hasil=matt;
nama={'Za' 'Z' 'x4' 'x6"' 'x7"'}';
hasil=[hasil;matt];
save=nama;
matt(1,:)=matt(1,:)-(matt(4,:)+matt(5,:));
nama=[nama; nama];
eks=[2,3,4];
nxt=1;
simpan=[];
simpanp=[];%simpan indeks penyelesaian
aha=[];
idxx=0;
x2=0;
while (nxt==1)
    arr=save;
    mins=min(matt(1,eks))
    idx= matt(1,:)==mins
    idx=find(idx==1,1)
    if (idx==2)
        lo='x1*';
        aha=[aha; 'x1'];
    elseif (idx==3)
        aha=[aha; 'x2'];
        lo='x2*';
    elseif (idx==4)
        aha=[aha; 'x3'];
        lo='x3*';
    elseif (idx==5)
        aha=[aha; 'x4'];
        lo='x4';
    elseif (idx==6)
        aha=[aha; 'x5'];
        lo='x5';
    end
    mins=1000000000000;
    for p=3:5
        hit=matt(p,9)/matt(p,idx);
        if(p~=idxx)
            if((hit<mins) & (hit>=0) & (hit~=Inf) & (hit~=NaN) & (hit~=-Inf))
                idxx=p;
                mins=hit;
            end
        else
            continue
        end
    end
    arr(idxx,1)=cellstr(lo);
    arr
    simpan=[simpan; idx]
    matt(idxx,:)=matt(idxx,:)/matt(idxx,idx);
    for q = 1:5
          kurang=(matt(q,idx)/matt(idxx,idx))*matt(idxx,:);
          if (q~=idxx)
            matt(q,:)=matt(q,:)-kurang;
          end
          matt
    end
    simpanp=[simpanp; idxx]
    if ((matt(2,2:4)>=0) & (matt(1,7:9)>=0))
        nxt=0;  %menghentikan loop ketika sudah terpenuhi syaratnya
    end
    indeks=any((eks==idxx),2);
    idxdel= eks(:,indeks);
    eks(:,indeks)=[];
    matt
    save=arr;
    nama=[nama; arr];
    hasil=[hasil;matt];
end
panjang=length(simpan);
for ok=1:panjang
    indeksx=simpanp(ok,:);
    angka=matt(indeksx,9);
    dd=aha(ok,:);
    eval([dd '=[angka]']);
end
x1=x1+x;
x2=x2-y;
x3=x3+z;
Z=-matt(2,9);
            
    
      

    

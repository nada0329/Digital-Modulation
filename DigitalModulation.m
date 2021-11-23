
clear;
clc;
%% if using octave then uncomment the next line
% pkg load communications;
% if using matlab ignore it


data=randi([0 1],1,1200000);

%%---------------------------- BPSK ----------------------%%

%mappimg
data_BPSK= 2.*data -1;
Eb_BPSK=1; %EB=((1+1)/2)/1
i=0;
for x=-4:2:16
 i=i+1;
 %add noise
 No=Eb_BPSK/(10^(x/10));
 noise_BPSK=sqrt(No/2)*randn(1,length(data));
 data_AWGN_BPSK=data_BPSK + noise_BPSK;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %demappimg
 for m=1: length(data)
 if ( data_AWGN_BPSK(1,m) > 0 )
 data_dem_BPSK(1,m)=1;
 else
 data_dem_BPSK(1,m)=0;
 end
 end
 %count error
 err_BPSK(i)=biterr(data,data_dem_BPSK) / (length(data));
 err_calc_BPSK(i)=0.5 *erfc(sqrt( Eb_BPSK/No ));
end
mat=real(data_BPSK);
matt=imag(data_BPSK);
figure
scatter(mat,matt,'LineWidth',2);
xlim([-2 2])
ylim([-2 2])
grid on
title ('Bpsk constellation');

%%------------------------ 8QAM  -----------------------------------------%%
Eb_8QAM=2; %EB=( (4(1+1)+4(1+3^2)) /8)/3
%mappimg
k=1;
for u=1:3:(length(data))
 if(data(u)==0 && data(u+1)==0 && data(u+2)==0) %000
 data_8QAM(k)= -3+1*j;
 elseif(data(u)==0 && data(u+1)==0 && data(u+2)==1) %001
 data_8QAM(k)= -3-1*j;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==0) %010
 data_8QAM(k)= -1+1*j;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==1) %011
 data_8QAM(k)= -1-1*j;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==0) %100
 data_8QAM(k)= 3+1*j;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==1) %101
 data_8QAM(k)= 3-1*j;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==0) %110
 data_8QAM(k)= 1+1*j;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==1) %111
 data_8QAM(k)= 1-1*j;
 end
 k=k+1;
end
o=1;
for x=-4:2:16
 %add noise
 No=(Eb_8QAM)/(10^(x/(10)));
 noise_8QAM=sqrt(No/2).*randn(1,length(data_8QAM)) + j*sqrt(No/2).*randn(1,length(data_8QAM));
 data_AWGN_8QAM=data_8QAM + noise_8QAM;
 %demappimg
 h=1;
 for m=1: length(data_8QAM)
 if ( real(data_AWGN_8QAM(m))>=0 && real(data_AWGN_8QAM(m))<=2 &&
imag(data_AWGN_8QAM(m))>=0 )
 data_dem_8QAM(h)=1;
 data_dem_8QAM(h+1)=1;
 data_dem_8QAM(h+2)=0;
 elseif ( real(data_AWGN_8QAM(m))>=0 && real(data_AWGN_8QAM(m))<=2 &&
imag(data_AWGN_8QAM(m))<0 )
 data_dem_8QAM(h)=1;
 data_dem_8QAM(h+1)=1;
 data_dem_8QAM(h+2)=1;
 elseif ( real(data_AWGN_8QAM(m))>=2 && imag(data_AWGN_8QAM(m))>=0 )
 data_dem_8QAM(h)=1;
 data_dem_8QAM(h+1)=0;
 data_dem_8QAM(h+2)=0; 
  elseif ( real(data_AWGN_8QAM(m))>2 && imag(data_AWGN_8QAM(m))<0 )
 data_dem_8QAM(h)=1;
 data_dem_8QAM(h+1)=0;
 data_dem_8QAM(h+2)=1;
 elseif ( real(data_AWGN_8QAM(m))<=0 && real(data_AWGN_8QAM(m))>=-2 &&
imag(data_AWGN_8QAM(m))>=0 )
 data_dem_8QAM(h)=0;
 data_dem_8QAM(h+1)=1;
 data_dem_8QAM(h+2)=0;
 elseif ( real(data_AWGN_8QAM(m))<=0 && real(data_AWGN_8QAM(m))>=-2 &&
imag(data_AWGN_8QAM(m))<0 )
 data_dem_8QAM(h)=0;
 data_dem_8QAM(h+1)=1;
 data_dem_8QAM(h+2)=1;
 elseif ( real(data_AWGN_8QAM(m))<=-2 && imag(data_AWGN_8QAM(m))>0 )
 data_dem_8QAM(h)=0;
 data_dem_8QAM(h+1)=0;
 data_dem_8QAM(h+2)=0;
 elseif ( real(data_AWGN_8QAM(m))<=-2 && imag(data_AWGN_8QAM(m))<=0 )
 data_dem_8QAM(h)=0;
 data_dem_8QAM(h+1)=0;
 data_dem_8QAM(h+2)=1;
 else
 data_dem_8QAM(h)=data(h);
 data_dem_8QAM(h+1)=data(h+1);
 data_dem_8QAM(h+2)=data(h+2);
 end
 h=h+3;
 end
 %count error
 err_8QAM(1,o)=biterr(data,data_dem_8QAM) / (length(data));
 err_calc_8QAM(1,o)=5/12*erfc(sqrt(Eb_8QAM/(2*No)));
 o=o+1;
end
mat=real(data_8QAM);
matt=imag(data_8QAM);
figure
scatter(mat,matt,'LineWidth',2);
xlim([-4 4])
ylim([-2 2])
grid on
title ('8QAM constellation');
 

%%--------------------------- QPSK -----------------------------------%%
Eb_QPSK=1; %EB=( 4(1+1) /4)/2
%mappimg
k=1;
for u=1:2:(length(data))
 if(data(u)==0 && data(u+1)==0 ) %00
 data_QPSK(k)= sqrt(2)*(cos(5*pi/4)+j*sin(5*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==1 ) %01
 data_QPSK(k)= sqrt(2)*(cos(3*pi/4)+j*sin(3*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==0 ) %10
 data_QPSK(k)= sqrt(2)*(cos(7*pi/4)+j*sin(7*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==1 ) %11
 data_QPSK(k)= sqrt(2)*(cos(1*pi/4)+j*sin(1*pi/4)) ;
 end
 k=k+1;
end
o=1;
for x=-4:2:16
 %add noise
 No=(Eb_QPSK)/(10^(x/(10)));
 noise_QPSK=sqrt(No/2).*randn(1,length(data_QPSK)) + j*sqrt(No/2).*randn(1,length(data_QPSK));
 data_AWGN_QPSK=data_QPSK + noise_QPSK;
 %demappimg
 h=1;
 for m=1: length(data_QPSK)
 if ( real(data_AWGN_QPSK(m))>=0 && imag(data_AWGN_QPSK(m))>0 )
 data_dem_QPSK(h)=1;
 data_dem_QPSK(h+1)=1;
 elseif ( real(data_AWGN_QPSK(m))>0 && imag(data_AWGN_QPSK(m))<=0 )
 data_dem_QPSK(h)=1;
 data_dem_QPSK(h+1)=0;
 elseif ( real(data_AWGN_QPSK(m))<=0 && imag(data_AWGN_QPSK(m))>0 )
 data_dem_QPSK(h)=0;
 data_dem_QPSK(h+1)=1;
 elseif ( real(data_AWGN_QPSK(m))<0 && imag(data_AWGN_QPSK(m))<=0 )
 data_dem_QPSK(h)=0;
 data_dem_QPSK(h+1)=0;
 end
 h=h+2;
 end
 %count error 
  err_QPSK(1,o)=biterr(data,data_dem_QPSK) ./ (length(data));
 err_calc_QPSK(1,o)=0.5 *erfc(sqrt( Eb_QPSK/No ));
 o=o+1;
end
mat=real(data_QPSK);
matt=imag(data_QPSK);
figure
scatter(mat,matt,'LineWidth',2);
xlim([-2 2])
ylim([-2 2])
grid on
title ('QPSK constellation');

%%------------------------------16PSK -----------------------------&&
Eb_16PSK=0.25; %EB=( (16*1) /16)/4
%mappimg
k=1;
for u=1:4:(length(data))
 if(data(u)==0 && data(u+1)==0 && data(u+2)==0 && data(u+3)==0 ) %0000
 data_16PSK(k)= (cos(0*pi/4)+j*sin(0*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==0 && data(u+2)==0 && data(u+3)==1 ) %0001
 data_16PSK(k)= (cos(0.5*pi/4)+j*sin(0.5*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==0 && data(u+2)==1 && data(u+3)==1 ) %0011
 data_16PSK(k)= (cos(1*pi/4)+j*sin(1*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==0 && data(u+2)==1 && data(u+3)==0 ) %0010
 data_16PSK(k)= (cos(1.5*pi/4)+j*sin(1.5*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==1 && data(u+3)==0 ) %0110
 data_16PSK(k)= (cos(2*pi/4)+j*sin(2*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==1 && data(u+3)==1 ) %0111
 data_16PSK(k)= (cos(2.5*pi/4)+j*sin(2.5*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==0 && data(u+3)==1 ) %0101
 data_16PSK(k)= (cos(3*pi/4)+j*sin(3*pi/4)) ;
 elseif(data(u)==0 && data(u+1)==1 && data(u+2)==0 && data(u+3)==0 ) %0100
 data_16PSK(k)= (cos(3.5*pi/4)+j*sin(3.5*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==0 && data(u+3)==0 ) %1100
 data_16PSK(k)= (cos(4*pi/4)+j*sin(4*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==0 && data(u+3)==1 ) %1101
 data_16PSK(k)= (cos(4.5*pi/4)+j*sin(4.5*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==1 && data(u+3)==1 ) %1111
 data_16PSK(k)= (cos(5*pi/4)+j*sin(5*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==1 && data(u+2)==1 && data(u+3)==0 ) %1110
 data_16PSK(k)= (cos(5.5*pi/4)+j*sin(5.5*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==1 && data(u+3)==0 ) %1010
 data_16PSK(k)= (cos(6*pi/4)+j*sin(6*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==1 && data(u+3)==1 ) %1011
 data_16PSK(k)= (cos(6.5*pi/4)+j*sin(6.5*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==0 && data(u+3)==1 ) %1001
 data_16PSK(k)= (cos(7*pi/4)+j*sin(7*pi/4)) ;
 elseif(data(u)==1 && data(u+1)==0 && data(u+2)==0 && data(u+3)==0 ) %1000
 data_16PSK(k)= (cos(7.5*pi/4)+j*sin(7.5*pi/4)) ;
 end
 k=k+1;
end
data_AWGN_16PSK=ones(1,length(data_16PSK));
r=1;
for x=-4:2:16
 %add noise
 No=(Eb_16PSK)/(10^(x/(10)));
 noise_16PSK=sqrt(No/2)*randn(1,length(data_16PSK)) +j*sqrt(No)*randn(1,length(data_16PSK));
 data_AWGN_16PSK=data_16PSK + noise_16PSK;
 %demappimg
 b=1;
 for m=1: length(data_AWGN_16PSK)
 phase_16=angle(data_AWGN_16PSK(1,m));
 if ( phase_16<=(0*(pi/16)) && phase_16>(-1*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16>(0*(pi/16)) && phase_16<(1*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(3*(pi/16)) && phase_16>(1*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(5*(pi/16)) && phase_16>(3*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(7*(pi/16)) && phase_16>(5*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(9*(pi/16)) && phase_16>(7*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(11*(pi/16)) && phase_16>(9*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(13*(pi/16)) && phase_16>(11*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(15*(pi/16)) && phase_16>(13*(pi/16)) )
 data_dem_16PSK(b)=0;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(-15*(pi/16)) && phase_16>(15*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(-13*(pi/16)) && phase_16>(-15*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(-11*(pi/16)) && phase_16>(-13*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(-9*(pi/16)) && phase_16>(-11*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=1;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(-7*(pi/16)) && phase_16>(-9*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=0;
 elseif ( phase_16<=(-5*(pi/16)) && phase_16>(-7*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=1;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(-3*(pi/16)) && phase_16>(-5*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=1;
 elseif ( phase_16<=(-1*(pi/16)) && phase_16>(-3*(pi/16)) )
 data_dem_16PSK(b)=1;
 data_dem_16PSK(b+1)=0;
 data_dem_16PSK(b+2)=0;
 data_dem_16PSK(b+3)=0;
 else
 data_dem_16PSK(b)=data(b);
 data_dem_16PSK(b+1)=data(b+1);
 data_dem_16PSK(b+2)=data(b+2);
 data_dem_16PSK(b+3)=data(b+3);
 end
 b=b+4;
 end
 %count error
 err_16PSK(1,r)=biterr(data,data_dem_16PSK ) / (length(data));
 err_calc_16PSK(1,r)=(1/4)*erfc(( sin(pi/16) )*sqrt( 4*Eb_16PSK/No ) );
 r=r+1;
end
mat=real(data_16PSK);
matt=imag(data_16PSK);
figure
scatter(mat,matt,'LineWidth',2);
xlim([-2 2])
ylim([-2 2])
grid on
title ('16PSK constellation');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot BER            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ratio=(-4:2:16);
figure
semilogy(ratio,err_BPSK,'b','LineWidth',2);
hold on
semilogy(ratio,err_8QAM,'r','LineWidth',2);
hold on
semilogy(ratio,err_QPSK,'g','LineWidth',2);
hold on
semilogy(ratio,err_16PSK,'k','LineWidth',2);
hold on
semilogy(ratio,err_calc_BPSK,'--b','LineWidth',2);
hold on
semilogy(ratio,err_calc_8QAM,'--r','LineWidth',2);
hold on
semilogy(ratio,err_calc_QPSK,'--g','LineWidth',2);
hold on
semilogy(ratio,err_calc_16PSK,'--k','LineWidth',2);
xlim([-4 16])
xlabel('Eb/No (dB)');
ylabel('BER');
title('BER for different modulations');
legend('BER BPSK','BER 8QAM','BER QPSK','BER 16PSK','BER BPSK theoritical' ,'BER 8QAM theoritical' ,'BER QPSK theoritical' ,'BER 16PSK theoritical');
 
 


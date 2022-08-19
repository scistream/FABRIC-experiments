clear all;
close all;
clc;

fsize=24;
fsize_legend = 22;
fsize_axis = 24;
fname = 'Times New Roman';

fig = figure;


%data1 = dlmread('LAN_TCP_Jitter.csv')';
%data2 = dlmread('Metro_TCP_Jitter.csv')';
%data3 = dlmread('ShortWAN_TCP_Jitter.csv')';
%data4 = dlmread('WAN_TCP_Jitter.csv')';
%data5 = dlmread('LongWAN_TCP_Jitter.csv')';

data1 = dlmread('LAN_UDP_Jitter.csv')';
data2 = dlmread('Metro_UDP_Jitter.csv')';
data3 = dlmread('ShortWAN_UDP_Jitter.csv')';
data4 = dlmread('WAN_UDP_Jitter.csv')';
data5 = dlmread('LongWAN_UDP_Jitter.csv')';

subplot(1,5,1)
boxplot(data1)
ylim([0 0.002])
xlabel('LAN','fontname',fname,'fontsize',fsize);
set(gca,'xticklabel',[])
%set(gca,'yticklabel',[])

subplot(1,5,2)
boxplot(data2)
ylim([0 0.002])
xlabel('Metro','fontname',fname,'fontsize',fsize);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])

subplot(1,5,3)
boxplot(data3)
ylim([0 0.002])
xlabel('Short WAN','fontname',fname,'fontsize',fsize);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])

subplot(1,5,4)
boxplot(data4)
ylim([0 0.002])
xlabel('WAN','fontname',fname,'fontsize',fsize);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])

subplot(1,5,5)
boxplot(data5)
ylim([0 0.002])
xlabel('Long WAN','fontname',fname,'fontsize',fsize);
set(gca,'xticklabel',[])
set(gca,'yticklabel',[])

han=axes(fig,'visible','off'); 
han.YLabel.Visible='on';
%set(gca,'YTick')
ylabel(sprintf('Jitter','Interpreter','latex','fontname',fname,'fontsize',fsize));




clear all;
close all;
clc;

%data=dlmread('LAN_TCP_Through.csv');
%data=dlmread('Metro_TCP_Through.csv');
%data=dlmread('ShortWAN_TCP_Through.csv');
%data=dlmread('WAN_TCP_Through.csv');
%data=dlmread('LongWAN_TCP_Through.csv');


fsize=24;
fsize_legend = 22;
fsize_axis = 24;
fname = 'Times New Roman';

figure;
hold on;

samp1 = [0.997833333	0.94225	0.869916667	0.703083333	0.319416667];
samp2 = [0.9325	0.9115	0.85325	0.694666667	0.375062505];
%samp3 = A(28:37,3);
%samp4 = A(41:50,3);
%samp5 = A(54:63,3);

err = [0.026048323	0.059085647	0.097224631	0.021491894	0.014681208];
err2= [0.019598237	0.013554603	0.088699826	0.051734169	0.072966474];
%C1 = addcolor(1);
%C2 = addcolor(98);
%C3 = addcolor(135);
%C4 = addcolor(214);
%C5 = addcolor(215);
x=1:5;
h1 = errorbar(x,samp1,err);
h2 = errorbar(x,samp2,err2);


%y=0.2;0.1;0.9; 
%h1 = plot(x,data(1,:), 'color',[0.49 0.18 0.56],'LineStyle','-','Marker','+','MarkerEdgeColor',[0.49 0.18 0.56],'MarkerFaceColor','w','MarkerSize',20);
%h2 = plot(x,data(2,:), 'color',[0.94 0.39 0.28],'LineStyle','--','Marker','o','MarkerEdgeColor',[0.94 0.39 0.28],'MarkerFaceColor','w','MarkerSize',20);
%h3 = plot(x,data(3,:), 'color',[1 0.66 0.196],'LineStyle',':','Marker','*','MarkerEdgeColor',[1 0.66 0.196],'MarkerFaceColor','w','MarkerSize',20);
%h4 = plot(x,data(:,4), 'color',[0.188 0.592 0.643],'LineStyle','-.','Marker','.','MarkerEdgeColor',[0.188 0.592 0.643],'MarkerFaceColor','w','MarkerSize',20);
%h5 = plot(x,data(:,5), 'color',[0.278 0.2 0.207],'LineStyle','-.','Marker','x','MarkerEdgeColor',[0.278 0.2 0.207],'MarkerFaceColor','w','MarkerSize',20);
%h6 = plot(x,data(:,6), 'color','k','LineWidth',2,'LineStyle','--','Marker','s','MarkerEdgeColor','m','MarkerFaceColor','w','MarkerSize',15);
%h7 = plot(x,data(:,7), 'color','k','LineWidth',2,'LineStyle','--','Marker','d','MarkerEdgeColor','m','MarkerFaceColor','w','MarkerSize',15);

xlim([0.4 5.5])
ylim([0.2 1.1])
% 
grid on;
% 
%xlabel('Sample Size (bytes)','fontname',fname,'fontsize',fsize);
ylabel(sprintf('Avg-Streaming Goodput (Gbps)','Interpreter','latex','fontname',fname,'fontsize',fsize));
% 
% 

xticks([1 2 3 4 5])
xticklabels({'LAN','Metro','Short WAN','WAN','Long WAN'})
%xticks([2 4 8 12])
%xticklabels({'2^{10}','2^{12}','2^{16}','2^{20}'})

% xData = get(h1,'XData');
%set(gca,'Xtick', [2 4 6 8 10 12])
%set(gca,'Ytick',linspace(0,3,16))
%set(gca,'Xscale','log')
%set(gca,'XTickLabel', {'0','0.1', '0.5', '1', '5','2'});
legend('Direct QUIC', 'QUIC Proxy');
set(legend,'Location','southwest','Box','off');
%set(legend,'Orientation','horizontal');
%legend boxoff;

set(gca,'fontname',fname);
set(gca,'fontsize',fsize_axis);

%set(l,'fontname',fname);
%set(l,'fontsize',40);


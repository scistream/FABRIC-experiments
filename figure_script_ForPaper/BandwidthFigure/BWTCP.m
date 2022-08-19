clear all;
close all;
clc;

%data=dlmread('A1_TransRange_Packet_new.csv');
%data=dlmread('A2_TransRange_Delay.csv');
%data=dlmread('successRatio.csv');


fsize=12;
fsize_legend = 12;
fsize_axis = 12;
fname = 'Times New Roman';

figure;
hold on;

%x=[50,100,150,200,250];
x = categorical({'LAN','Metro','Short WAN','WAN','Long WAN'});
x = reordercats(x,{'LAN','Metro','Short WAN','WAN','Long WAN'});
y1=[48.1	99.9	31.8;32	44.5	84.2;83.7	39.4	33.6;24.6	18.4	48.8;31.2	16.3	86.3] 
y2=-1*[101	22.2	77.7;95.3	21.1	101;71.3	27.4	74.8;31.2	10.6	77.3;81.1	11.3	25.3]
h1=bar(x,y1)
xtips1 = h1(1).XEndPoints;
ytips1 = h1(1).YEndPoints;
labels1 = string(h1(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = h1(2).XEndPoints;
ytips2 = h1(2).YEndPoints;
labels2 = string(h1(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips3 = h1(3).XEndPoints;
ytips3 = h1(3).YEndPoints;
labels3 = string(h1(3).YData);
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
hold on
h2=bar(x,y2)
xtips4 = h2(1).XEndPoints;
ytips4 = h2(1).YEndPoints;
labels4 = string(h2(1).YData*-1);
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','top')
xtips5 = h2(2).XEndPoints;
ytips5 = h2(2).YEndPoints;
labels5 = string(h2(2).YData*-1);
text(xtips5,ytips5,labels5,'HorizontalAlignment','center',...
    'VerticalAlignment','top')
xtips6 = h2(3).XEndPoints;
ytips6 = h2(3).YEndPoints;
labels6 = string(h2(3).YData*-1);
text(xtips6,ytips6,labels6,'HorizontalAlignment','center',...
    'VerticalAlignment','top')
%h1 = plot(x,data(:,1), 'color',[0.49 0.18 0.56],'LineStyle','-','Marker','+','MarkerEdgeColor',[0.49 0.18 0.56],'MarkerFaceColor','w','MarkerSize',20);
%h2 = plot(x,data(:,2), 'color',[0.94 0.39 0.28],'LineStyle','--','Marker','o','MarkerEdgeColor',[0.94 0.39 0.28],'MarkerFaceColor','w','MarkerSize',20);
%h3 = plot(x,data(:,3), 'color',[1 0.66 0.196],'LineStyle',':','Marker','*','MarkerEdgeColor',[1 0.66 0.196],'MarkerFaceColor','w','MarkerSize',20);
%h4 = plot(x,data(:,4), 'color',[0.188 0.592 0.643],'LineStyle','-.','Marker','.','MarkerEdgeColor',[0.188 0.592 0.643],'MarkerFaceColor','w','MarkerSize',20);
%h5 = plot(x,data(:,5), 'color',[0.278 0.2 0.207],'LineStyle','-.','Marker','x','MarkerEdgeColor',[0.278 0.2 0.207],'MarkerFaceColor','w','MarkerSize',20);
%h6 = plot(x,data(:,6), 'color','k','LineWidth',2,'LineStyle','--','Marker','s','MarkerEdgeColor','m','MarkerFaceColor','w','MarkerSize',15);
%h7 = plot(x,data(:,7), 'color','k','LineWidth',2,'LineStyle','--','Marker','d','MarkerEdgeColor','m','MarkerFaceColor','w','MarkerSize',15);

%xlim([10 300])
ylim([-115 115])
% 
grid on;
% 
%xlabel('Transmission Range (m)','fontname',fname,'fontsize',fsize);
ylabel(sprintf('TCP Bandwidth (Gbps)','Interpreter','latex','fontname',fname,'fontsize',fsize));
% 
% 
yticks([-100 -50 -20 0 20 80 100])
yticklabels({'100','50','20','0','20','80','100'})


% xData = get(h1,'XData');
%set(gca,'Xtick', [50 100 150 200 250])
%set(gca,'Ytick',linspace(0.2,0.9,8))
%set(gca,'Xscale','log')
%set(gca,'XTickLabel', {'0','0.1', '0.5', '1', '5'});
legend('h1-h2', 'h2-h4', 'h4-h5', 'h2-h1','h4-h2','h5-h4');
%set(legend,'Location','southwest','Box','off');
set(legend,'NumColumns',2);
legend boxoff;

set(gca,'fontname',fname);
set(gca,'fontsize',fsize_axis);

%set(l,'fontname',fname);
%set(l,'fontsize',40);
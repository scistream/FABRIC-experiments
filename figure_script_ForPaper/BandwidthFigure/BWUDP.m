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
y1=[31.9	25.4	25.7;32.4	24.7	23.1;22.8	22.4	26.1;23.7	22.8	24.7;31.1	24.4	22.7] 
y2=-1*[25.2	24.7	20.9;24.6	24	22.9;21.7	23.4	23;16.9	25.7	22.9;23.7	22.9	24.5;]
h1=bar(x,y1)
xtips1 = h1(1).XEndPoints;
ytips1 = h1(1).YEndPoints;
labels1 = string(round(h1(1).YData));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips2 = h1(2).XEndPoints;
ytips2 = h1(2).YEndPoints;
labels2 = string(round(h1(2).YData));
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
xtips3 = h1(3).XEndPoints;
ytips3 = h1(3).YEndPoints;
labels3 = string(round(h1(3).YData));
text(xtips3,ytips3,labels3,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
hold on
h2=bar(x,y2)
xtips4 = h2(1).XEndPoints;
ytips4 = h2(1).YEndPoints;
labels4 = string(round(h2(1).YData*-1));
text(xtips4,ytips4,labels4,'HorizontalAlignment','center',...
    'VerticalAlignment','top')
xtips5 = h2(2).XEndPoints;
ytips5 = h2(2).YEndPoints;
labels5 = string(round(h2(2).YData*-1));
text(xtips5,ytips5,labels5,'HorizontalAlignment','center',...
    'VerticalAlignment','top')
xtips6 = h2(3).XEndPoints;
ytips6 = h2(3).YEndPoints;
labels6 = string(round(h2(3).YData*-1));
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
ylim([-33 37])
% 
grid on;
% 
%xlabel('Transmission Range (m)','fontname',fname,'fontsize',fsize);
ylabel(sprintf('UDP Bandwidth (Gbps)','Interpreter','latex','fontname',fname,'fontsize',fsize));
% 
% 
yticks([-30 -20 -10 0 10 20 30])
yticklabels({'30','20','10','0','10','20','30'})


% xData = get(h1,'XData');
%set(gca,'Xtick', [50 100 150 200 250])
%set(gca,'Ytick',linspace(0.2,0.9,8))
%set(gca,'Xscale','log')
%set(gca,'XTickLabel', {'0','0.1', '0.5', '1', '5'});
legend('h1-h2', 'h2-h4', 'h4-h5', 'h2-h1','h4-h2','h5-h4');
%set(legend,'Location','southwest','Box','off');
set(legend,'NumColumns',3);
legend boxoff;

set(gca,'fontname',fname);
set(gca,'fontsize',fsize_axis);

%set(l,'fontname',fname);
%set(l,'fontsize',40);
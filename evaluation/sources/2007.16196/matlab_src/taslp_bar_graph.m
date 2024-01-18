clc
clear all
close all
baseline = [ 8.21 40.12 16.29 10.85 9.66 23.05 43.78 19.50 8.28 35.84];
proto = [ 7.20 33.63 15.04 12.53 9.20 14.22 41.00 16.99 8.02 36.39];
relation = [7.72 36.59 17.58 13.45 9.13 15.48 41.89 15.69 7.69 38.35];
proto_ch = 100*(baseline - proto)./baseline;
rel_ch = 100*(baseline - relation)./baseline;


b = bar([baseline' proto' relation']);
set(gca,'xtick',1:10)

proto_xt = [1:10];
proto_yt=proto+1;
for i = 1:10
  text(proto_xt(i), proto_yt(i), num2str(proto_ch(i),'%.2f'),'rotation',60,'fontsize',8);
end

rel_xt = [1:10]+0.25;
rel_yt = relation+1;
for i = 1:10
  text(rel_xt(i), rel_yt(i), num2str(rel_ch(i),'%.2f'),'rotation',60,'fontsize',8);
end
% Modify the XTickLabels, stretch the plot as necessary..
% Select only the inner plot
set(gca,'TickLength',[0 0]);
ax = gca;
exportgraphics(ax,'Desktop/taslp_bar.png','Resolution',500) 
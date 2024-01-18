clear; close;
proto_dihard_oracle = fliplr([15.44,15.81,15.99,16.90,17.78;NaN,15.71,16.51,16.16,18.23;NaN,NaN,15.78,16.18,19.19;NaN,NaN,NaN,17.03,18.14;NaN,NaN,NaN,NaN,19.74]);
proto_ami_oracle = fliplr([6.670,6.730,6.200,6.420,7.530;NaN,5.600,5.680,6.970,11.03;NaN,NaN,6.430,6.720,10.84;NaN,NaN,NaN,7.130,11.71;NaN,NaN,NaN,NaN,11.87]);
proto_ados_oracle = fliplr([12.81,13.62,12.69,13.92,16.69;NaN,12.15,13.21,17.20,25.26;NaN,NaN,12.91,13.02,28.18;NaN,NaN,NaN,14.82,22.50;NaN,NaN,NaN,NaN,16.38]);

rel_dihard_oracle = fliplr([16.17,16.44,17.07,17.27,18.64;NaN,16.54,16.89,17.40,18.71;NaN,NaN,17.44,17.63,18.56;NaN,NaN,NaN,18.63,18.24;NaN,NaN,NaN,NaN,19.03]);
rel_ami_oracle = fliplr([6.380,6.970,7.210,7.520,12.13;NaN,7.100,7.190,8.610,8.550;NaN,NaN,8.310,8.370,9.310;NaN,NaN,NaN,9.930,11.34;NaN,NaN,NaN,NaN,9.660]);
rel_ados_oracle = fliplr([12.34,13.51,16.05,14.06,27.58;NaN,13.66,13.87,14.15,14.77;NaN,NaN,14.34,14.22,14.40;NaN,NaN,NaN,14.60,29.96;NaN,NaN,NaN,NaN,15.27]);

subplot(2,3,1),heatmap(proto_dihard_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')
subplot(2,3,2),heatmap(proto_ami_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')
subplot(2,3,3),heatmap(proto_ados_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')

subplot(2,3,4),heatmap(rel_dihard_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')
subplot(2,3,5),heatmap(rel_ami_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')
subplot(2,3,6),heatmap(rel_ados_oracle, 'MissingDataColor', 'w', 'GridVisible', 'off', 'MissingDataLabel', " ",'ColorbarVisible','off')


for subplotI = 1:6    
    ax = subplot(2,3,subplotI);   
    ax.XData = [25, 50, 100, 200, 400];
    ax.YData = [2, 5, 10, 20, 50];
    axp = struct(ax);       %you will get a warning   
    axp.Axes.XAxisLocation = 'top';        

        
end
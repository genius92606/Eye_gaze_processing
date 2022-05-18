function [timeSeries,X,Y]=Input(filename)


% clc 
% close all 
% clear all 

% filename='Eye_gaze\pc1-Kevin-eyegaze-trial2.txt';

ff=readtable(filename);

ff.Properties.VariableNames([1 3 4]) = {'time' 'X' 'Y'};
ff(ismissing(ff.X),:) = [];

for i=2:size(ff.time,1)
    if ff.X(i)==0
       if ff.X(i-1)~=0 && ff.X(i+1)~=0 
           if (ff.UTC(i+1)-ff.UTC(i-1))<30
               ff.time(i)=0;
           end           
       end
    end
end
ff(ff.time==0,:) = [];
% 
X=ff.X;Y=ff.Y;
X(X==0)=NaN;
Y(Y==0)=NaN;
timeSeries=1:size(X);
end
% finalZ=zeros(size(X,1),1);
% zscor_nan = @(x) bsxfun(@rdivide, bsxfun(@minus, x, mean(x,'omitnan')), std(x, 'omitnan'));
% 
% for i=1:size(X,1)
%     type=1;
%     start=i-1000;
%     over=i+1000;
%     if start<1
%         start=1;
%     end
%     if over>size(X,1)
%         over=size(X,1);
%     end
%     zzz=zscor_nan(X(start:over)).^2+zscor_nan(Y(start:over)).^2;
%     finalZ(i)=zzz(i-start+1);
% end
% 
% % Zscore = zscor_nan(X).^2+zscor_nan(Y).^2;
% % plot(Zscore);
% % start=255;
% % over=303;
% % plot(X(start:over),Y(start:over));
% % plot(Zscore(start:over));
% % plot(Zscore);
% % end
% 
% outliers=finalZ>10;
% for i=1:size(X,1)
%     if outliers(i)==1
%         X(i)=nan;
%         Y(i)=nan;
%     end
% end
% 
% for i=2:size(X,1)-1
%     if isnan(X(i+1)) && isnan(X(i-1))
%         X(i)=nan;
%         Y(i)=nan;
%     end     
% end
% 
% gaps  = cell2table(cell(0,2), 'VariableNames', {'Start', 'End'});
% start=1;over=1;i=1;
% while i<size(X,1)
%     if isnan(X(i))
%         start=i;
%         while isnan(X(i))&&i<size(X,1)
%             i=i+1;
%         end
%         over=i-1;
%         temp= table(start,over, 'VariableNames', {'Start', 'End'});
%         gaps=[gaps;temp];
%     else
%         i=i+1;
%     end
% end
% 
% 
% %%fill the gaps
% for i=1:size(gaps,1)
%    if gaps.End(i)+3<=size(X,1)
%        value1=[X(gaps.Start(i)-3),X(gaps.Start(i)-2),X(gaps.Start(i)-1)]; 
%        value2=[X(gaps.End(i)+1),X(gaps.End(i)+2),X(gaps.End(i)+3)];
%        time1=[gaps.Start(i)-3,gaps.Start(i)-2,gaps.Start(i)-1];
%        time2=[gaps.End(i)+1,gaps.End(i)+2,gaps.End(i)+3];
%        value=Cubic_spline(time1,time2,value1,value2);
%        X(gaps.Start(i):gaps.End(i))=value;
%    
%        value1=[Y(gaps.Start(i)-3),Y(gaps.Start(i)-2),Y(gaps.Start(i)-1)]; 
%        value2=[Y(gaps.End(i)+1),Y(gaps.End(i)+2),Y(gaps.End(i)+3)];
%        time1=[gaps.Start(i)-3,gaps.Start(i)-2,gaps.Start(i)-1];
%        time2=[gaps.End(i)+1,gaps.End(i)+2,gaps.End(i)+3];
%        value=Cubic_spline(time1,time2,value1,value2);
%        Y(gaps.Start(i):gaps.End(i))=value;
%    end
%    
% end


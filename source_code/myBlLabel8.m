function [output] = myBlLabel8(input)

% size of input image
[row, col]=size(input);

% process output size
output = zeros(row,col);

% default
background = 1; labelnum = 0; labellevel = 0;
A=0; B=0; C=0; D=0; 
 
for j=1:row % image in matlab is 세로 * 가로
    for i=1:col 
        if input(i,j) ~= 0 
            
            % define section
            if i==1 % first row
                if j ~= 1 % not a first column
                    A = background; B = background; C = background;
                    D = output(i,j-1);       
                else % first column
                    A=background; B=background; C=background; D=background;
                end
            elseif j==1 % first column on the every line
                if i ~= 1 % and not a first row
                    A = background; D = background;
                    B = output(i-1,j); C = output(i-1,j+1);
                end
            elseif j==col % last column line on the every line
                C = background;
                A = output(i-1,j-1); B = output(i-1,j); D = output(i,j-1);
         
            else
                A = output(i-1,j-1); B = output(i-1,j);
                C = output(i-1,j+1); D = output(i,j-1);
            end
            
            % Blob labeling          
            if (A ~= 0) || (B ~= 0) || (C ~= 0) || (D ~= 0)
                Index = [A B C D];
                output(i,j) = max(Index);
            else     
                labellevel = labellevel+1; % set labeling level %lab 1=1, lab2=0.25
                labelnum = round(labellevel);
                output(i,j) = labelnum+1;
                
            end
            
           % if (i>2) && (j>2) %inspection
           % if (output(i,j)>output(i,j-1)) && (output(i,j-1)~=0)
           %     output(i,j)=output(i,j-1);   
           % end
           % end     
           
        else
            output(i,j) = 0;
        end
        
    end % end column for loop
end % end row for loop
end % function end
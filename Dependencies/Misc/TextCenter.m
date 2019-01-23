% show some text with the dXtext class
% also a good way to find text that looks good on a particular screen

function [fs, x, y] = TextCenter(str, fs, font)

global scaling

ppd = rGet('dXscreen', 1, 'pixelsPerDegree');




% set new fontsize
fs = fs; %round(fs*scaling);

% set length of string to calculate center
s = length(str);

% check font
if strcmp(font,'Courier')
    
    % guess a conversion from font size to pixels
    xFontPerPix = .60; % Courier
    yFontPerPix = .8;  % Courier
elseif strcmp(font,'WingDings')
    
    xFontPerPix = 1; % WingDings
    yFontPerPix = 1;  % WingDings
    
elseif strcmp(font,'wingdings')       % ???
    if s==1
        xFontPerPix = .6;
    else
        xFontPerPix = .5;
        
    end
    yFontPerPix = 1.4;  % wingdings
    
elseif strcmp(font,'Arial')
    xFontPerPix = .65; % Arial
    yFontPerPix = 1.1;  % Arial
    
elseif strcmp(font,'Tohoma')
    xFontPerPix = .65; % Tohoma
    yFontPerPix = 1.35;  % Tohoma
    
elseif strcmp(font,'Helvetica')
    xFontPerPix = .65; % Helvetica
    yFontPerPix = 1;  % Helvetica
    
else
    % just do a default ...
    xFontPerPix = .65; % Tohoma
    yFontPerPix = 1.35;
    
end

% convert size in font units to pixels
xPix = fs*xFontPerPix*s;
yPix = fs*yFontPerPix;

% shift the dXtext by half its size in degrees
x = -.5*xPix/ppd;
y = .5*yPix/ppd;


function temporefinamento

clear all
clc
clf
 t=10;
 dt = 30:20:70;

m = length(dt);
 
  for i = 1:m
 
 
     PRINCIPALSEMIBIFASICO4(dt(i));
   

  end
end

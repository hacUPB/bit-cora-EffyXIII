//RAM200 =250
@250
D=A
@200
M=D

//RAM2 =RAM0 + RAM1 + 17

@0 
D=M  
@1 
D=D+M 
@17 
D=D+A  
@2     
M=D 
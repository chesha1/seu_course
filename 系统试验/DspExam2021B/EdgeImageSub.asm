;_EdgeImageSub(ImageWidth,ImageHeight,buffer_org,buffer_grey,Threshhold);
;入口参数：
;T0=ImageWidth,T1=ImageHeight,AR2=Threshhold
;AR0=buffer_org,AR1=buffer_grey


         .mmregs
         .def  _EdgeImageSub
         .bss  TEMP,1
         .text

_EdgeImageSub:
          bclr C54CM
          bclr AR0LC
          bclr AR1LC
          bclr ARMS

         SUB	#3,T0,T2
         MOV T2,BRC1
         SUB	#3,T1,T3
		MOV T3,BRC0
;将长宽分别赋值给循环计数器，构造循环嵌套
		MOV #0,AC0
		MOV #0,AC1
;AC0和AC1表示两个差值，初始化为0
		MOV XAR0,XAR3
		ADD #1,AR3
		MOV XAR0,XAR4
		ADD T0,AR4
		MOV XAR0,XAR5
		ADD #1,AR5
		ADD T0,AR5
		MOV XAR0,XAR6
		SUB T0,AR6
		MOV XAR0,XAR7
		SUB #1,AR7
;XAR3存放右边像素点，XAR4存放下面像素点，XAR5存放右下像素点，XAR6存放上面像素点，XAR7存放左面像素点
		RPTB Y_LOOP
		RPTB X_LOOP

		MOV *AR4,AC0
		SUB *AR6,AC0
		ADD *AR3,AC0
		SUB *AR7,AC0
		ADD AC0,AC0
		ADD	*AR4(#-1),AC0
		SUB *AR6(#1),AC0


		ABS AC0

		MOV *AR7,AC1
		ADD *AR4,AC1
		SUB *AR6,AC1
		SUB *AR3,AC1
		ADD AC1,AC1
		ADD *AR5,AC1
		SUB *AR6(#-1),AC1


		ABS AC1
		ADD AC0,AC1
;计算，并存放在AC1中
		MOV #0,*AR1
		CMP AC1<AR2,TC1
		BCC BRANCH,TC1
		MOV #255,*AR1
;进行判断，先将AR1像素点设置成黑色，如果超过阈值就设置成白色，如果没有就跳过
BRANCH: ADD #1,AR0
		ADD #1,AR1
		ADD #1,AR3
		ADD #1,AR4
		ADD #1,AR5
		ADD #1,AR6
		ADD #1,AR7
;所有像素+1，转移到下一个点
X_LOOP: NOP
		ADD #2,AR0			;移动到下一行的第2个元素，所以要再加2
		ADD #2,AR1
		ADD #2,AR3			;移动到下一行的第2个元素，所以要再加2
		ADD #2,AR4			;移动到下一行的第2个元素，所以要再加2
		ADD	#2,AR5			;移动到下一行的第2个元素，所以要再加2
		ADD #2,AR6
		ADD #2,AR7


Y_LOOP: NOP








         RET




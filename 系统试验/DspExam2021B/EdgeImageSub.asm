;_EdgeImageSub(ImageWidth,ImageHeight,buffer_org,buffer_grey,Threshhold);
;��ڲ�����
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
;������ֱ�ֵ��ѭ��������������ѭ��Ƕ��
		MOV #0,AC0
		MOV #0,AC1
;AC0��AC1��ʾ������ֵ����ʼ��Ϊ0
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
;XAR3����ұ����ص㣬XAR4����������ص㣬XAR5����������ص㣬XAR6����������ص㣬XAR7����������ص�
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
;���㣬�������AC1��
		MOV #0,*AR1
		CMP AC1<AR2,TC1
		BCC BRANCH,TC1
		MOV #255,*AR1
;�����жϣ��Ƚ�AR1���ص����óɺ�ɫ�����������ֵ�����óɰ�ɫ�����û�о�����
BRANCH: ADD #1,AR0
		ADD #1,AR1
		ADD #1,AR3
		ADD #1,AR4
		ADD #1,AR5
		ADD #1,AR6
		ADD #1,AR7
;��������+1��ת�Ƶ���һ����
X_LOOP: NOP
		ADD #2,AR0			;�ƶ�����һ�еĵ�2��Ԫ�أ�����Ҫ�ټ�2
		ADD #2,AR1
		ADD #2,AR3			;�ƶ�����һ�еĵ�2��Ԫ�أ�����Ҫ�ټ�2
		ADD #2,AR4			;�ƶ�����һ�еĵ�2��Ԫ�أ�����Ҫ�ټ�2
		ADD	#2,AR5			;�ƶ�����һ�еĵ�2��Ԫ�أ�����Ҫ�ټ�2
		ADD #2,AR6
		ADD #2,AR7


Y_LOOP: NOP








         RET




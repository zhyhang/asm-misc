# ide
##	使用sasm
- 编辑性不太好，但可以即席debug（依赖gdb）
- nasm为2.15+时（sasm为3.12.1），需在编译中增加-gstabs。
	
##	使用vscode
- **编辑功能强大**

 1. 安装语法高亮插件，推荐（ASM Code Lens），或nasm相关插件【它们只有高亮功能，无debug功能】
 2. 安装debug插件，推荐（Native Debug），或（GDB debug），【它们都依赖安装gdb】。
 3. 但在vscode中无法在屏幕中设置断点，也无register窗口（当前：2022.02）
 4. 在vscode中要想调试：
	1. 在breakpoint窗口（或Run菜单）中设置function断点，如：入口断点为_start
	2. 其它函数断点，名称为：_start+asm源代码中的label名称，如：_start.input_chr【注意.input_chr为label名称】  
	【也可通过gdb的info functions来查看function名称，nasm2.15+默认使用-gdwarf作为debug info format，使用info functions看不到本地名称】  
	【但vscode中的插件，只能用dwarf才能函数断点，所以不能改dwarf】  
	**【可以使用nm bin_file来查看符号表】**
	【function断点不能取消，界面中怎么操作都不能取消，可以在gdb中通过info break + disable n/delete n命令来失效或取消】
	3. register的内容，可以在gdb command line中p $reg来打印或在watch窗口使用，$reg来显示。
	4. 显示console和gdb command line：View->Show Debug Console
	5. 【在launch.json中配置"terminal": ""可以保证输出入输出正常，每次运行程序都会开一个terminal，ctrl+c可以结束】
	6. 如果GDB支持step into，要保证被调用库的asm源文件在相应的目录，且要用-gdwarf来编译库（同时vscode界面中的step into也会打开库源文件来debug。
 5. 注意按config下的配置.vscode文件tasks.json和launch.json。tasks中是编译连接任务。launch是执行调用gdb启动debug。
 6. 【打开要debug的asm文件为焦点，点击vscode左侧的run/debug按钮。】
		7.使用edb（或gdb）来调试：gdb的debug不好用在vscode中，可以只是执行一下，为了是执行tasks中的编译连接。然后使用下面介绍的edb来debug。

# gdb
	
	参考目录gdb的几个指导文件
	参见《gdb and assembly.pdf》
1. gdb 要执行的文件
2. layout asm ;显示汇编指令
3. info functions ;查看函数（符号表），或使用shell命令，nm bin_file来查看
4. b(reak) *fun_name+offset addr 或者 b fun_name 或者 b addr ;设置断点
4. info break 查看断点;disable n/delete n屏蔽或删除断点
5. r(run) ;运行
6. ni [n] ;step over, n步
7. print $reg
	
# edb
- 主要用于linux，也可以用于win10/macOs【是试验版】
- 支持arm/x86/x64
- url: https://github.com/eteran/edb-debugger
- 用官网的指导可以完成安装
	- https://github.com/eteran/edb-debugger/wiki/Compiling-(Ubuntu)
	
	- 程序中需要输入输出的console的，有两种方法：
		1. sudo apt install xterm  
		【或者修改为其它termial，如：/usr/bin/gnome-terminal】  
		【但由于edb的bug，重启失效，可以直接修改配置文件：home/.config/codef00.com/edb.conf】
		2. 从shell上运行edb

# x64dbg

- win10-x64调试器
- 用于逆向工程和分析
- 官网
	- https://github.com/x64dbg/x64dbg
- [TODO] 试用


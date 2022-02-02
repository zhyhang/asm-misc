-------------
INTRO
-------------
BASELIBS is a feature-rich general-purpose set of libraries intended for beginners / hobbyists wishing to learn x86 / x64 Assembly Language programming. It covers both Linux and Windows platforms and both 32-bit and 64-bit CPU programming. 

These libraries are released for the benefit of beginners, self-learners, hobbyists or those who want to refresh their assembly programming skills. They are essentially intended for those wishing to interface or program the CPUs, with strong emphasis on CPU instructions and machine programming. It is designed for console / command-line environment only. 

It offers thin layer routines that are needed by beginners to start learning assembly programming comfortably as they have been designed to reduce the steep learning curve.


-----------------
What to use
-----------------
BASELIBS come in two flavors: (1) CPU2.0 (cpu2.0.zip) and (2) BASE2.0 (baselibs.zip). They are similar in functionalities but observe different calling conventions. Both come with sources and binaries and in 32-bit and 64-bit variants. All the API references and simple documentations are included.

[1] CPU2.0 observes ABI compliancy for both Linux and Win64 platforms and can be called from high-level languages due to such compliancy. The 32-bit versions observe CDECL or C calling convention.

[2] BASE2.0 observes its own calling convention to allow the same material to be useable on both Linux and Win platforms. The 32-bit versions observe STDCALL or standard call calling convention.

The two libraries, while differ in calling conventions, have the same purpose of helping one to learn x86/x86_64 assembly language in a more productive and effective ways. This is in addition to the fact that the CPU in its purest sense, knows no calling conventions. Therefore to interface the CPU for the purpose of learning, either library is just as useable.

Note that CPU2.0 and BASE2.0 are not compatible with each other.

Sources come in with FASM, NASM and MASM flavors. Binaries can be accessed as .SO, .o, .obj and .dll

-------------------
LICENSE
-------------------
;----------------------------------------------------------------------------
;    Copyright(c) 2015-2020. Soffian Abdul Rasad, Sarah Safarina Rahmat     ;
;----------------------------------------------------------------------------
;                                                                           ;
;    BASELIBS is free software: you can redistribute it and/or modify       ;
;    it under the terms of the GNU General Public License as published by   ;
;    the Free Software Foundation, either version 3 of the License, or      ;
;    (at your option) any later version.                                    ;
;                                                                           ;
;    BASELIBS is distributed in the hope that it will be useful,            ;
;    but WITHOUT ANY WARRANTY; without even the implied warranty of         ;
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          ;
;    GNU General Public License for more details.                           ;
;                                                                           ;
;    You should have received a copy of the GNU General Public License      ;
;    along with BASELIBS. If not, see <https://www.gnu.org/licenses/>.      ;
;----------------------------------------------------------------------------


-------------------
Updates
-------------------
As these libraries are developed voluntarily, we make no guarantee of future updates or maintenance. We however will try to maintain them periodically and most of the updates will be conducted silently from time to time.


-------------------
Contact
-------------------
If you are having difficulties using these libraries, found some bugs or anything at all, you can contact us via one of the following;

1. Twitter: @SoffianAbdRasad
2. E-mail: soffianabdulrasad @ gmail . com (no spaces)


Last updated: August 14, 2020
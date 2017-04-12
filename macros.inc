WaitNVBL: MACRO
.waitnvbl\@
  ldh A, [$41]
  and 3
  cp 1
  jr z, .waitnvbl\@
ENDM

WaitVBL: MACRO
.waitvbl\@
  ldh A, [$41]
  and 3
  cp 1
  jr nz, .waitvbl\@
 ENDM

WaitVBlankStart: MACRO
  WaitNVBL
  WaitVBL
ENDM

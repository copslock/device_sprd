2019/12/25 14:59:58

How to enable:
	1: Enable by MACRO in file BoardConfig.mk
	   TARGET_BOARD_LOGOWATERMARK_SUPPORT := true
	   TARGET_BOARD_TIMEWATERMARK_SUPPORT := true
	2: prepare watermark files(logo--*.rgba,time--time.yuv), and set makefile
	   #watermark, copy files to /vendor/logo/
	   PRODUCT_COPY_FILES += \
	   $(BOARDDIR)/features/watermark/logo_1200x240.rgba:/vendor/logo/logo_1200x240.rgba \
	   $(BOARDDIR)/features/watermark/logo_1000x200.rgba:/vendor/logo/logo_1000x200.rgba \
	   $(BOARDDIR)/features/watermark/logo_800x160.rgba:/vendor/logo/logo_800x160.rgba \
	   $(BOARDDIR)/features/watermark/time.yuv:/vendor/logo/time.yuv
	3: change folder mode in *.rc file, or open files should be fail
	   chmod 755 /vendor/logo

more detal:
logo watermark:
    * add logo to the picture when capture.
    * logo source files should be *.rgba, you can try to convert *.png to *.rgba
      https://convertio.co/zh/rgba-converter/
    * you can prepare logo source files for each size of capture.
    * logo source files' width and height should at least align to 2
    * If you want to change name and size, please modify these code in file cmr_oem.c
      function:camera_select_logo,camera_get_logo_data, and PRODUCT_COPY_FILES in makefile

time watermark:
    * add timestamp to the picture when capture
    * the source file should named time.yuv, contain image of char "0123456789-: "(last one is space) in the file.
      you can create time.png by pc-software as GIMP, contain the elements for timestamp.
    * Every elements should have the same width and height, and should at least align to 2
    * If you want to change, please modify these cod cmr_oem.c,function:camera_get_time_yuv420

debug libcamera:
1: can debug watermark of libcamera code by set property
   1) push source files to phone
      adb root;adb remount;adb shell
      #make folder for source files
      cd /vendor/
      mkdir logo
      chown system:system logo
      exit
      #push source files to phone
      adb push *.rgba /vendor/logo/
      adb push time.yuv /vendor/logo/
   2) set property,0:none;1:debug logo watermark;2: debug time watermark;3:both
      setprop debug.vendor.cam.watermark.test 1

sample:
cmr_oem.c
logo watermark:info:
cmr_int camera_select_logo(sizeParam_t *size) {
    cmr_int ret = -1;
    cmr_uint i;
    const sizeParam_t cap_logo[] = {
        /* capture width,height;logo:width,height;logo position in capture:posx,posy */
        {4000, 3000, 1200, 240, 0, 0, 0, 0},
        {4000, 2250, 1200, 240, 0, 0, 0, 0},
        {2592, 1944, 1000, 200, 0, 0, 0, 0},
        {2592, 1458, 1000, 200, 0, 0, 0, 0},
        {2048, 1536, 800, 160, 0, 0, 0, 0},
        {2048, 1152, 800, 160, 0, 0, 0, 0},
    };

time watermark:info,
cmr_int camera_get_time_yuv420(cmr_u8 **data, int *width, int *height) {
    cmr_s32 rtn = -1;
    char tmp_name[128];
    /* info of source file for number */
    const char file_name[] = "time.yuv"; /* source file for number:0123456789-:  */
    const int subnum_total = 13;  /* 0--9,-,:, (space), all= 13 */
    const int subnum_width = 80;  /* sub number width:align 2 */
    const int subnum_height = 40; /* sub number height:align 2 */

gerrit id:(10.0)
libcamera:614652,631599,647306
device:614655
other:623364,623335,622153


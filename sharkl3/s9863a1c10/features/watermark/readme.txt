9:51 2019/10/15
logo watermark:
    * add logo to the picture when capture.
    * logo source file should be *.rgba, you can try to convert *.png to *.rgba
    * you can prepare logo source file for every size of capture.
    * logo source width,height should align to 2
    * If you want to change name and size, please modify these code cmr_oem.c
      function:camera_select_logo,camera_get_logo_data

time watermark:
    * add timestamp to the picture when capture
    * logo source file should be time.yuv, include "0123456789-: "(last one is space) in the yuv file.
      you can create time.png by pc-software as GIMP, include the elements for timestamp.
    * Every elements should have the same width and height, and should align to 2
    * If you want to change, please modify these cod cmr_oem.c,function:camera_get_time_yuv420

1: libcamera下code可单独测试,
   1) adb root;adb remount;adb shell
      cd /vendor/
      mkdir logo
      chown system:system logo
      然后将相应的文件push到该logo目录下
   2) 若未修改code,请按watermark目录下的文件名,及大小
      准备rgba文件,可以用如下网站将png文件转成rgba
      https://convertio.co/zh/rgba-converter/
   3) adb root;adb remount;adb shell
      setprop debug.vendor.cam.watermark.test 1
   4) 切换拍照size(与下面code显示size对应),点拍照
      正常的话就可以看到照片上有水印.
   5) 退出单独测试,请setprop debug.vendor.cam.watermark.test 0

//logo图片(*.rgba)
	代码中有使用跟size相关的文件名字, 若需要修改,请在函数camera_select_logo,
	camera_get_logo_data, device下mk中同步修改
	建议:
	    源图最好是png, 因为png带透明信息. jpeg,bmp等不带透明信息.
            若修改size, 请尽量兼顾宽高至少2对齐(这样uv数据才能对齐,叠加时更准).
            若不修改size, logo四周边缘最好留空白.

//时间戳图片(yuv)
	图片内容包时间戳需要的要素, 必须是竖幅, 等宽字符,宽高最好至少2对齐.
	图片获取主要在函数camera_get_time_yuv420,有些信息需要与图像对应:文件名, 字符数(13个),字符宽高.
	13个字符顺序(0123456789-: )最后一个为空格.
        生成: 可使用图片处理软件(ps),先生成png, 再转成yuv.可以先生成横幅,如(312(=24*13)*48,设计好后, 再整幅图顺时针转90度,再导出成png.
	宽高2对齐,uv数据才能对齐, 否则,uv数据可能对不齐,引起最终效果上颜色有偏差.

cmr_oem.c
logo watermark:info:
cmr_int camera_select_logo(sizeParam_t *size) {
    cmr_int ret = -1;
    cmr_uint i;
    const sizeParam_t cap_logo[] = {
        /* cap: width,height;logo:width,height;cap:posx,posy */
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

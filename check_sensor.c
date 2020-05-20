#include <png.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char **argv){
  if (argc != 2){
    fprintf(stderr, "invalid number of argument\n");
  }

  char header[8];

  FILE *fp = fopen(argv[1], "rb");
  fread(header, 1, 8, fp);
  if (png_sig_cmp(header, 0, 8)) fprintf(stderr,"header invalid\n");

  png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

  png_infop info_ptr = png_create_info_struct(png_ptr);

  png_init_io(png_ptr, fp);
  png_set_sig_bytes(png_ptr, 8);

  png_read_info(png_ptr, info_ptr);

  int width = png_get_image_width(png_ptr, info_ptr);
  int height = png_get_image_height(png_ptr, info_ptr);
  int color_type = png_get_color_type(png_ptr, info_ptr);
  int bit_depth = png_get_bit_depth(png_ptr, info_ptr);

  //printf("%i %i %i %i\n", color_type,bit_depth,PNG_COLOR_TYPE_GRAY,PNG_COLOR_TYPE_RGB);

  png_read_update_info(png_ptr, info_ptr);

  png_bytep* row_pointers = (png_bytep*) malloc(sizeof(png_bytep) * height);
  for (int y=0; y<height; y++)
          row_pointers[y] = (png_byte*) malloc(png_get_rowbytes(png_ptr,info_ptr));

  png_read_image(png_ptr, row_pointers);

  double mr=0,mg=0,mb=0;

  for (int y=height/4; y<height/4*3; y++) {
    png_byte* row = row_pointers[y];
    //for (int x=0; x<width; x++) {
      //png_byte* ptr = &(row[x*4]);
      png_byte* ptr = &(row[8]);
      mr+=(ptr[0]<<8)|(ptr[1]&0xFF);
      mg+=ptr[1];
      mb+=ptr[2];
    //  printf("Pixel at position [ %d - %d ] has RGB values: %d - %d - %d\n",
    //  x, y, ptr[0], ptr[1], ptr[2]);
    //}
  }
  printf("%f\n",mr/(height/2));

  fclose(fp);

  return 0;
}

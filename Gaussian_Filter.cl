#define ROWS 576
#define COLS 720
#define CHANNELS 3


__kernel
__attribute__((task))
void Gaussian(__global uchar* restrict in_img, __global uchar* restrict out_img, 
		const unsigned int iterations)
{
    unsigned int count = 0;

    // Filter coefficients
	 float pdKernel[5][5] = {{0.0050f,0.0173f,0.0262f,0.0173f,0.0050f},
							{0.0173f,0.0598f,0.0903f,0.0598f,0.0173f},
							{0.0262f,0.0903f,0.1366f,0.0903f,0.0262f},
							{0.0173f,0.0598f,0.0903f,0.0598f,0.0173f},
							{0.0050f,0.0173f,0.0262f,0.0173f,0.0050f}};

    while(count != iterations)
    {	
		float dir = 0;
	
		#pragma unroll
		for (int i = 0; i < 5; ++i)
		{
			#pragma unroll
			for (int j = 0; j < 5; ++j)
			{
				uchar pixel = in_img[i * COLS + j + count];
				dir += pixel * pdKernel[i][j];
			}
		}
		out_img[count++] = (uchar) dir;
	}

}




#include <iostream>
#include "kitti_reader.h"

int main(int argc, const char* argv[])
{

    KittiReaderParams kp;
    kp.img_source_left = { 
        "h:/datasets/kitti/sequences/00/image_0/%06d.png",
        "h:/datasets/kitti/sequences/00/image_1/%06d.png" };
    KittiReader kr(kp);

    std::vector<cv::Mat> imgs;
    bool should_exit = false;
    while (!should_exit && kr.read(imgs))
    {
        cv::imshow("imgs 0", imgs[0]);
        cv::imshow("imgs 1", imgs[1]);
        int k = cv::waitKey(1);
        if (k == 27)
        {
            should_exit = true;
        }
    }


    return 0;
}
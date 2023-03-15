#pragma once
#include <opencv2/opencv.hpp>

struct KittiReaderParams
{
    std::vector<std::string> img_source_left;
};

class KittiReader
{
public:
    KittiReader(const KittiReaderParams& p);
    bool read(std::vector<cv::Mat>& imgs);
    void getImageWidthHeight(size_t stream_idx, uint32_t& width, uint32_t& height);
    ~KittiReader();
private:
    KittiReaderParams m_p;
    std::vector<cv::VideoCapture> m_captures;

};
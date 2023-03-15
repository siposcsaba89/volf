#include "kitti_reader.h"

KittiReader::KittiReader(const KittiReaderParams& p)
    :m_p(p)
{
    m_captures.resize(p.img_source_left.size());
    for (size_t i = 0; i < m_captures.size(); ++i)
    {
        if (!m_captures[i].open(m_p.img_source_left[i]))
        {
            std::cout << "Cannot open imgage source: " << m_p.img_source_left[i] << std::endl;
            throw std::runtime_error("Failed to open image source");
        }
    }
}

bool KittiReader::read(std::vector<cv::Mat>& imgs)
{
    bool succ = true;
    imgs.resize(m_captures.size());
    for (size_t i = 0; i < m_captures.size(); ++i)
    {
        succ = succ && m_captures[i].read(imgs[i]);
    }
    return succ;
}

void KittiReader::getImageWidthHeight(size_t stream_idx, uint32_t& width, uint32_t& height)
{
    assert(stream_idx < m_captures.size() && "Wrong stream idx");
    if (stream_idx >= m_captures.size())
    {
        throw std::runtime_error("Wrong stream idx while getting width, height");
    }
    width = m_captures[stream_idx].get(cv::CAP_PROP_FRAME_WIDTH);
    height = m_captures[stream_idx].get(cv::CAP_PROP_FRAME_HEIGHT);
}

KittiReader::~KittiReader()
{
}

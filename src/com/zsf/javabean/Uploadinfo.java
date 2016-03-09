package com.zsf.javabean;

import java.io.File;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.javabean
 * @ 2015/10/30
 */
public class Uploadinfo
{
    private File uploadimg;
    private String uploadimgContentType;
    private String uploadimgFileName;

    public File getUploadimg()
    {
        return uploadimg;
    }

    public void setUploadimg(File uploadimg)
    {
        this.uploadimg = uploadimg;
    }

    public String getUploadimgContentType()
    {
        return uploadimgContentType;
    }

    public void setUploadimgContentType(String uploadimgContentType)
    {
        this.uploadimgContentType = uploadimgContentType;
    }

    public String getUploadimgFileName()
    {
        return uploadimgFileName;
    }

    public void setUploadimgFileName(String uploadimgFileName)
    {
        this.uploadimgFileName = uploadimgFileName;
    }

}

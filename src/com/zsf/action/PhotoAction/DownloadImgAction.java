package com.zsf.action.PhotoAction;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;
import sun.misc.BASE64Encoder;

import java.io.*;
import java.net.URLEncoder;

/**
 * Created on 2015/11/9.
 */
public class DownloadImgAction extends ActionSupport
{
    private String imgname;
    private String contentType;

    public void setImgname(String imgname)
    {
        this.imgname = imgname;
    }

    @Override
    public String execute() throws Exception
    {
        return SUCCESS;
    }

    public String getContentType()
    {
        //返回要下载的文件类型
        return ServletActionContext.getServletContext().getMimeType(imgname);
    }

    public InputStream getInputStream() throws FileNotFoundException
    {
        File file = new File(ServletActionContext.getServletContext().getRealPath("/uploadimg/") + imgname);

        return new FileInputStream(file);
    }

    public String getImgname() throws IOException
    {
        String agent = ServletActionContext.getRequest().getHeader("User-Agent");
        return encodeDownloadFilename(imgname, agent);
    }

    /**
     * 下载文件时，针对不同浏览器，进行附件名的编码
     * @param filename 下载文件名
     * @param agent 客户端浏览器
     * @return 编码后的下载附件名
     * @throws IOException
     */
    public String encodeDownloadFilename(String filename, String agent) throws IOException
    {
        if(agent.contains("Firefox"))
        {
            // 火狐浏览器
            filename = "=?UTF-8?B?" + new BASE64Encoder().encode(filename.getBytes("utf-8"))+"?=";
        }else
        {
            // IE及其他浏览器
            filename = URLEncoder.encode(filename,"utf-8");
        }
        return filename;
    }
}

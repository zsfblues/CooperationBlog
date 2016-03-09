package com.zsf.action.mylifeaction;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.struts2.ServletActionContext;

import java.io.File;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.mylifeaction
 * @ 2015/11/2
 */
public class ShowUploadImgAction extends ActionSupport
{
    private String imgsrc;

    public String getImgsrc()
    {
        return imgsrc;
    }

    public void setImgsrc(String imgsrc)
    {
        this.imgsrc = imgsrc;
    }

    @Override
    public String execute() throws Exception
    {

        File file = new File(ServletActionContext.getServletContext().getRealPath("/sharelifeimg/" + ServletActionContext.getRequest().getParameter("imgsrc")));

        if (!file.exists())
        {
            this.setImgsrc(null);
        }
        return SUCCESS;
    }
}

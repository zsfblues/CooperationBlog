package com.zsf.action.mylifeaction;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;
import javax.xml.transform.Source;
import java.io.File;

/**
 * @ 周盛帆
 * @ CooperationBlog
 * @ com.zsf.action.mylifeaction
 * @ 2015/10/31
 */
public class UploadShareImgAction extends ActionSupport
{
    //封装上传文件属性(缺一不可)
    private File lifeimg;
    private String lifeimgContentType;
    private String lifeimgFileName;
    private String newFileName;

    public String getNewFileName()
    {
        return newFileName;
    }

    public void setLifeimg(File lifeimg)
    {
        this.lifeimg = lifeimg;
    }

    public File getLifeimg()
    {
        return lifeimg;
    }

    public void setLifeimgContentType(String lifeimgContentType)
    {
        this.lifeimgContentType = lifeimgContentType;
    }

    public void setLifeimgFileName(String lifeimgFileName)
    {
        this.lifeimgFileName = lifeimgFileName;
    }

    @Override
    public String execute() throws Exception
    {
        HttpSession session = ServletActionContext.getRequest().getSession();

        if (session.getAttribute( (String)session.getAttribute("userId")) == null)
        {
            session.setAttribute((String) session.getAttribute("userId"), System.currentTimeMillis());
        }

        //创建目录存放临时上传的图片,以便用户放弃发表后将图片删除
        session.setAttribute("tempflag", "true");

        //文件夹名构成：用户邮箱地址 + 系统时间(毫秒级)
        File imgFile = new File( ServletActionContext.getServletContext().getRealPath("/sharelifeimg/") + session.getAttribute("myemail") + session.getAttribute((String)session.getAttribute("userId")) );

        if ( !imgFile.exists())
        {
            imgFile.mkdir();
        }

        //重命名上传的图片名以便区分同一个名字的图片
        newFileName = System.currentTimeMillis() + this.lifeimgFileName;

        //将源文件复制到目标文件目录下
        String copyAbsolutePath = imgFile.getAbsolutePath() + "/" + newFileName;
        newFileName = session.getAttribute("myemail").toString() + session.getAttribute( (String)session.getAttribute("userId")) + "/" + newFileName;

        File destFile = new File(copyAbsolutePath);
        FileUtils.copyFile(this.lifeimg, destFile);

        return SUCCESS;
    }
}
